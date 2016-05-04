//
//  UserModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/1/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import ObjectMapper
import Bond

class User: Mappable{
    var name = Observable<String>("")
    var height =  Observable<Float>(0.0)
    var id : Int!
    var goalDay =  Observable<Int>(0)
    var goalWeight =  Observable<Float>(0.0)
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name.value <- map["username"]
        height.value <- map["height"]
        id <- map["id"]
        goalDay.value <- map["goal_day"]
        goalWeight.value <- map["goal_weight"]
        
    }
    /*
    init(name: String?, height: Float, id: Int, goalDay: Int, goalWeight: Float){
        self.name = name
        self.height = height
        self.id = id
        self.goalDay = goalDay
        self.goalWeight = goalWeight
    }
    */
}
