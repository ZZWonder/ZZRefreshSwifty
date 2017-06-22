//
//  ViewController.swift
//  ZZRefreshSwifty
//
//  Created by rain-star on 06/21/2017.
//  Copyright (c) 2017 rain-star. All rights reserved.
//

import UIKit
import ZZRefreshSwifty
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      let bb = UIButton()
      bb.setTitle("跳转", for: .normal)
      bb.backgroundColor = .red
      view.addSubview(bb)
      bb.snp.makeConstraints { (make) in
        make.center.equalTo(view)
      }
      bb.addTarget(self, action: #selector(pushTotable), for: .touchUpInside)
  }
  
  func pushTotable() {
    let tab = ZZTableViewController()
    self.present(tab, animated: true) { 
      print("跳转成功")
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

