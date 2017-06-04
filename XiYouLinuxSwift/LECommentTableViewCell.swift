//
//  LECommentTableViewCell.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/4.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit

class LECommentTableViewCell: UITableViewCell {
    lazy var icon:UIImageView = {
       let _icon = UIImageView()
        _icon.backgroundColor = UIColor.white
        _icon.layer.cornerRadius = 15
        _icon.layer.masksToBounds = true
        return _icon
    }()
    
    lazy var nameLabel:UILabel = {
       let name = UILabel()
        name.textColor = UIColor.darkGray
        name.font = UIFont.systemFont(ofSize: 14)
        name.backgroundColor = UIColor.white
        return name
    }()
    
    lazy var commentLabel:UILabel = {
       let comment = UILabel()
        comment.font = UIFont.systemFont(ofSize: 14)
        comment.backgroundColor = UIColor.white
        comment.textColor = UIColor.darkGray
        comment.numberOfLines = 0
        return comment
    }()
    
    lazy var timeLabel:UILabel = {
       let time = UILabel()
        time.backgroundColor = UIColor.white
        time.textColor = UIColor.gray
        time.font = UIFont.systemFont(ofSize: 14)
        return time
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension LECommentTableViewCell {
    func setUI()  {
        addSubview(icon)
        addSubview(timeLabel)
        addSubview(nameLabel)
        addSubview(commentLabel)
        
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin/2)
            make.top.equalToSuperview().offset(2)
            make.width.height.equalTo(iconWH)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(margin)
            make.top.equalTo(icon.snp.top)
            make.width.equalTo(200)
            make.height.equalTo(15)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.width.height.equalTo(nameLabel)
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(2)
            make.left.equalTo(timeLabel)
            make.width.equalTo(screenW-50-margin)
            make.height.equalTo(40)
        }
        
    }
}
