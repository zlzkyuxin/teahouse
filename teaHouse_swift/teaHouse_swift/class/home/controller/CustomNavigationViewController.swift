//
//  CustomNavigationViewController.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/1.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: HomeViewController.self) ||
           viewController.isKind(of: StoreViewController.self) ||
           viewController.isKind(of: TeaViewController.self) ||
           viewController.isKind(of: UserCenterViewController.self) {
            
        }else {
            viewController.hidesBottomBarWhenPushed = true
        }
        if (UIDevice.current.systemVersion as NSString).floatValue >= 8.0 {
            viewController.automaticallyAdjustsScrollViewInsets = false
        }
        if self.viewControllers.count > 0 {
            let item = UIBarButtonItem(image: UIImage(named:"navi_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(popViewController(animated:)))
            viewController.navigationItem.leftBarButtonItem = item
        }
        super.pushViewController(viewController, animated: animated)
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
