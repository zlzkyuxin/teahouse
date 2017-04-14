//
//  HotGoodsModel.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/2.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit

class HotGoodsModel: NSObject {
    var goodsID:String?//商品ID
    var goodsName:String?//商品名
    var content:String?//商品简介
    var beforePrice:String?//商品原价
    var nowPrice:String?//商品现价
    var detailsImageName:String?//图片
    var categoryName:String?//所属类别
    
    override internal var description: String {
        return "{goodsID: \(String(describing: goodsID))  \n goodsName:\(String(describing: goodsName)) \n content: \(String(describing: content)) \n beforePrice: \(String(describing: beforePrice)) \n nowPrice: \(String(describing: nowPrice)) \n detailsImageName: \(String(describing: detailsImageName)) \n categoryName: \(String(describing: categoryName)) \n}"
    }
}
