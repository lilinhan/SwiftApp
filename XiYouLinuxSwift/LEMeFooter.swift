//
//  LEMeFooter.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/3/16.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import SnapKit

class LEMeFooter: UIView {
//    let selfData = LEMeModel()
    
    //QQ icon and label
    let qqIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "qq")
        return icon
    }()
    
    let qqLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    //wechat icon and label
    let wechatIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "wechat")
        return icon
    }()
    
    let wechatLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    //blog icon and label
    let blogIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "blog")
        return icon
    }()
    
    let blogLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    //email icon and label
    let emailIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "gmail")
        return icon
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    //github icon and label
    let githubIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "GitHub")
        return icon
    }()
    
    let githubLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        //label.text = "https://github.com/lilinhan"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    //phone icon and label
    let phoneIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "phone")
        return icon
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    //work icon and label
    let workIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "workplace")
        return icon
    }()
    
    let workLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12);
        label.textColor = UIColor.darkGray
        return label
    }()
    //school icon and label
    let schoolIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "study")
        icon.layer.cornerRadius = iconWH/2
        icon.layer.masksToBounds = true
        return icon
    }()
    
    let schoolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAllSubViews()
        //setAllData()
        setConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 添加所有的自视图
    func addAllSubViews()  {
        addSubview(qqIcon)
        addSubview(qqLabel)
        addSubview(wechatIcon)
        addSubview(wechatLabel)
        addSubview(blogIcon)
        addSubview(blogLabel)
        addSubview(githubIcon)
        addSubview(githubLabel)
        addSubview(emailIcon)
        addSubview(emailLabel)
        addSubview(phoneIcon)
        addSubview(phoneLabel)
        addSubview(workIcon)
        addSubview(workLabel)
        addSubview(schoolIcon)
        addSubview(schoolLabel)
    }
    
    //MARK: 设置数据
//    func setAllData()  {
//        schoolLabel.text = selfData.school
//        workLabel.text = selfData.workPlace
//        qqLabel.text = selfData.QQ
//        wechatLabel.text = selfData.wechat
//        blogLabel.text = selfData.blog
//        githubLabel.text = selfData.email
//        phoneLabel.text = selfData.phoneNumber
//        emailLabel.text = selfData.email
//    }
    
    //MARK: 设置布局
    func setConstrains()  {
        workIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin*3)
            make.top.equalToSuperview().offset(margin)
            make.width.height.equalTo(iconWH)
        }
        
        workLabel.snp.makeConstraints { (make) in
            make.left.equalTo(workIcon.snp.right).offset(margin)
            make.top.equalTo(workIcon).offset(margin/2)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        schoolIcon.snp.makeConstraints { (make) in
            make.left.width.height.equalTo(workIcon)
            make.top.equalTo(workIcon.snp.bottom).offset(margin)
        }
        
        schoolLabel.snp.makeConstraints { (make) in
            make.top.equalTo(schoolIcon).offset(margin/2)
            make.left.equalTo(schoolIcon.snp.right).offset(margin)
            make.width.height.equalTo(workLabel)
        }
        
        qqIcon.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(workIcon);
            make.left.equalTo(workLabel.snp.right).offset(margin)
        }
        
        qqLabel.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(workLabel)
            make.left.equalTo(qqIcon.snp.right).offset(margin)
        }
        
        wechatIcon.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(schoolIcon)
            make.left.equalTo(schoolLabel.snp.right).offset(margin)
        }
        wechatLabel.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(schoolLabel)
            make.left.equalTo(wechatIcon.snp.right).offset(margin)
        }
        
        phoneIcon.snp.makeConstraints { (make) in
            make.top.equalTo(schoolIcon.snp.bottom).offset(margin*3)
            make.width.height.left.equalTo(schoolIcon)
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(phoneIcon).offset(margin/2)
            make.left.equalTo(phoneIcon.snp.right).offset(margin)
            make.width.equalTo(280)
            make.height.equalTo(workLabel)
        }
        
        githubIcon.snp.makeConstraints { (make) in
            make.top.equalTo(phoneIcon.snp.bottom).offset(margin)
            make.left.width.height.equalTo(phoneIcon)
        }
        
        githubLabel.snp.makeConstraints { (make) in
            make.left.equalTo(githubIcon.snp.right).offset(margin)
            make.top.equalTo(githubIcon).offset(margin/2)
            make.width.height.equalTo(phoneLabel)
        }
        
        emailIcon.snp.makeConstraints { (make) in
            make.top.equalTo(githubIcon.snp.bottom).offset(margin)
            make.left.width.height.equalTo(githubIcon)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailIcon).offset(margin/2)
            make.left.equalTo(emailIcon.snp.right).offset(margin)
            make.width.height.equalTo(githubLabel)
        }
        
        blogIcon.snp.makeConstraints { (make) in
            make.top.equalTo(emailIcon.snp.bottom).offset(margin)
            make.width.left.height.equalTo(emailIcon)
        }
        
        blogLabel.snp.makeConstraints { (make) in
            make.top.equalTo(blogIcon).offset(margin/2)
            make.left.equalTo(blogIcon.snp.right).offset(margin)
            make.width.height.equalTo(emailLabel)
        }
        
    }
    
}
