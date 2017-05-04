//
//  LEChangePageCell.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/3/21.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit

class LEChangePageCell: UIView {
    
    let projIcon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    
    let projTextField: UITextField = {
        let text = UITextField()
        text.borderStyle = .roundedRect
        return text
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //添加子控件
    func addSubViews()  {
        addSubview(projIcon);
        addSubview(projTextField);
    }
    //设置UI
    func setUserInterface()  {
        projIcon.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(margin)
            make.width.height.equalTo(iconWH)
        }
        
        projTextField.snp.makeConstraints { (make) in
            make.top.equalTo(projIcon).offset(margin/2)
            make.left.equalTo(projIcon.snp.right).offset(margin)
            make.height.equalTo(20)
            make.width.equalTo(300)
        }
    }
    
}
