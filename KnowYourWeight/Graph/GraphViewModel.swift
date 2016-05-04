//
//  GraphViewModel.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/3/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit

class GraphViewModel{
    var scaleData : [Scale]?
    
    init(){
        scaleData = []
    }
    
    func loadScaleData(completionHandler:()->Void = {}){
        WebService.instance.queryForGetUserData("Danh") { (data, error) in
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
