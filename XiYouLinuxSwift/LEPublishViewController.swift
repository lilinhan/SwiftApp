//
//  LEPublishViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/2/12.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LEPublishViewController: UIViewController {
    var textView:UITextView?
    //1: 发表评论  2: 发表新鲜事  3: 发表bug
    var type = -1
    var id = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addAllSubViews()
    }
}

//MARK: 请求网络
extension LEPublishViewController {
    func postDataToWeb()  {
        switch type {
        case 1:
            publishNew()
            break
        case 2:
            publishComment()
            break
        case 3:
            publishBug()
            break
        default:
            break
        }
        
    }
    
    func publishComment()  {
        print("Comment id:\(id)")
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        print("accessToken \(accessToken)")
        let urlString = "https://api.xiyoulinux.org/news/\(id)/comments"
        print("URL string :\(urlString)")
        //let url = URL(string: urlString)
        let content = textView?.text
        
        let params = ["access_token":accessToken , "content":content!] as [String : Any]
        print(params)
        Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default, headers:nil).responseJSON { (response) in
            if response.result.isSuccess {
                print("发表成功")
            }
            
            if response.result.isFailure {
                print("网络错误")
            }
        }
    }
    
    func publishNew()  {
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        print("accessToken \(accessToken)")
        let urlString = "https://api.xiyoulinux.org/news"
        print("URL string :\(urlString)")
        //let url = URL(string: urlString)
        let content = textView?.text
        
        let params = ["access_token":accessToken , "content":content!, "topic":"XiyouLinuxiOSApp", "type":"0"] as [String : Any]
        print(params)
        Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default, headers:nil).responseJSON { (response) in
            if response.result.isSuccess {
                print("发表成功")
            }
            
            if response.result.isFailure {
                print("网络错误")
            }
        }
    }
    
    func publishBug()  {
        print("Bug")
    }
}


//设置编辑栏的样子
extension LEPublishViewController {
    func setUI()  {
        self.view.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        textView = UITextView()
        textView?.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(postDataToWeb))
        self.view.addSubview(textView!)
    }
    
    func addAllSubViews() {
        textView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(margin/2)
            make.left.equalToSuperview().offset(margin/2)
            make.width.equalTo(screenW-margin)
            make.height.equalTo(400)
        })
    }

}
