//
//  LEEditBugViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/11.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LEReportViewController: UIViewController {
    lazy var textView:UITextView = {
        let text = UITextView()
        text.backgroundColor = UIColor.white
        text.selectedRange = NSMakeRange(2, 0)
        text.isScrollEnabled = false
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = UIColor.darkGray
        text.textAlignment = NSTextAlignment.left
        
        return text
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendToWeb))
        setUI()
    }
    
}

extension LEReportViewController {
    func sendToWeb()  {
        let urlString = "https://api.xiyoulinux.org/messages"
        let url = URL(string: urlString)
        
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        let content = textView.text
        
        let params = ["access_token":accessToken, "type":0, "receiver_id":"40", "content":content!, "status":1, "title":"XiYouLinuxiOSApp BUG!!!"] as [String : Any]
        
        Alamofire.request(url!, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                DispatchQueue.main.async {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
            
            if response.result.isFailure {
                print("网络连接失败")
            }
        }
    }
}

//MARK: 布局UI
extension LEReportViewController {
    func setUI()  {
        self.textView.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1).cgColor
        self.textView.layer.borderWidth = 2
        self.textView.layer.cornerRadius = 16
        
        self.view.addSubview(textView)
        
        textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64 + margin)
            make.left.equalToSuperview().offset(margin)
            make.width.equalTo(screenW - 2 * margin)
            make.height.equalTo(250)
        }
    }
}
