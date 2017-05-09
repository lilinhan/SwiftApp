//
//  LEPeople.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/8.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ObjectMapper

class LEPeople: Mappable {
    var id:Int32?
    var name:String?
    var email:String?
    var group:Int32?
    var sex:String?
    var phone:String?
    var qq:String?
    var wechat:String?
    var blog_url:String?
    var github_url:String?
    var native:String?
    var grade:String?
    var major:String?
    var workplace:String?
    var job:String?
    var created_at:String?
    var avatar_url:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        group <- map["group"]
        sex <- map["sex"]
        phone <- map["phone"]
        qq <- map["qq"]
        wechat <- map["wechat"]
        blog_url <- map["blog_url"]
        github_url <- map["github_url"]
        native <- map["native"]
        grade <- map["grade"]
        major <- map["major"]
        workplace <- map["workplace"]
        job <- map["job"]
        created_at <- map["created_at"]
        avatar_url <- map["avatar_url"]
    }
    
}
