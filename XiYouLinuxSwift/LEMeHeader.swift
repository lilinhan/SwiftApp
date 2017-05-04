//
//  LEMeHeader.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/3/16.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import Alamofire

class LEMeHeader: UIView {
    //var selfData = LEMeModel()
    
    let avatarImageView: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 37.5
        avatar.layer.masksToBounds = true
        return avatar
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.darkGray
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let mottoLabel: UILabel = {
        let motto = UILabel()
        motto.translatesAutoresizingMaskIntoConstraints = false
        motto.textColor = UIColor.darkGray
        motto.numberOfLines = 2
        motto.translatesAutoresizingMaskIntoConstraints = false
        return motto
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(mottoLabel)
        //setAllData()
        setViewConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:  设置数据
//    func setAllData()  {
//        nameLabel.text = selfData.name
//        mottoLabel.text = "Talk is cheap, show me the code" + "\n"
//        avatarImageView.image = UIImage(named: (selfData.avatar))
//    }
//    
    //MARK:  设置布局
    func setViewConstraints()  {
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(margin)
            make.width.equalTo(avatarWH)
            make.height.equalTo(avatarWH)
        }
        
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.equalTo(avatarImageView.snp.right).offset(margin)
            make.width.equalTo((screenW-2*margin-avatarWH))
            make.height.equalTo(20)
        }
        
        mottoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(margin)
            make.left.width.equalTo(nameLabel)
            make.height.equalTo(45)
        }

    }
    
}
