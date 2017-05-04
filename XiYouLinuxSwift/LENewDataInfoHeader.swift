//
//  LENewDataInfoHeader.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/3.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import SnapKit

class LENewDataInfoHeader: UIView {
    lazy var icon:UIImageView =  {
        let _icon = UIImageView()
        _icon.layer.cornerRadius = avatarWH / 2
        _icon.layer.masksToBounds = true
        return _icon
    }()
    
    lazy var name:UILabel = {
        let _name = UILabel()
        _name.textColor = UIColor.darkGray
        _name.font = UIFont.systemFont(ofSize: 15)
        _name.textAlignment = NSTextAlignment.left
        return _name
    }()
    
    lazy var timeLabel:UILabel = {
        let _time = UILabel()
        _time.textColor = UIColor.gray
        _time.font = UIFont.systemFont(ofSize: 13)
        _time.textAlignment = NSTextAlignment.left
        return _time
    }()
    
    lazy var contentLabe:UILabel = {
       let _content = UILabel()
        _content.textColor = UIColor.darkGray
        _content.font = UIFont.systemFont(ofSize: 15)
        _content.textAlignment = NSTextAlignment.left
        _content.numberOfLines = 0
        _content.sizeToFit()
        return _content
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUserIntereface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: 设置UI
    func setUserIntereface()  {
        addSubview(icon)
        addSubview(name)
        addSubview(timeLabel)
        addSubview(contentLabe)
        
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.width.height.equalTo(avatarWH)
        }
        
        name.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(margin)
            make.top.equalTo(icon.snp.top).offset(margin)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).offset(margin)
            make.left.equalTo(name.snp.left)
            make.width.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        contentLabe.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(margin)
            make.left.equalToSuperview().offset(margin)
            make.width.equalTo(screenW - 2 * margin)
            make.height.equalTo(200)
        }

    }
}
