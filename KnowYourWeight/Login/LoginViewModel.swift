//
//  LoginViewModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/5/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import KVNProgress
class LoginViewModel: NSObject {
    var user = User()
    
    func validateUserLogin(username: String, password: String, completionHandler:()->Void = {}){
        KVNProgress.show()
        WebService.instance.queryForLoginUser(username, password: password) { (user, error) in
            if (error == nil){
                if let usr : User = user{
                    self.user = usr
                    KVNProgress.showSuccess()
                    completionHandler()
                }else{
                        KVNProgress.showErrorWithStatus("Password and username do not match")
                }
                
            }else{
                KVNProgress.showErrorWithStatus("Problem from server")
                print("Login fail")
            }
        }
    }
}
