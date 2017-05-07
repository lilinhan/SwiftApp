//
//  LEMessageTableViewCell.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/6.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit

class LEMessageTableViewCell: UITableViewCell {
    lazy var iconView:UIImageView = {
       let icon = UIImageView()
        icon.backgroundColor = UIColor.white
        icon.layer.cornerRadius = 15
        icon.layer.masksToBounds = true
        
        return icon
    }()
    
    lazy var nameLabel:UILabel = {
       let name = UILabel()
        name.backgroundColor = UIColor.white
        name.textColor = UIColor.darkGray
        name.textAlignment = NSTextAlignment.left
        name.font = UIFont.systemFont(ofSize: 15)
        return name
    }()
    
    lazy var timeLabel:UILabel = {
       let time = UILabel()
        time.backgroundColor = UIColor.white
        time.font = UIFont.systemFont(ofSize: 14)
        time.textColor = UIColor.gray
        time.textAlignment = NSTextAlignment.left
        return time
    }()
    
    
    lazy var contentLabel:UILabel = {
       let content = UILabel()
        content.backgroundColor = UIColor.white
        content.textColor = UIColor.darkGray
        content.font = UIFont.systemFont(ofSize: 14)
        return content
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        
    }

}

//MARK: 设置UI
extension LEMessageTableViewCell {
    func setUI()  {
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(contentLabel)
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.width.height.equalTo(iconWH)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(margin)
            make.top.equalTo(iconView).offset(margin/2)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(margin)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(margin)
            make.width.equalTo(screenW - 2 * margin)
            make.height.equalTo(55)
        }
    }
}


//MARK: 自带的方法
extension LEMessageTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
