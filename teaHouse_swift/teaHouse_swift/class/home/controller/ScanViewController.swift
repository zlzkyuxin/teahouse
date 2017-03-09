//
//  ScanViewController.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/2.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit

class ScanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var rootVC = self.presentingViewController
        while ((rootVC?.presentingViewController) != nil) {
            rootVC = rootVC?.presentingViewController
        }
        rootVC?.dismiss(animated: true, completion: nil)
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
