//
//  testViewController.swift
//  Dome
//
//  Created by 邵焕超 on 2017/12/13.
//  Copyright © 2017年 邵焕超. All rights reserved.
//

import UIKit
import SHCRefresh

class testViewController: UIViewController {
  var items = ["item0", "item1", "item2"]
  let tableView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
  }
  deinit {
    print("销毁了")
  }
}


extension testViewController {
  fileprivate func buildUI() {
    if #available(iOS 11.0, *) { self.tableView.contentInsetAdjustmentBehavior = .never
    } else { self.automaticallyAdjustsScrollViewInsets = false }
    
    view.backgroundColor = UIColor.white
    view.addSubview(tableView)
    buildSubView()
    buildLayout()
  }
  
  private func buildSubView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.showsHorizontalScrollIndicator = false
    tableView.showsVerticalScrollIndicator = false
    tableView.backgroundColor = UIColor.white
    tableView.refreshView = Refresh(vc: self, action: #selector(refresh))
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  private func buildLayout() {
    tableView.frame = view.frame
    tableView.frame.origin.y = 64
  }
}


extension testViewController {
  @objc func refresh() {
    print("睡2秒")
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000 * 2)) {
      print("睡完了")
      self.items.append("1")
      self.tableView.reloadData()
      self.tableView.endRefreshing()
    }
  }
}


extension testViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
}

