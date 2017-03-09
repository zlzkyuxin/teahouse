//
//  YXButton.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/1.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit

class YXButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        self.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageH = contentRect.size.height * 2 / 3
        let imageW = imageH
        let imageX = (contentRect.size.width - imageW) / 2
        return CGRect(x: imageX, y: 0, width: imageW, height: imageH)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleY = contentRect.size.height * 2 / 3
        let titleW = contentRect.size.width
        let titleH = contentRect.size.height / 3
        return CGRect(x: 0, y: titleY, width: titleW, height: titleH)
    }
}
