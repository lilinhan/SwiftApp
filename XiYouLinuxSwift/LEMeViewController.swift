//
//  LEMeViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/3/6.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import Kingfisher

class LEMeViewController: UIViewController/*, getChangedDataBackDelegate */{
    var selfData:LEMeModel?
    var header:LEMeHeader?
    var line:UIView?
    var footer:LEMeFooter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfData = LEMeModel()
        
        header = LEMeHeader()
        footer = LEMeFooter()
        line = UIView()
        line?.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        setNavgationBar()
        setupUI()

        self.view.backgroundColor = UIColor.white
        //设置透明度
        self.navigationController?.navigationBar.isTranslucent = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getDataFromNet()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:  设置navgationbar
    func setNavgationBar()  {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "修改", style: .plain, target: self, action: #selector(pressChaneBtn))
    }
    
    func pressChaneBtn()  {
        let changeSelfData = LEChangeSelfDataViewController()

        self.navigationController?.pushViewController(changeSelfData, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }

    
    //MARK:  设置UI
    func setupUI()  {
        self.view.addSubview(header!)
        self.view.addSubview(line!)
        self.view.addSubview(footer!)
        
        header?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.height.equalTo(160)
            make.width.equalToSuperview().offset(0)
        }
        
        line?.snp.makeConstraints { (make) in
            make.top.equalTo((header?.snp.bottom)!).offset(5)
            make.left.equalToSuperview().offset(margin)
            make.width.equalTo(screenW-2*margin)
            make.height.equalTo(1)
        }

        
        footer?.snp.makeConstraints { (make) in
            make.top.equalTo((line?.snp.bottom)!).offset(margin)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(0)
            make.bottom.equalToSuperview().offset(0)
            
        }
    }
    
    //MARK: 设置数据
    func setData()  {
        let baseUrl:String = (selfData?.avatar)!
        print("Avatar url \(baseUrl)")
        let imgUrl = URL(string: baseUrl)
//        do {
//            image = try UIImage(data: Data(contentsOf: imgUrl!))!
//        } catch let error  {
//            print(error)
//        }
//
        
        header?.nameLabel.text = selfData?.name
        header?.mottoLabel.text = "open free share"
        //header?.avatarImageView.image = image
        header?.avatarImageView.kf.setImage(with: imgUrl)
        
        footer?.blogLabel.text = selfData?.blog
        footer?.phoneLabel.text = selfData?.phoneNumber
        footer?.emailLabel.text = selfData?.email
        footer?.githubLabel.text = selfData?.githubSite
        footer?.qqLabel.text = selfData?.QQ
        footer?.wechatLabel.text = selfData?.wechat
        footer?.workLabel.text = selfData?.workPlace
        footer?.schoolLabel.text = selfData?.school
    }
    
    //从网络获取个人信息数据
    func getDataFromNet()  {
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        let params:Parameters = ["access_token":accessToken]
        print(params)
        
        Alamofire.request(URL(string: "https://api.xiyoulinux.org/me")!, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            //成功
            if response.result.isSuccess {
                let jsonData = JSON(response.result.value!)
                print(jsonData)
                //获取姓名
                let name:String = {
                    if let name = jsonData["name"].string {
                        return name
                    }
                    return "NULL"
                }()
                self.selfData?.name = name
                //获取id
                let id:Int = {
                    if let _id = jsonData["id"].int {
                        return _id
                    }
                    return 0
                }()
                self.selfData?.id = id
                //获取github
                let github:String = {
                    if let github_url = jsonData["github_url"].string {
                        return github_url
                    }
                    return "NULL"
                }()
                
                self.selfData?.githubSite = github
                //获取email
                let email:String = {
                    if let email = jsonData["email"].string {
                        return email
                    }
                    return "NULL"
                }()
                
                self.selfData?.email = email
                //获取email
                let grade:String = {
                    if let grade = jsonData["grade"].string {
                        return grade
                    }
                    return "NULL"
                }()
                
                self.selfData?.grade = grade
                //获取avatar
                let avatar_url:String = {
                    if let avatar_url = jsonData["avatar_url"].string {
                        return avatar_url
                    }
                    return "NULL"
                }()
                
                self.selfData?.avatar = avatar_url
                //获取major
                let major:String = {
                    if let major = jsonData["major"].string {
                        return major
                    }
                    return "NULL"
                }()
                
                self.selfData?.school = "西邮\\\(major)"
                self.selfData?.major = major
                //获取qq
                let qq:String = {
                    if let qq = jsonData["qq"].string {
                        return qq
                    }
                    return "NULL"
                }()
                self.selfData?.QQ = qq
                //获取blog_url
                let blog_url:String = {
                    if let blog_url = jsonData["blog_url"].string {
                        return blog_url
                    }
                    return "NULL"
                }()
                self.selfData?.blog = blog_url
                //获取phone
                let phone:String = {
                    if let phone = jsonData["phone"].string {
                        return phone
                    }
                    return "NULL"
                }()
                self.selfData?.phoneNumber = phone
                //获取wechat
                let wechat:String = {
                    if let wechat = jsonData["wechat"].string {
                        return wechat
                    }
                    return "NULL"
                }()
                self.selfData?.wechat = wechat
                //获取job
                let job:String = {
                    if let job = jsonData["job"].string {
                        return job
                    }
                    return "NULL"
                }()
                self.selfData?.job = job
                //获取workplace
                let workplace:String = {
                    if let workplace = jsonData["workplace"].string {
                        return workplace
                    }
                    return "NULL"
                }()
                self.selfData?.workPlace = workplace
                
                print("User id \(self.selfData?.id)")
                UserDefaults.standard.setValue(self.selfData?.id, forKey: "userid")
                UserDefaults.standard.synchronize()
                self.setData()

            }
            //失败
            if response.result.isFailure {
                print("网络异常")
            }
        }
        
    }
    


}
