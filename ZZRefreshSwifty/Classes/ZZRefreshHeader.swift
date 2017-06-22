//
//  ZZRefreshHeader.swift
//  ZZRefreshSwifty
//
//  Created by vinsent on 2017/4/12.
//  Copyright © 2017年 vint. All rights reserved.
//

private let refreshHeight: CGFloat = 44

enum RefreshStatue: Int {
  case Normal = 0     //默认状态
  case Pulling        //准备刷新状态
  case Refreshing     //正在刷新状态
}

import UIKit
//import SnapKit

public class ZZRefreshHeader: UIControl {
  
  private lazy var arrowIcon: UIImageView = UIImageView(image: UIImage(named: "arrow_icon"))
  private lazy var tipLabel: UILabel = {
    let lb = UILabel()
    lb.text = "下拉刷新"
    lb.textColor = .orange
    lb.font = UIFont.systemFont(ofSize: 14)
    return lb
  }()
  private lazy var indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
  private lazy var backView = UIImageView(image: UIImage())
  
  private var scrollView: UIScrollView?
  private var scrollViewOriginalInset:UIEdgeInsets!
  
  var refreshStatue: RefreshStatue = .Normal {
    didSet {
      switch refreshStatue {
      case .Normal:
        //        arrowIcon.isHidden = true
        //        tipLabel.text = "下拉刷新"
        //        indicator.stopAnimating()
        //刷新结束之后调整contentInset.top 判断如果上一次的刷新状态是 Refreshing状态 才减去高度
        if oldValue == .Refreshing {
          UIView.animate(withDuration: 0.5, animations: {
            self.scrollView!.contentInset.top = self.scrollView!.contentInset.top - refreshHeight
          })
        }
        
        //        UIView.animate(withDuration: 0.25, animations: {
        //          self.arrowIcon.transform = CGAffineTransform.identity
        //        })
        stopViewAnimation()
      case .Pulling:
        //        arrowIcon.isHidden = true
        //        tipLabel.text = "松手刷新"
        //        indicator.stopAnimating()
        UIView.animate(withDuration: 0.25, animations: {
          self.arrowIcon.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
        })
      case .Refreshing:
        tipLabel.text = "正在刷新"
        arrowIcon.isHidden = true
        indicator.startAnimating()
        //刷新的时候修改scrollView的contentInset
        UIView.animate(withDuration: 0.25, animations: {
          self.scrollView!.contentInset.top = self.scrollViewOriginalInset.top + refreshHeight
          self.scrollView?.setContentOffset(CGPoint(x: 0, y: -self.scrollView!.contentInset.top), animated: false)
        })
        startViewAnimation()
        self.sendActions(for: .valueChanged)
      }
    }
  }
  
  
  convenience init(refreshingTarget target: Any, refreshingAction action: Selector) {
    self.init()
    self.addTarget(target, action: action, for: .valueChanged)
  }
  
  
  func beginRefreshing() {
    self.refreshStatue = .Refreshing
  }
  
  
  public func endRefreshing() {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: { 
      self.refreshStatue = .Normal
    })
  }
  
  public func isRefreshing() -> Bool {
    return self.refreshStatue == .Refreshing
  }
  
  override init(frame: CGRect) {
    let rect = CGRect(x: 0, y: -refreshHeight, width: UIScreen.main.bounds.width, height: refreshHeight)
    super.init(frame: rect)
    
    setupSubViews()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    let offsetY = scrollView?.contentOffset.y ?? 0
    let targetY: CGFloat = -(scrollView!.contentInset.top + refreshHeight)
    if scrollView!.isDragging {
      if  refreshStatue == .Normal && offsetY < targetY {
        //小于 处于准备刷新状态
        refreshStatue = .Pulling
      } else if refreshStatue == .Pulling && offsetY > targetY {
        //大于 默认状态
        refreshStatue = .Normal
      }
    } else {
      if refreshStatue == .Pulling {
        refreshStatue = .Refreshing
      }
    }
  }
  
  override public func willMove(toSuperview newSuperview: UIView?) {
    super.willMove(toSuperview: newSuperview)
    if let fatherView = newSuperview as? UIScrollView {
      
      //记录初始contentInset
      scrollViewOriginalInset = fatherView.contentInset
      //如果父视图是滚动视图  就监听contentOffset
      //移除旧的监听
      self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
      
      self.scrollView = fatherView
      fatherView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
  }
  
  let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 40, height: 40))
  
  private func startViewAnimation() {
//    let id = UIImage(contentsOfFile: "Classes/Resource/sun_00073")
    imageView.image = UIImage(named: "sun_00073")
    let images = (51...99).map({"sun_000\($0)"}).map({UIImage(named:$0)!})
    imageView.animationImages = images
    imageView.animationDuration = Double(images.count) * 0.02
    imageView.animationRepeatCount = 0
    imageView.startAnimating()
  }
  
  func stopViewAnimation() {
    imageView.stopAnimating()
  }
  
  private func setupSubViews() {
    
    //    addSubview(backView)
    //    addSubview(tipLabel)
    //    addSubview(indicator)
    //    addSubview(arrowIcon)
    //    indicator.color = UIColor.orange
    //    
    //    backView.snp.makeConstraints { (make) in
    //      make.left.right.bottom.equalTo(self)
    //    }
    //    
    //    
    //    tipLabel.snp.makeConstraints { (make) in
    //      make.centerX.equalTo(self).offset(10)
    //      make.centerY.equalTo(self)
    //    }
    //    
    //    //不动画的时候是隐藏
    //    indicator.snp.makeConstraints { (make) in
    //      make.centerY.equalTo(self)
    //      make.right.equalTo(tipLabel.snp.left).offset(-5)
    //    }
    //    
    //    arrowIcon.snp.makeConstraints { (make) in
    //      make.center.equalTo(indicator)
    //    }
    
    imageView.frame = CGRect(origin: self.center, size: CGSize(width: 40, height: 40))

    addSubview(imageView)
//    imageView.snp.makeConstraints { (make) in
//      make.center.equalTo(self)
//      make.width.height.equalTo(40)
//    }
  }
  
  deinit {
    self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
  }
  
  
  
}
