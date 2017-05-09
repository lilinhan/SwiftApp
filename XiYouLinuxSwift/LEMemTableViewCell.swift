//
//  LEMemTableViewCell.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/7.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit

class LEMemTableViewCell: UITableViewCell {
    lazy var iconView:UIImageView = {
       let icon = UIImageView()
        icon.backgroundColor = UIColor.white
        icon.layer.cornerRadius = 15
        icon.layer.masksToBounds = true
        return icon
    }()
    
    lazy var nameLabel:UILabel = {
       let name = UILabel()
        name.backgroundColor = UIColor.white
        name.textColor = UIColor.darkGray
        name.textAlignment = NSTextAlignment.left
        name.font = UIFont.systemFont(ofSize: 14)
        return name
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
}


extension LEMemTableViewCell {
    func setUI()  {
        addSubview(iconView)
        addSubview(nameLabel)
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalToSuperview().offset(margin/2)
            make.width.height.equalTo(iconWH)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(margin)
            make.top.equalTo(iconView)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }
}

//MARK: 系统自带
extension LEMemTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
