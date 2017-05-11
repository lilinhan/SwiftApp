//
//  LESendMessageViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/6.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ESPullToRefresh
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher

class LESendMessageViewController: UIViewController, UITextFieldDelegate {
    var peopleId:Int = 0
    var peopleName:String = ""
    
    var nameTextField = UITextField()
    
    lazy var textView:UITextView = {
       let text = UITextView()
        text.backgroundColor = UIColor.white
        text.selectedRange = NSMakeRange(0, 0)
        text.isScrollEnabled = false
        text.textAlignment = NSTextAlignment.left
        text.textColor = UIColor.darkGray
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.backgroundColor = UIColor.white
        nameTextField.placeholder = "To :"
        nameTextField.textColor = UIColor.darkGray
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendMessageToWeb))
        
        automaticallyAdjustsScrollViewInsets = false
        nameTextField.delegate = self
        setUI()
    }
    
    
}

//MARK: 网络请求
extension LESendMessageViewController {
    func sendMessageToWeb()  {
        let urlString = "https://api.xiyoulinux.org/messages"
        let url = URL(string: urlString)
        
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        let content = textView.text
        
        let params = ["access_token":accessToken, "type":0, "receiver_id":peopleId, "content":content!, "status":1, "title":"Send by XiYouLinuxiOSApp"] as [String : Any]
        
        Alamofire.request(url!, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                print(json)
            }
            
            if response.result.isFailure {
                print("网络连接失败")
            }
        }
        
    }
}


//text field delegate
extension LESendMessageViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = LEMemTableViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        return false
    }
    
}

//MARK: 设置UI
extension LESendMessageViewController {
    func setUI()  {
        self.view.addSubview(textView)
        self.view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64+margin)
            make.left.equalToSuperview().offset(margin)
            make.width.equalTo(screenW - 2 * margin)
            make.height.equalTo(20)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(margin)
            make.left.equalTo(nameTextField)
            make.width.equalTo(screenW - 2 * margin)
            make.height.equalTo(100)
        }
    }
}

extension LESendMessageViewController:MyProtocol {
    func passUserId(id: Int, name: String) {
        peopleId = id
        peopleName = name
        self.nameTextField.text = peopleName
    }
}
