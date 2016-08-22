//
//  ProfileViewModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/12/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import KVNProgress
class ProfileViewModel: NSObject {
    var user : User?
    
    override init(){
        
    }
    
    func updateUserInfo(user: User, completionHandler:()->Void={}){
        KVNProgress.show()
        WebService.instance.queryForUpdateUserProfile(user){
            (error) in
            if (error == nil){
                
                KVNProgress.showSuccessWithStatus("Update succesfully")
            }else{
                KVNProgress.showErrorWithStatus("Update failed with error \(error)")
            }
            
        }
    }
}
