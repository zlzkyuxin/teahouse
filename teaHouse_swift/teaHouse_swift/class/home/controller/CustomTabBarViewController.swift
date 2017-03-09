//
//  CustomTabBarViewController.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/1.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController,UITabBarControllerDelegate {
    var homeViewController:HomeViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.addChild()
    }
    
    func addChild() {
        homeViewController = HomeViewController()
        self.addChild(View: homeViewController, title: "首页", image: "icon_tab1_normal", selectedImage: "icon_tab1_selected")
        self.addChild(View: StoreViewController(), title: "商城", image: "icon_tab2_normal", selectedImage: "icon_tab2_selected")
        self.addChild(View: TeaViewController(), title: "文化", image: "icon_tab3_normal", selectedImage: "icon_tab3_selected")
        self.addChild(View: UserCenterViewController(), title: "用户", image: "icon_tab4_normal", selectedImage: "icon_tab4_selected")
        self.selectedIndex = 0
    }
    
    func addChild(View: UIViewController, title: String, image: String, selectedImage: String) {
        View.navigationItem.title = title
        View.tabBarItem.title = title
        
        View.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 11), NSForegroundColorAttributeName : UIColor.black], for: UIControlState.normal)
        View.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 11), NSForegroundColorAttributeName : UIColor.orange], for: UIControlState.selected)
        
        View.tabBarItem.image = UIImage(named:image)
        View.tabBarItem.selectedImage = UIImage(named:selectedImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let navigationController = CustomNavigationViewController(rootViewController:View)
        self.addChildViewController(navigationController)
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
