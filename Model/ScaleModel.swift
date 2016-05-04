//
//  ScaleModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/4/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import ObjectMapper
import Bond

class Scale: Mappable {
    var timeStamp = Observable<String>("")
    var id : Int!
    var userId =  Observable<Int>(0)
    var value =  Observable<Float>(0.0)
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        timeStamp.value <- map["time_stamp"]
        userId.value <- map["user_id"]
        id <- map["id"]
        value.value <- map["value"]
    }
}
