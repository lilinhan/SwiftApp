//
//  LEAuthor.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/2.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ObjectMapper

class LEAuthor: Mappable {
    var id:Int?
    var name:String?
    var avatar_url:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar_url <- map["avatar_url"]
    }
    
}
