//
//  LETestTableViewCell.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/4/9.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit

class LENewTableViewCell: UITableViewCell {
    var nameLabel:UILabel?
    var iconView:UIImageView?
    var contentLabel:UILabel?
    var timeLabel:UILabel?
    var likeBtn:UIButton?
    var commentBtn:UIButton?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    //MARK: 设置UI
    func setUpUI()  {
        self.nameLabel = UILabel.init()
        self.nameLabel?.backgroundColor = UIColor.clear
        self.nameLabel?.textColor = UIColor.darkGray
        self.nameLabel?.font = UIFont.systemFont(ofSize: 15)
        self.nameLabel?.textAlignment = NSTextAlignment.left
        
        self.iconView = UIImageView()
        self.iconView?.backgroundColor = UIColor.white
        iconView?.layer.cornerRadius = 15
        iconView?.layer.masksToBounds = true
        
        self.contentLabel = UILabel()
        self.contentLabel?.backgroundColor = UIColor.clear
        self.contentLabel?.textColor = UIColor.darkGray
        self.contentLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentLabel?.textAlignment = NSTextAlignment.left
        self.contentLabel?.numberOfLines = 0
        self.contentLabel?.sizeToFit()
        
        self.timeLabel = UILabel()
        self.timeLabel?.backgroundColor = UIColor.clear
        self.timeLabel?.textColor = UIColor.gray
        self.timeLabel?.font = UIFont.systemFont(ofSize: 15)
        self.timeLabel?.textAlignment = NSTextAlignment.right
        
        self.likeBtn = UIButton(type: .custom)
        self.likeBtn?.setImage(UIImage(named: "like"), for: .normal)
        self.likeBtn?.imageView?.contentMode = .scaleAspectFit
        self.likeBtn?.adjustsImageWhenDisabled = false
        self.likeBtn?.adjustsImageWhenHighlighted = false
        self.likeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.likeBtn?.setTitleColor(UIColor.lightGray, for: .normal)
        
        
        self.commentBtn = UIButton(type: .custom)
        self.commentBtn?.setImage(UIImage(named: "comment"), for: .normal)
        self.commentBtn?.imageView?.contentMode = .scaleAspectFit
        self.commentBtn?.adjustsImageWhenDisabled = false
        self.commentBtn?.adjustsImageWhenHighlighted = false
        self.commentBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.commentBtn?.setTitleColor(UIColor.lightGray, for: .normal)
        
        
        //setData()
        
        self.addSubview(nameLabel!)
        self.addSubview(iconView!)
        self.addSubview(contentLabel!)
        self.addSubview(timeLabel!)
        self.addSubview(likeBtn!)
        self.addSubview(commentBtn!)
        
        setSubViewsLayout(nameLabel: self.nameLabel!, iconView: self.iconView!,contentLabel: self.contentLabel!,timeLabel: self.timeLabel!, likeBtn: self.likeBtn!, commentBtn: self.commentBtn!)
    }
    
    func setSubViewsLayout(nameLabel: UILabel, iconView: UIImageView, contentLabel: UILabel, timeLabel: UILabel, likeBtn: UIButton, commentBtn: UIButton)  {
        iconView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(margin)
            make.width.height.equalTo(iconWH)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(margin)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom)
            make.left.equalTo(iconView)
            make.width.equalTo(screenW-margin)
            make.height.equalTo(110)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(halfMargin)
            make.right.equalToSuperview().offset(-1*margin)
            make.width.equalTo(nameLabel)
            make.height.equalTo(20)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom).offset(halfMargin)
            make.left.equalTo(iconView)
            make.width.equalTo((screenW-2*margin)/2)
            make.height.equalTo(20)
        }
        
        commentBtn.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(likeBtn)
            make.left.equalTo(likeBtn.snp.right)
        }
        
    }
    
    //MARK:  自带
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
