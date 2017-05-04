//
//  LEChangeDataPage.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/3/21.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit

class LEChangeDataPage: UIView {
    let nameCell: LEChangePageCell = {
        let cell = LEChangePageCell()
        return cell
    }()
    
    let qqCell: LEChangePageCell = {
        let cell = LEChangePageCell()
        return cell
    }()
    
    let wechatCell: LEChangePageCell = {
        let cell = LEChangePageCell()
        return cell
    }()
    
    let phoneCell: LEChangePageCell = {
        let cell = LEChangePageCell()
        return cell
    }()
    
    let workCell: LEChangePageCell = {
        let cell = LEChangePageCell()
        return cell
    }()
    
    let schoolCell: LEChangePageCell = {
        let cell = LEChangePageCell()
        return cell
    }()
    
    let emailCell: LEChangePageCell = {
        let cell = LEChangePageCell()
        return cell
    }()
    
    let githubCell: LEChangePageCell = {
        let cell = LEChangePageCell()
        return cell
    }()
    
    let blogCell: LEChangePageCell = {
        let cell = LEChangePageCell()
        return cell
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAllViews()
        setUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 添加subViews
    func addAllViews()  {
        addSubview(nameCell)
        addSubview(phoneCell)
        addSubview(qqCell)
        addSubview(workCell)
        addSubview(wechatCell)
        addSubview(schoolCell)
        addSubview(githubCell)
        addSubview(blogCell)
        addSubview(emailCell)
    }
    
    //MARK: 设置UI界面
    func setUserInterface()  {
        nameCell.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(margin)
            make.width.equalTo(screenW)
            make.height.equalTo(25)
        }
        
        phoneCell.snp.makeConstraints { (make) in
            make.top.equalTo(nameCell.snp.bottom).offset(margin*2)
            make.left.width.height.equalTo(nameCell)
        }
        
        qqCell.snp.makeConstraints { (make) in
            make.top.equalTo(phoneCell.snp.bottom).offset(margin*2)
            make.left.width.height.equalTo(phoneCell)
        }
        
        wechatCell.snp.makeConstraints { (make) in
            make.top.equalTo(qqCell.snp.bottom).offset(margin*2)
            make.left.width.height.equalTo(qqCell)
        }
        
        schoolCell.snp.makeConstraints { (make) in
            make.top.equalTo(wechatCell.snp.bottom).offset(margin*2)
            make.left.width.height.equalTo(wechatCell)
        }
        
        workCell.snp.makeConstraints { (make) in
            make.top.equalTo(schoolCell.snp.bottom).offset(margin*2)
            make.left.width.height.equalTo(schoolCell)
        }
        
        githubCell.snp.makeConstraints { (make) in
            make.top.equalTo(workCell.snp.bottom).offset(margin*2)
            make.left.width.height.equalTo(workCell)
        }
        
        emailCell.snp.makeConstraints { (make) in
            make.top.equalTo(githubCell.snp.bottom).offset(margin*2)
            make.left.width.height.equalTo(githubCell)
        }
        
        blogCell.snp.makeConstraints { (make) in
            make.top.equalTo(emailCell.snp.bottom).offset(margin*2)
            make.left.width.height.equalTo(emailCell)
        }
    }

}
