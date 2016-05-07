//
//  SignUpViewModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/3/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import KVNProgress
class SignUpViewModel {
    var user : User
    
    init(){
        user = User()
    }
    
    func signUpForUserWithPassword(password: String){
        KVNProgress.show()
        WebService.instance.queryForRegisterUser(user, password: password) { (status, error) in
            if (error == nil){
                if (status){
                    KVNProgress.showSuccessWithStatus("Register succesfully")
                }
                else{
                    KVNProgress.showErrorWithStatus("Username taken")
                }
            }else{
                print("Error registering")
            }
        }
    }
}
