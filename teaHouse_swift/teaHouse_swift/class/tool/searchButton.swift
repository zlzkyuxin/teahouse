//
//  searchButton.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/1.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit

class searchButton: UIButton {

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 5, y: 5, width: 20, height: 20)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX = (self.imageView?.frame.size.width)! + 10
        let titleW = contentRect.size.width - (self.imageView?.frame.width)! - 10
        return CGRect(x: titleX, y: 5, width: titleW, height: 20)
    }
}


    
