//
//  WebService.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/1/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class WebService: NSObject{
    static let  instance = WebService()
    let BASE_API = "https://mysterious-inlet-23105.herokuapp.com/api/v1"
    
    private override init(){}
    
    func queryForListUser(completionHandler: (Array<User>,NSError?) -> Void){
        Alamofire.request(.GET, BASE_API+"/user")
            .validate()
            .responseJSON { (response) in
                if let json = response.result.value{
                    let list: Array<User> = Mapper<User>().mapArray(json)!
                    completionHandler(list,nil)
                } else {
                    completionHandler([],response.result.error)
                }
        }
        
    }
    
    
    
    func queryForGetUserProfileByName(){
        Alamofire.request(.GET,BASE_API+"/user/"+"Danh").responseJSON { (response) in
            if let JSON = response.result.value{
                print("User res \(JSON)")
            }
        }
    }
    
    func queryForRegisterUser(){}
    
    
    func queryForLoginUser(username: String, password: String){}
    
    
}
