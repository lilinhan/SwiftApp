//
//  LEData.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/2.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ObjectMapper

class LEData: Mappable {
    var id:Int32?
    var type:Int32?
    var author_id:Int32?
    var app_id:String?
    var topic:String?
    var link_url:String?
    var content:String?
    var created_at:String?
    
    
    var author:LEAuthor?
    var app:LEApp?
    var comments:[LEComment]?
    var favors:[LEFavor]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        author_id <- map["author_id"]
        app_id <- map["app_id"]
        
        topic <- map["topic"]
        link_url <- map["link_url"]
        content <- map["content"]
        created_at <- map["created_at"]
        
        author <- map["author"]
        app <- map["app"]
        comments <- map["comments"]
        favors <- map["favors"]
    }
    
}
