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
    lazy var nameTextFiel:UITextField = {
       let name = UITextField()
        name.backgroundColor = UIColor.green
        name.placeholder = "To :"
        return name
    }()
    
    lazy var textView:UITextView = {
       let text = UITextView()
        //text.backgroundColor = UIColor.purple
        text.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        return text
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextFiel.delegate = self
        setUI()
    }
    

}

//text field delegate
extension LESendMessageViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = LEMemTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        textField.isEnabled = false
//        textField.setValue(false, forKey: "isEditing")
        return true
    }
    
}

//MARK: 设置UI
extension LESendMessageViewController {
    func setUI()  {
        self.view.addSubview(textView)
        self.view.addSubview(nameTextFiel)
        
        nameTextFiel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64+margin)
            make.left.equalToSuperview().offset(margin)
            make.width.equalTo(screenW - 2 * margin)
            make.height.equalTo(20)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextFiel.snp.bottom).offset(margin)
            make.left.equalTo(nameTextFiel)
            make.width.equalTo(screenW - 2 * margin)
            make.height.equalTo(100)
        }
    }
}
