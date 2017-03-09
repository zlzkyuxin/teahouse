//
//  TopView.swift
//  teaHouse_swift
//
//  Created by yuxin on 2017/3/1.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit

protocol TopViewDelegate {
    func scanBtnClick()
    func noticeBtnClick()
    func searchBtnClcik()
    func voiceBtnClick()
}

class TopView: UIView {
    var delegate:TopViewDelegate!
    var scanBtn:YXButton!
    var noticeBtn:YXButton!
    var searchView:UIView!
    var searchBtn:searchButton!
    var voiceBtn:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.initView()
        self.setBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView() {
        //扫描按钮
        scanBtn = YXButton()
        scanBtn.tag = 1000
        scanBtn.addTarget(self, action: #selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(scanBtn)
        //消息
        noticeBtn = YXButton()
        noticeBtn.tag = 1001
        noticeBtn.addTarget(self, action: #selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(noticeBtn)
        //搜索块
        searchView = UIView()
        searchView.layer.cornerRadius = 4.0
        searchView.layer.masksToBounds = true
        searchView.backgroundColor = UIColor(red: 232, green: 222, blue: 223, alpha: 1)
        self.addSubview(searchView)
        //搜索按钮
        searchBtn = searchButton()
        searchBtn.tag = 1002
        searchBtn.addTarget(self, action: #selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
        //语言按钮
        voiceBtn = UIButton()
        voiceBtn.tag = 1003
        voiceBtn.addTarget(self, action: #selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
        
        searchView.addSubview(searchBtn)
        searchView.addSubview(voiceBtn)
    }
    
    override func layoutSubviews() {
        scanBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(10)
            make?.top.equalTo()(self)?.setOffset(27)
            make?.width.setOffset(30)
            make?.height.setOffset(30)
        }
        
        noticeBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(self)?.setOffset(-10)
            make?.top.equalTo()(self)?.setOffset(27)
            make?.width.setOffset(30)
            make?.height.setOffset(30)
        }
        
        searchView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.scanBtn.mas_right)?.setOffset(10)
            make?.top.equalTo()(self)?.setOffset(25)
            make?.width.setOffset(self.frame.size.width - 100)
            make?.height.setOffset(30)
        }
        
        searchBtn.mas_makeConstraints { (make) in
            make?.left.setOffset(0)
            make?.top.setOffset(0)
            make?.right.equalTo()(self.searchView.mas_right)?.setOffset(-30)
            make?.height.setOffset(30)
        }
        
        voiceBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.searchBtn.mas_right)?.setOffset(5)
            make?.centerY.equalTo()(self.searchView.mas_centerY)?.setOffset(0)
            make?.width.setOffset(20)
            make?.height.setOffset(20)
        }
    }
    
    func setBtn() {
        scanBtn.setTitle("扫一扫", for: UIControlState.normal)
        scanBtn.setImage(UIImage(named:"scan_white"), for: UIControlState.normal)
        scanBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        noticeBtn.setTitle("消息", for: UIControlState.normal)
        noticeBtn.setImage(UIImage(named:"notice_white"), for: UIControlState.normal)
        noticeBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        voiceBtn.setImage(UIImage(named:"voice_white"), for: UIControlState.normal)
        
        searchBtn.setImage(UIImage(named:"search_white"), for: UIControlState.normal)
        searchBtn.adjustsImageWhenHighlighted = false
        searchBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        searchBtn.setTitle("wuli宝宝想你了！", for: UIControlState.normal)
        
    }
    
    func btnClick(sender:UIButton) {
        if sender.tag == 1000 {
            self.delegate.scanBtnClick()
        } else if sender.tag == 1001 {
            self.delegate.noticeBtnClick()
        } else if sender.tag == 1002 {
            self.delegate.searchBtnClcik()
        } else if sender.tag == 1003 {
            self.delegate.voiceBtnClick()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
