//
//  UITableView+Refresh.swift
//  Pods-Demo
//
//  Created by 邵焕超 on 2017/12/9.
//

import UIKit
import SHCRefresh

public extension UITableView {
  private static let refreshKey = UnsafeRawPointer(bitPattern: "refreshView".hashValue)!
  
  public var refreshView: Refresh? {
    get{
      return objc_getAssociatedObject(self,
                                      UITableView.refreshKey) as? Refresh
    } set{
      if let view = newValue {
        objc_setAssociatedObject(self,
                                 UITableView.refreshKey,
                                 view,
                                .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.addSubview(newValue!)
      }
    }
  }
  
  public func endRefreshing() {
    self.refreshView?.end()
  }
}
