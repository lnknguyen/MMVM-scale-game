//
//  SignUpViewModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/3/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit

class SignUpViewModel {
    var user : User
    
    init(){
        user = User()
    }
    
    func signupForUser(){
        WebService.instance.queryForRegisterUser(user) { (error) in
            if ((error == nil)){
                print("Sign up successful")
            }else {
                print("Sign up failed")
            }
        }
    }
}
