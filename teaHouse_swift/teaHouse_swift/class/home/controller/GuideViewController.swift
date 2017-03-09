//
//  GuideViewController.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/2/28.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController,UIScrollViewDelegate {
    var _scrollView:UIScrollView!
    var leftImageView:UIImageView!
    var centerImageView:UIImageView!
    var rightImageView:UIImageView!
    var pageControl:UIPageControl!
    var currentImageIdex:Int!
    var imageCount:Int!
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.loadImageData()//加载图片数据
        self.addScrollView()//添加滚动视图
        self.addImageViews()//添加图片视图
        self.addPageControl()//添加分页控件
        self.setDefaultImage()//设置默认图片
    }
    //加载图片数据
    func loadImageData() {
        imageCount = 3
    }
    //添加滚动视图
    func addScrollView() {
        _scrollView = UIScrollView(frame: UIScreen.main.bounds)
        _scrollView.delegate = self
        _scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH * 3, height: SCREEN_HEIGHT)
        _scrollView.setContentOffset(CGPoint(x: SCREEN_WIDTH, y: 0), animated: false)
        _scrollView.isPagingEnabled = true
        _scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(_scrollView)
    }
    //添加图片视图
    func addImageViews() {
        leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        leftImageView.contentMode = UIViewContentMode.scaleAspectFit
        _scrollView.addSubview(leftImageView)
        
        centerImageView = UIImageView(frame: CGRect(x:SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        centerImageView.contentMode = UIViewContentMode.scaleAspectFit
        centerImageView.isUserInteractionEnabled = true
        let tag:UITapGestureRecognizer = UITapGestureRecognizer(target: self
            , action: #selector(GuideViewController.touchesBegan as (GuideViewController) -> () -> ()))
        centerImageView.addGestureRecognizer(tag)
        _scrollView.addSubview(centerImageView)
        
        rightImageView = UIImageView(frame: CGRect(x: SCREEN_WIDTH * 2, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        rightImageView.contentMode = UIViewContentMode.scaleAspectFit
        _scrollView.addSubview(rightImageView)
    }
    //设置默认图片
    func setDefaultImage() {
        leftImageView.image = UIImage(named:String(imageCount-1)+".png")
        centerImageView.image = UIImage(named:String(0)+".png")
        rightImageView.image = UIImage(named:String(1)+".png")
        currentImageIdex = 0
        pageControl.currentPage = currentImageIdex
    }
    //添加图片视图
    func addPageControl() {
        pageControl = UIPageControl()
        let size = pageControl.size(forNumberOfPages: imageCount)
        pageControl.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        pageControl.center = CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT - 100)
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.numberOfPages = imageCount
        self.view.addSubview(pageControl)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.reloadImage()
        _scrollView.setContentOffset(CGPoint(x:SCREEN_WIDTH, y:0), animated: false)
        pageControl.currentPage = currentImageIdex
    }
    
    func reloadImage() {
        var leftImageIndex:Int!
        var rightImageIndex:Int!
        let offset = _scrollView.contentOffset
        if offset.x > SCREEN_WIDTH {
            currentImageIdex = (currentImageIdex + 1) % imageCount
        }else if offset.x < SCREEN_WIDTH {
            currentImageIdex = (currentImageIdex + imageCount - 1) % imageCount
        }
        centerImageView.image = UIImage(named:String(currentImageIdex)+".png")
        leftImageIndex = (currentImageIdex + imageCount - 1) % imageCount
        rightImageIndex = (currentImageIdex + 1) % imageCount
        leftImageView.image = UIImage(named:String(leftImageIndex)+".png")
        rightImageView.image = UIImage(named:String(rightImageIndex)+".png")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        timer.invalidate()
    }
    
    func touchesBegan() {
        if (UserDefaults.standard.string(forKey: "islogin") == nil) {
            UIApplication.shared.windows.last?.rootViewController = CustomTabBarViewController()
        }else {
            UIApplication.shared.windows.last?.rootViewController = LoginViewController()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
