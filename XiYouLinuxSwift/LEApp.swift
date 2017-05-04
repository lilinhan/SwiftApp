//
//  LEApp.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/2.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ObjectMapper

class LEApp: Mappable {
    var client_id:String?
    var name:String?
    var homepage_url:String?
    var logo_url:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        client_id <- map["client_id"]
        name <- map["client_id"]
        homepage_url <- map["homepage_url"]
        logo_url <- map["logo_url"]
    }

}
