//
//  LEPublishViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/2/12.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit

class LEPublishViewController: UIViewController {
    var textFild:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addAllSubViews()
        // Do any additional setup after loading the view.
    }


    func addAllSubViews() {
        textFild = UITextField()
        self.view.addSubview(textFild!)
        
        textFild?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(margin/2)
            make.left.equalToSuperview().offset(margin/2)
            make.width.equalTo(screenW-margin)
            make.height.equalTo(400)
        })
    }

}
