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
import CryptoSwift

class WebService: NSObject{
    static let  instance = WebService()
    //let BASE_API = "https://mysterious-inlet-23105.herokuapp.com/api/v1"
    let BASE_API = "http://82.196.14.213:55184/api/v1"
    private override init(){}
    
    func queryForListUser(completionHandler: (Array<User>,NSError?) -> Void){
        Alamofire.request(.GET, BASE_API+"/user")
            .validate()
            .responseJSON { (response) in
                if let json = response.result.value{
                    let list: Array<User> = Mapper<User>().mapArray(json)!
                    completionHandler(list,response.result.error)
                } else {
                    completionHandler([],response.result.error)
                }
        }
        
    }
    
    
    
    func queryForGetUserProfileByName(completionHandler: (User,NSError)->Void){
        Alamofire.request(.GET,BASE_API+"/user/"+"Danh").responseJSON { (response) in
            if let JSON = response.result.value{
                print("User res \(JSON)")
            }
        }
    }
    
    func queryForRegisterUser(user: User,password: String,completionHandler: (status : Bool ,NSError?) -> Void){
        let params = ["name": user.name.value,
                      "height": user.height.value,
                      "goal_day": user.goalDay.value,
                      "register_day": Utility.getCurrentDate(),
                      "password": password.sha1(),
                      "weight":user.goalWeight.value,
                      "status":false]
        print(params)
        Alamofire.request(.POST, BASE_API+"/user", parameters: params as? [String : AnyObject], encoding: .URL)
            //.validate()
            .response { (req, res, data, err) in
                
                if (err == nil){
                    if ( res?.statusCode >= 200 && res?.statusCode <= 300){
                        completionHandler(status: true, nil)
                    }
                    else{
                        completionHandler(status: false, nil)
                    }
                }
                else{
                    
                    completionHandler(status: false,err)
                }
        }
        
    }
    
    
    func queryForLoginUser(username: String, password: String, completionHandler: (User?,NSError?)->Void){
        let params = ["username": username,
                      "password": password.sha1()]
        
        Alamofire.request(.POST,BASE_API+"/user/login",parameters: params, encoding: .URL)
            .response(completionHandler: { (req, res, data, error) in
                if (error == nil){
                    if((res?.statusCode)!<300){
                        Alamofire.request(.GET,self.BASE_API+"/user/"+username).responseJSON { (response) in
                            if let JSON = response.result.value{
                                let user = Mapper<User>().mapArray(JSON)
                                completionHandler(user![0],error)
                            }
                        }
                    }else{
                        completionHandler(nil,error)
                    }
                } else{
                    completionHandler(nil,error)
                }
            })
    }
    
    func queryForGetUserData(username: String, completionHandler: (Array<Scale>,NSError?) -> Void){
        let params : [String:String] = ["username" : username]
        
        Alamofire.request(.GET,BASE_API+"/scale/" + username,parameters: params)
            .validate()
            .responseJSON { (response) in
                if let json = response.result.value{
                    let list: Array<Scale> = Mapper<Scale>().mapArray(json)!
                    completionHandler(list,response.result.error)
                }else{
                    completionHandler([],response.result.error)
                }
        }
    }
    
}
