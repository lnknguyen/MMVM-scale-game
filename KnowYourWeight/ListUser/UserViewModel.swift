//
//  UserViewModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/1/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit

class UserViewModel{
    var users: [User]?
    
     init(){
        users = []
    }
    
    func reloadAllUser(completionHandler:()->Void){
        
        WebService.instance.queryForListUser { (listOfUser, error) in
            if (error == nil){
                self.users = listOfUser
                completionHandler()
            }
            else{
                print("Error loading user: \(error)")
            }
        }
    }
}
