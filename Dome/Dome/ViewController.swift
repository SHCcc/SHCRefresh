
//
//  ViewController.swift
//  Demo
//
//  Created by 邵焕超 on 2017/12/6.
//  Copyright © 2017年 邵焕超. All rights reserved.
//

import UIKit
import SHCRefresh

class ViewController: UIViewController {
  var items = ["item0", "item1", "item2"]//,
//               "item3", "item4", "item5",
//               "item6", "item7", "item8",
//               "item9", "item10", "item11" ]
  
  let tableView = UITableView()
//  var refreshView: Refresh?
  override func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
  }
}

extension ViewController {
  fileprivate func buildUI() {
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
  }
}


extension ViewController {
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


extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
}


