//
//  HomeViewController.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/1.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class HomeViewController: UIViewController,TopViewDelegate,UIScrollViewDelegate {
    var topView:TopView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.replaceNavigationBar()
        self.loadHomeData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func replaceNavigationBar() {
        topView = TopView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        topView.backgroundColor = UIColor.clear
        topView.delegate = self
        self.view.addSubview(topView)
    }
    
    func loadHomeData() {
        let parames = ["key":"showHome"]
        TeaHouseNetWorking.shared.post("Home.php", parameters: parames, success: { (task, responseObject) in
            print(responseObject!)
            let model =  HotGoodsModel.mj_object(withKeyValues: responseObject)
            print(model!)
        }) { (task, error) in
            
        }
    }
    
    //topView的代理方法
    func scanBtnClick() {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if (device != nil) {
            let status = PHPhotoLibrary.authorizationStatus()
            if status == PHAuthorizationStatus.restricted {
                print("无法访问相册")
            } else if status == PHAuthorizationStatus.denied {
                print("用户拒绝访问")
            } else if status == PHAuthorizationStatus.authorized {
                print("用户允许访问")
                self.present(ScanViewController(), animated: true, completion: nil)
            } else if status == PHAuthorizationStatus.notDetermined {
                print("用户没有选择")
                PHPhotoLibrary.requestAuthorization({ (status) in
                    self.present(ScanViewController(), animated: true, completion: nil)
                })
            }
            
        }
        
    }
    
    func searchBtnClcik() {
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    func noticeBtnClick() {
        self.navigationController?.pushViewController(NoticeViewController(), animated: true)
    }
    
    func voiceBtnClick() {
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
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
