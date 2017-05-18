//
//  TeaHouseNetWorking.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/2.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit
import AFNetworking

let BaseUrl = "http://119.29.196.89/TeaAPP/"

class TeaHouseNetWorking: AFHTTPSessionManager {
//    let ShopDetailsURL = "http://192.168.1.119:8888/TeaAPP/images/original/"
//    let ImageURL = "http://192.168.1.119:8888/TeaAPP/images/"
    
    static let shared: TeaHouseNetWorking = {
        let baseUrl = NSURL(string: "http://10.37.26.26/TeaAPP/")
        let manager = TeaHouseNetWorking.init(baseURL: baseUrl as URL!, sessionConfiguration: URLSessionConfiguration.default)
        
        manager?.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain", "text/html") as? Set<String>
        
        return manager!
    }()
    
    class func post(_ URLString: String!, parameters: Any, complete:
        @escaping ((_ error: Bool, _ responseObject: Any?) -> Void)){
        let url = BaseUrl + URLString
        let manager: AFHTTPSessionManager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"text/html","text/plain","application/json","text/json","text/javascript") as! Set<AnyHashable>
        manager.requestSerializer.timeoutInterval = 10
        manager.post(url, parameters: parameters, success: { (task, responseObject) in
            complete(true,responseObject)
        }) { (task, error) in
            if (error != nil) {
                complete(false,nil)
            }
        }
    }
    
}

    
    
    
    
    
    
    
    
    
    
    

