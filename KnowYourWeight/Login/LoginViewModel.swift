//
//  LoginViewModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/5/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    var user = User()
    
    func validateUserLogin(username: String, password: String){
        WebService.instance.queryForLoginUser(username, password: password) { (user, error) in
            if (error == nil){
                self.user = user!
                print("login ok")
            }else{
                print("Login fail")
            }
        }
    }
}
