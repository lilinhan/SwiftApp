//
//  LEAnnoTableViewCell.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/6.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import SnapKit

class LEAnnoTableViewCell: UITableViewCell {
    lazy var iconView:UIImageView = {
       let icon = UIImageView()
        icon.backgroundColor = UIColor.white
        icon.layer.cornerRadius = 15
        icon.layer.masksToBounds = true
        
        return icon
    }()
    
    lazy var nameLabel:UILabel = {
       let name = UILabel()
        name.textColor = UIColor.darkGray
        name.font = UIFont.systemFont(ofSize: 15)
        name.backgroundColor = UIColor.white
        name.layer.cornerRadius = 5
        name.layer.masksToBounds = true
        
        return name
    }()
    
    lazy var timeLabel:UILabel = {
       let time = UILabel()
        time.font = UIFont.systemFont(ofSize: 12)
        time.backgroundColor = UIColor.white
        time.textColor = UIColor.lightGray
        time.textAlignment = NSTextAlignment.right
        return time
    }()
    
    lazy var contentLabel:UILabel = {
        let content = UILabel()
        content.backgroundColor = UIColor.white
        content.textColor = UIColor.darkGray
        content.font = UIFont.systemFont(ofSize: 14)
        content.textAlignment = NSTextAlignment.left
        content.numberOfLines = 0
        content.sizeToFit()
        return content
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//MARK: 设置UI界面
extension LEAnnoTableViewCell {
    func setUI()  {
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(contentLabel)
        
        //设置版面
        iconView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(margin)
            make.width.height.equalTo(iconWH)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(margin)
            make.top.equalTo(iconView.snp.top)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(margin)
            make.width.height.equalTo(nameLabel)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalTo(iconView.snp.bottom).offset(margin)
            make.width.equalTo(screenW-2*margin)
            make.height.equalTo(60)
        }
        
    }
}
