//
//  HomeTableViewCell.swift
//  teaHouse_swift
//
//  Created by zlzk on 2017/4/14.
//  Copyright © 2017年 yuxin. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    //
    var goodsImage:UIImageView!
    var categoryLabel:UILabel!
    var contentLabel:UILabel!
    var goodsNameLabel:UILabel!
    var nowPriceLabel:UILabel!
    var beforePriceLabel:UILabel!
    //
    var cellHeight: CGFloat?
    var newModel: HotGoodsModel!
    var model: HotGoodsModel {
        set {
            self.newModel = newValue
            self.setData()
            self.setFrame()
        }
        get {
            return self.newModel
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public static func cellWithTableView(tableView: UITableView, style:UITableViewCellStyle) -> HomeTableViewCell {
        let ID:String = "HomeTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = HomeTableViewCell(style: style, reuseIdentifier: ID)
        }
        return cell as! HomeTableViewCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView()
    }
    
    func initView() {
        self.selectionStyle = UITableViewCellSelectionStyle.none
        //图片
        let goodsImageView: UIImageView = UIImageView()
        self.goodsImage = goodsImageView
        self.contentView.addSubview(goodsImageView)
        //类别标签
        let categoryLabel: UILabel = UILabel()
        self.categoryLabel = categoryLabel
        self.contentView.addSubview(categoryLabel)
        //简介
        let contentLabel: UILabel = UILabel()
        self.contentLabel = contentLabel
        self.contentView.addSubview(contentLabel)
        //商品名
        let goodsNameLabel: UILabel = UILabel()
        self.goodsNameLabel = goodsNameLabel
        self.contentView.addSubview(goodsNameLabel)
        //商品现价
        let nowPriceLabel: UILabel = UILabel()
        self.nowPriceLabel = nowPriceLabel
        self.contentView.addSubview(nowPriceLabel)
        //商品原价
        let beforePriceLabel: UILabel = UILabel()
        self.beforePriceLabel = beforePriceLabel
        self.contentView.addSubview(beforePriceLabel)
    }
    
    func setData() {
        print(newModel.goodsID!)
        
        self.goodsImage.sd_setImage(with: NSURL(string: "http://10.37.26.26/TeaAPP/images/original/\(model.detailsImageName!).png")! as URL)
        
        self.categoryLabel.text = model.categoryName
        self.categoryLabel.font = UIFont.systemFont(ofSize: 11)
        self.categoryLabel.backgroundColor = UIColor.gray
        self.categoryLabel.textColor = UIColor.white
        self.categoryLabel.adjustsFontSizeToFitWidth = true
        
        self.contentLabel.text = model.content
        self.contentLabel.numberOfLines = 0
        self.contentLabel.adjustsFontSizeToFitWidth = true
        self.contentLabel.minimumScaleFactor = 0.6
        self.contentLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.goodsNameLabel.text = model.goodsName
        self.goodsNameLabel.textColor = UIColor.lightGray
        self.goodsNameLabel.font = UIFont.systemFont(ofSize: 12)
        
        if model.nowPrice != nil {
            self.beforePriceLabel.isHidden = false
            
            self.nowPriceLabel.text = model.nowPrice
            self.nowPriceLabel.adjustsFontSizeToFitWidth = true
            self.nowPriceLabel.textColor = UIColor.red
            
            let att = NSMutableAttributedString(string:model.beforePrice!)
            att.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(value: 1), range: NSMakeRange(0, 3))
            
            
            self.beforePriceLabel.attributedText = att
            self.beforePriceLabel.sizeToFit()
            self.beforePriceLabel.adjustsFontSizeToFitWidth = true
            
        }else {//无现价数据，现价显示原价数据
            self.beforePriceLabel.isHidden = true
            self.nowPriceLabel.text = model.beforePrice
            self.nowPriceLabel.textColor = UIColor.black
            self.nowPriceLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    func setFrame() {
        //图片
        self.goodsImage.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)
            make?.right.equalTo()(self.contentView)
            make?.top.equalTo()(self.contentView)
            make?.height.setOffset(SCREEN_HEIGHT / 3.5)
        }
        //类别标签
        self.categoryLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.contentView)?.setOffset(5)
            make?.height.setOffset(11)
        }
        //简介
        let size:CGSize = model.content!.boundingRect(with: CGSize(width: 304, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)] , context: nil).size;//计算文字宽高
        self.contentLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(8)
            make?.right.equalTo()(self.contentView)?.setOffset(-8)
            make?.top.equalTo()(self.goodsImage.mas_bottom)?.setOffset(8)
            make?.height.setOffset(size.height)
        }
        //商品名
        self.goodsNameLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(8)
            make?.top.equalTo()(self.contentLabel.mas_bottom)?.setOffset(8)
            make?.right.equalTo()(self.contentView)?.setOffset(-8)
            make?.height.setOffset(12)
        }
        //商品现价
        self.nowPriceLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(8)
            make?.top.equalTo()(self.goodsNameLabel.mas_bottom)?.setOffset(8)
            make?.height.setOffset(15)
        }
        //商品原价
        self.beforePriceLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.nowPriceLabel.mas_right)?.setOffset(8)
            make?.top.equalTo()(self.nowPriceLabel)
            make?.height.setOffset(15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
