//
//  LENewData.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/3/23.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ObjectMapper

class LENewData: Mappable {
    var total_count:Int32?
    var page:Int32?
    var per_page:Int32?
    
    var data:[LEData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total_count <- map["total_count"]
        page <- map["page"]
        per_page <- map["per_page"]
        data <- map["data"]
    }
    
}
