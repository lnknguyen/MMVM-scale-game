//
//  HomeViewModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/3/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    var user: User?
    var scaleData : [Scale]
    override init(){
        scaleData = []
    }
    
    
    func loadScaleData(completionHandler:()->Void = {}){
        WebService.instance.queryForGetUserData(user!.name.value) { (data, error) in
            if (error == nil){
                self.scaleData = data
                completionHandler()
            }
            else{
                print("Error loading scale data: \(error)")
            }
        }
    }


}
