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

class HomeViewController: UIViewController,TopViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    var topView:TopView!
    var dataArray = [HotGoodsModel]()
    var tableView:UITableView!
    
    
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
        //头视图
        topView = TopView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        topView.backgroundColor = UIColor.gray
        topView.delegate = self
        self.view.addSubview(topView)
        //tableview
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 49), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = SCREEN_HEIGHT / 2
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeTableViewCell = HomeTableViewCell.cellWithTableView(tableView: tableView,style: UITableViewCellStyle.subtitle)
        let model : HotGoodsModel = dataArray[indexPath.row]
        cell.model = model
//        cell.textLabel?.text = model.goodsName
//        cell.detailTextLabel?.text = model.content
        return cell
    }
    
    func loadHomeData() {
        let parames = ["key":"showHome"]
        var hotModel = HotGoodsModel()
        TeaHouseNetWorking.post("Home.php", parameters: parames) { (error, responseObject) in
            let result = responseObject as! NSDictionary
            if result["code"] as! String == "200" {
                let hot = result["list"] as! NSDictionary
                for list in hot {
                hotModel = HotGoodsModel.mj_object(withKeyValues: list)
                }
            }
        }
        /*
        TeaHouseNetWorking.shared.post("Home.php", parameters: parames, success: { (task, responseObject) in
            
            let result = responseObject as! NSDictionary
            if result["code"] as! String == "200"{
                let hotGoods = result["list"] as! NSDictionary
                for list in hotGoods["HotGoods"] as! NSArray {
                    hotModel = HotGoodsModel.mj_object(withKeyValues: list)
//                    let hott = hot as! NSDictionary
//                    let model = HotGoodsModel()
//                    model.goodsID = hott["goodsID"] as? String
//                    model.goodsName = hott["goodsName"] as? String
//                    model.content = hott["content"] as? String
//                    model.beforePrice = hott["beforePrice"] as? String
//                    model.nowPrice = hott["nowPrice"] as? String
//                    model.detailsImageName = hott["detailsImageName"] as? String
//                    model.categoryName = hott["categoryName"] as? String

                    self.dataArray.append(hotModel)
                }
                self.tableView.reloadData()
            }

        }) { (task, error) in
            
        }
 */
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
    
    
    


}
