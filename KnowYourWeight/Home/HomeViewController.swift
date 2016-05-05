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

    
    var viewModel = HomeViewModel()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var goalWeightLabel: UILabel!
    @IBOutlet weak var goalDayLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var ibmLabel: UILabel!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var currentWeightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tmp: UIImage =  Utility.imageWithImage(UIImage(named: "blurred-background-1")!,scaledToSize: self.view.bounds.size)
        self.view.backgroundColor = UIColor.init(patternImage:tmp)
        
        roundView.layer.borderWidth = 3.5
        roundView.layer.borderColor = UIColor.whiteColor().CGColor
        roundView.layer.cornerRadius = roundView.bounds.size.width/2
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let currWeight = (viewModel.user!.goalWeight.value)
        let height = (viewModel.user!.height.value)
        let bmi = currWeight / (height*height)
        let bmiStr = String(format: "BMI: %.2f",bmi)
        let idStr = String(format: "%04d", viewModel.user!.id)
        nameLabel.text = viewModel.user!.name.value
        idLabel.text = "ID:" + idStr
        goalWeightLabel.text = "Goal weight: \(viewModel.user!.goalWeight.value)"
        goalDayLabel.text = "Goal day: \(viewModel.user!.goalDay.value)"
        heightLabel.text = "Height: \(viewModel.user!.height.value)"
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
