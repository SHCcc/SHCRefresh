//
//  Refresh.swift
//  Pods-Demo
//
//  Created by 邵焕超 on 2017/12/6.
//

import UIKit

public class Refresh: UIView {
  fileprivate let height: CGFloat = 44
  
  public enum State {
    case idle
    case pulling
    case refreshing
  }
  
  fileprivate var action: Selector!
  fileprivate weak var vc: UIViewController!
  fileprivate var superScrollView: UIScrollView?
  
  fileprivate var currState: State = .idle {
    didSet{
      switch currState {
      case .idle:       break
      case .pulling:    setPullingImages()
      case .refreshing: setRefreshingImages()
      }
    }
  }
  fileprivate var isStare = false
  
  fileprivate var resA: GifManager.Result!
  fileprivate var resB: GifManager.Result!
  fileprivate var resC: GifManager.Result!
  
  fileprivate let backView = UIView()
  fileprivate let imageView = UIImageView()
  fileprivate let messageLabel = UILabel()
  
  public init(vc: UIViewController, action: Selector) {
    self.vc = vc
    self.action = action
    super.init(frame: CGRect.zero)
    setImages()
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
    backView.addSubview(imageView)
  }
  
  private func buildLayout() {
    backView.frame = CGRect(x: 0, y: -height, width: UIScreen.main.bounds.size.width, height: height)
    imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
  }
}

// MARK: - delegate
extension Refresh: UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    if currState == .refreshing { return }
    if offset > -height {
      currState = .idle
      setIdleImages(offset: offset)
    }else {
      currState = .pulling
    }
  }
  
  public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if isStare { return }
    let offset = scrollView.contentOffset.y
    if offset < -height {
      currState = .refreshing
      isStare = true
      vc.perform(action)
      UIView.animate(withDuration: 0.25, animations: {
        scrollView.contentInset = UIEdgeInsets(top: self.height, left: 0, bottom: 0, right: 0)
      })
    }
  }
}

// MARK: - private function
extension Refresh {
  fileprivate func setIdleImages(offset: CGFloat) {
    if offset > 0 { return }
    imageView.stopAnimating()
    let num = CGFloat(resA.images.count) * (offset / -height)
    let item = Int(num)
    imageView.image = resA.images[item]
  }
  
  fileprivate func setPullingImages() {
    imageView.animationImages = resB.images
    imageView.animationDuration = resB.time
    imageView.animationRepeatCount = 0
    imageView.startAnimating()
  }
  
  fileprivate func setRefreshingImages() {
    imageView.animationImages = resC.images
    imageView.animationDuration = resC.time
    imageView.animationRepeatCount = 0
    imageView.startAnimating()
  }
  
  fileprivate func setImages() {
    guard let resA = GifManager.shared.images(type: .header, state: .idle, style: .car) else { return }
    guard let resB = GifManager.shared.images(type: .header, state: .pulling, style: .car) else { return }
    guard let resC = GifManager.shared.images(type: .header, state: .refreshing, style: .car) else { return }
    self.resA = resA
    self.resB = resB
    self.resC = resC
  }
}

// MARK: - open function
extension Refresh {
  public func end() {
    UIView.animate(withDuration: 0.3, animations: { [weak self] in
      guard let base = self else{ return }
      base.superScrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      base.isStare = false
      base.currState = .idle
    })
  }
}
