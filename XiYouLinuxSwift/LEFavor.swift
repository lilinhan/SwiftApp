//
//  LEFavor.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/2.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ObjectMapper

class LEFavor: Mappable {
    var id:Int32?
    var author_id:Int32?
    var app_id:String?
    var news_id:Int32?
    var created_at:String?
    
    var author:LEAuthor?
    var app:LEApp?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        author_id <- map["author_id"]
        app_id <- map["app_id"]
        news_id <- map["news_id"]
        created_at <- map["created_at"]
        
        author <- map["author"]
        app <- map["app"]
    }
    
}
