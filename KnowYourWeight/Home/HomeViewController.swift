//
//  HomeViewController.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/3/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import Bond
class HomeViewController: UIViewController {

    var user: User?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var goalWeightLabel: UILabel!
    @IBOutlet weak var goalDayLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var ibmLabel: UILabel!
    
    @IBOutlet weak var currentWeightLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
      
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let currWeight = (user!.goalWeight.value)
        let height = (user!.height.value)
        let bmi = currWeight / (height*height)
        let bmiStr = String(format: "BMI: %.2f",bmi)
        
        nameLabel.text = user!.name.value
        idLabel.text = "ID: \(user!.id)"
        goalWeightLabel.text = "Goal weight: \(user!.goalWeight.value)"
        goalDayLabel.text = "Goal day: \(user!.goalDay.value)"
        heightLabel.text = "Height: \(user!.height.value)"
        ibmLabel.text = bmiStr
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
