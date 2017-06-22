//
//  ZZTableViewController.swift
//  ZZRefreshSwifty
//
//  Created by vinsent on 2017/6/22.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import ZZRefreshSwifty

class ZZTableViewController: UITableViewController {
  
  var dataList:[String]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray
    
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    //        self.tableView.zz_addRefreshTarget(self, action: #selector(refreshData))
    
    dataList = ["桃花山下桃花庵","桃花庵中桃花仙","桃花庵前中桃树","又摘桃花卖酒钱"]
    
    self.tableView.zz_header = ZZRefreshHeader()
    
    self.tableView.zz_header.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    
  }
  
  
  func refreshData() {
    print("请求接口")
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
      self.tableView.zz_header.endRefreshing()
      print("结束刷新")
    }
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return dataList.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    
    cell.textLabel?.text = dataList[indexPath.row]
    
    return cell
  }
  
  
  
  
}
