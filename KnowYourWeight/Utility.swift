//
//  Utility.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/5/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit

class Utility{
    static func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    static func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations = [0.0,1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, atIndex: 0)
        sender.tableView.backgroundView = backgroundView
    }
    
    static func getCurrentDate()->String{
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "dd/mm/yy"
        let currentDate = dateFormatter.stringFromDate(date)
        return currentDate
    }
}
