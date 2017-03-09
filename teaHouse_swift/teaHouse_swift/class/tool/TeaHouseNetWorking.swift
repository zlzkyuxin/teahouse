//
//  TeaHouseNetWorking.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/2.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit
import AFNetworking

//public extension DispatchQueue {
//    private static var onceToken = [String]()
//    public class func once(_ token: String, _ block:@escaping () -> Void) {
//        objc_sync_enter(self)
//        defer {
//            objc_sync_exit(self)
//        }
//        if onceToken.contains(token) {
//            return
//        }
//        onceToken.append(token)
//        block()
//    }
//
//}

class TeaHouseNetWorking: AFHTTPSessionManager {
//    let ShopDetailsURL = "http://192.168.1.119:8888/TeaAPP/images/original/"
//    let ImageURL = "http://192.168.1.119:8888/TeaAPP/images/"
    
    static let shared: TeaHouseNetWorking = {
        let baseUrl = NSURL(string: "http://192.168.1.119:8888/TeaAPP/")
        let manager = TeaHouseNetWorking.init(baseURL: baseUrl as URL!, sessionConfiguration: URLSessionConfiguration.default)
        
        manager?.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain", "text/html") as? Set<String>
        
        return manager!
    }()
    
}

    
    
    
    
    
    
    
    
    
    
    

