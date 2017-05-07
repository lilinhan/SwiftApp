//
//  LEMessage.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/6.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ObjectMapper

class LEMessage: Mappable {
    var id:Int32?
    var message_id:Int32?
    var type:Int32?
    var app_id:String?
    var author_id:Int32?
    var receiver_id:Int32?
    var all_receiver_ids:String?
    var title:String?
    var content:String?
    var status:Int32?
    var created_at:String?
    
    var app:LEApp?
    var author:LEAuthor?
    var receiver:LEAuthor?
    var all_receivers:[LEAuthor]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        message_id <- map["message_id"]
        type <- map["type"]
        app_id <- map["app_id"]
        author_id <- map["author_id"]
        receiver_id <- map["receiver_id"]
        all_receiver_ids <- map["all_receiver_ids"]
        title <- map["title"]
        content <- map["content"]
        status <- map["status"]
        created_at <- map["created_at"]
        app <- map["app"]
        author <- map["author"]
        receiver <- map["receiver"]
        all_receivers <- map["all_receivers"]
    }
}
