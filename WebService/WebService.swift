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
    let BASE_API = "http://82.196.14.213:3000/api/v1"
    private override init(){}
    
    /**
     Get list of all users
     
     - parameter completionHandler: closure to handle returned user list
     */
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
    
    
    /**
     Deprecated
     
     - parameter completionHandler: <#completionHandler description#>
     */
    func queryForGetUserProfileByName(completionHandler: (User,NSError)->Void){
        Alamofire.request(.GET,BASE_API+"/user/"+"Danh").responseJSON { (response) in
            if let JSON = response.result.value{
                print("User res \(JSON)")
            }
        }
    }
    
    /**
     Upload user's data from sign up scene
     
     - parameter user:              user data
     - parameter password:          password for newly created user, since user model cannot contain password
     - parameter completionHandler: handle return code. 500 if username is taken, 200 if success
     */
    func queryForRegisterUser(user: User,password: String,completionHandler: (status : Bool ,NSError?) -> Void){
        let params = ["name": user.name.value,
                      "height": user.height.value,
                      "goal_day": user.goalDay.value,
                      "register_day": Utility.getCurrentDate(),
                      "password": password.sha1(),
                      "weight":user.goalWeight.value,
                      "status":false]

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
    
    /**
     Login for user
     
     - parameter username:          inputted username
     - parameter password:          inputted password
     - parameter completionHandler: handle returned user data if login successfully ( code 200) . 
                                    Code 500 otherwise
     */
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
    
    /**
     Get user data by username
     
     - parameter username:          username
     - parameter completionHandler: handle returned user data
     */
    func queryForGetUserData(username: String, completionHandler: (Array<Scale>,NSError?) -> Void){
        let params : [String:String] = ["username" : username]
        
        Alamofire.request(.GET, BASE_API+"/scale/" + username,parameters: params)
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
    
    /**
     Update current user profile
     
     - parameter user:              update user's data
     - parameter completionHandler: code if success or fail.
     */
    
    func queryForUpdateUserProfile(user: User,completionHandler: (NSError?) ->Void){
        let params = ["begin_day": Utility.getCurrentDate(),
                      "height": user.height.value,
                      "goal_day": user.goalDay.value,
                      "weight":user.goalWeight.value]
        Alamofire.request(.PUT,BASE_API+"/user/"+user.name.value,parameters: params as? [String : AnyObject], encoding: .URL)
        .validate()
        .response { (req, res, data, err) in
            if (err == nil){
                completionHandler(nil)
            }
            else{
                
                completionHandler(err)
            }

        }
        
    
    }
}
