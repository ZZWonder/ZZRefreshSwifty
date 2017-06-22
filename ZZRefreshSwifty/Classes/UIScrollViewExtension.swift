//
//  UIScrollViewExtension.swift
//  ZZRefreshSwifty
//
//  Created by vinsent on 2017/4/12.
//  Copyright © 2017年 vint. All rights reserved.
//

import UIKit
import ObjectiveC

public extension UIScrollView {
  
  public var zz_header:ZZRefreshHeader {
    get {
      let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "zzHeader".hashValue)
      let header: ZZRefreshHeader? = objc_getAssociatedObject(self, key) as? ZZRefreshHeader
      return header!
    }
    set {
      let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "zzHeader".hashValue)
      objc_setAssociatedObject(self, key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      if !self.subviews.contains(newValue) {
        self.addSubview(newValue)
      }
    }
  }
  
//  var zz_footer:ZZRefreshFooter {
//    get {
//      let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "zzFooter".hashValue)
//      let footer: ZZRefreshFooter? = objc_getAssociatedObject(self, key) as? ZZRefreshFooter
//      return footer!
//    }
//    set {
//      let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "zzFooter".hashValue)
//      objc_setAssociatedObject(self, key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//      if !self.subviews.contains(newValue) {
//        self.addSubview(newValue)
//      }
//    }
//  }
  
}
