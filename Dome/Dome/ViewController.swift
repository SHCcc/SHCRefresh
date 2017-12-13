
//
//  ViewController.swift
//  Demo
//
//  Created by 邵焕超 on 2017/12/6.
//  Copyright © 2017年 邵焕超. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let btn = UIButton()
  override func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
  }
}

extension ViewController {
  fileprivate func buildUI() {
    view.addSubview(btn)
    buildSubView()
    buildLayout()
  }
  
  private func buildSubView() {
    btn.setTitle("点击", for: .normal)
    btn.backgroundColor = UIColor.blue
    btn.addTarget(self,
                  action: #selector(btnEvent),
                  for: .touchUpInside)
  }
  
  private func buildLayout() {
    btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
  }
}


extension ViewController {
  @objc func btnEvent() {
    navigationController?.pushViewController(testViewController(), animated: true)
  }
}
