//
//  LEChangeSelfDataViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/3/19.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol getChangedDataBackDelegate {
    func getData(data :LEMeModel)
}


class LEChangeSelfDataViewController: UIViewController {
//    var name:String = ""
//    var phoneNumber:String = ""
//    var email:String = ""
//    var workPlace:String = ""
//    var QQ:String = ""
//    var wechat:String = ""
//    var blog:String = ""
//    var githubSite:String = ""
//    var major:String = ""

    //代理属性
    var changeDataPage:LEChangeDataPage?

    override func viewDidLoad() {
        super.viewDidLoad()
        changeDataPage = LEChangeDataPage()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(finishedEditing))
        setDataInPage()
        self.view = changeDataPage
    }

    //MARK::  完成修改
    func finishedEditing()  {
        //获取User id
        let id = UserDefaults.standard.value(forKey: "userid")
        print("User ID is \(id)")
        //获取url和请求
        let url = "https://api.xiyoulinux.org/users/\(id!)"
        print("Change Data URL \(url)")
        //let request = URLRequest(url: URL(string: url)!)
        //获取请求的参数
        let params = getChangedData()
        //发送请求
        

         Alamofire.request(URL(string: url)!, method: .put, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON { (response) in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                print(json)
            }
            
            if response.result.isFailure {
                print("网络异常")
            }
        }
        
        
        //返回view controller
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: 给修改页面添加数据
    func setDataInPage()  {
        changeDataPage?.nameCell.projIcon.image = #imageLiteral(resourceName: "avatar")
        changeDataPage?.nameCell.projTextField.placeholder = "姓名"
        changeDataPage?.phoneCell.projIcon.image = #imageLiteral(resourceName: "phone")
        changeDataPage?.phoneCell.projTextField.placeholder = "电话号码"
        changeDataPage?.qqCell.projIcon.image = #imageLiteral(resourceName: "qq")
        changeDataPage?.qqCell.projTextField.placeholder = "QQ"
        changeDataPage?.wechatCell.projIcon.image = #imageLiteral(resourceName: "wechat")
        changeDataPage?.wechatCell.projTextField.placeholder = "微信"
        changeDataPage?.schoolCell.projIcon.image = #imageLiteral(resourceName: "study")
        changeDataPage?.schoolCell.projTextField.placeholder = "专业"
        changeDataPage?.workCell.projIcon.image = #imageLiteral(resourceName: "workplace")
        changeDataPage?.workCell.projTextField.placeholder = "工作地点"
        changeDataPage?.emailCell.projIcon.image = #imageLiteral(resourceName: "gmail")
        changeDataPage?.emailCell.projTextField.placeholder = "邮箱"
        changeDataPage?.githubCell.projIcon.image = #imageLiteral(resourceName: "GitHub")
        changeDataPage?.githubCell.projTextField.placeholder = "Github"
        changeDataPage?.blogCell.projIcon.image = #imageLiteral(resourceName: "blog")
        changeDataPage?.blogCell.projTextField.placeholder = "博客"
    }
    
    func getChangedData() -> Parameters {
        
        var params = Parameters()
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        params["access_token"] = accessToken
 
        if (changeDataPage?.nameCell.projTextField.text?.characters.count)! > 0 {
            params["name"] = changeDataPage?.nameCell.projTextField.text
        }
        
        if (changeDataPage?.schoolCell.projTextField.text?.characters.count)! > 0 {
            params["major"] = changeDataPage?.schoolCell.projTextField.text
        }
        
        if (changeDataPage?.githubCell.projTextField.text?.characters.count)! > 0 {
            params["github"] = changeDataPage?.githubCell.projTextField.text
        }
        
        if (changeDataPage?.emailCell.projTextField.text?.characters.count)! > 0 {
            params["email"] = changeDataPage?.emailCell.projTextField.text
        }
        
        if (changeDataPage?.qqCell.projTextField.text?.characters.count)! > 0 {
            params["qq"] = changeDataPage?.qqCell.projTextField.text
        }
        
        if (changeDataPage?.blogCell.projTextField.text?.characters.count)! > 0 {
            params["blog_url"] = changeDataPage?.blogCell.projTextField.text
        }
        
        if (changeDataPage?.workCell.projTextField.text?.characters.count)! > 0 {
            params["workplace"] = changeDataPage?.workCell.projTextField.text
        }
        
        if (changeDataPage?.phoneCell.projTextField.text?.characters.count)! > 0 {
            params["phone"] = changeDataPage?.phoneCell.projTextField.text
        }
        
        if (changeDataPage?.wechatCell.projTextField.text?.characters.count)! > 0 {
            params["wechat"] = changeDataPage?.wechatCell.projTextField.text
        }
       
        return params
    }
}
