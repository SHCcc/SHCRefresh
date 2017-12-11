//
//  Refresh.swift
//  Pods-Demo
//
//  Created by 邵焕超 on 2017/12/6.
//

import UIKit

public class Refresh: UIView {
  
  fileprivate var action: Selector!
  fileprivate var vc: UIViewController!
  fileprivate var superScrollView: UIScrollView?
  
  fileprivate var isStare = false
  
  fileprivate let backView = UIView()
  fileprivate let messageLabel = UILabel()
  
  public init(vc: UIViewController, action: Selector) {
    self.vc = vc
    self.action = action
    super.init(frame: CGRect.zero)
    buildUI()
  }
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func willMove(toSuperview newSuperview: UIView?) {
    if newSuperview is UIScrollView {
      superScrollView = newSuperview as? UIScrollView
      superScrollView?.delegate = self
    }
  }
  
  
  public func end() {
    UIView.animate(withDuration: 0.3, animations: { [weak self] in
      guard let base = self else{ return }
      base.superScrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      base.isStare = false
    })
  }
}

// MARK: - UI
extension Refresh {
  fileprivate func buildUI() {
    for view in self.subviews {
      view.removeFromSuperview()
    }
    addSubview(backView)
    buildSubView()
    buildLayout()
  }
  
  private func buildSubView() {
    backView.backgroundColor = UIColor.black
    backView.alpha = 0
    backView.addSubview(messageLabel)
    messageLabel.text = "测试"
    messageLabel.textColor = UIColor.white
    messageLabel.sizeToFit()
  }
  
  private func buildLayout() {
    backView.frame = CGRect(x: 0, y: -64, width: UIScreen.main.bounds.size.width, height: 64)
    messageLabel.center = backView.center
    messageLabel.center.y = 32
  }
}


extension Refresh: UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    backView.alpha = (-offset / 60)
  }
  
  public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if isStare { return }
    let offset = scrollView.contentOffset.y
    if offset < -60 {
      isStare = true
      vc.perform(action)
      UIView.animate(withDuration: 0.25, animations: {
        scrollView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
      })
    }
  }
}
