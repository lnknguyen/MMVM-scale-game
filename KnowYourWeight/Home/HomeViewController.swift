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
    
    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tmp: UIImage =  Utility.imageWithImage(UIImage(named: "blurred-background-1")!,scaledToSize: self.view.bounds.size)
        self.view.backgroundColor = UIColor.init(patternImage:tmp)
        
        roundView.layer.borderWidth = 3.5
        roundView.layer.borderColor = UIColor.whiteColor().CGColor
        roundView.layer.cornerRadius = roundView.bounds.size.width/2
        
        bindViewModel()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        var currWeight : Float = 0.0
        bindViewModel(){
            
            if (self.viewModel.scaleData.count>0){
                if let val : Float = (self.viewModel.scaleData.last?.value.value)!{
                    currWeight = val
                    self.currentWeightLabel.text = "\(currWeight)"
                    let height = (self.viewModel.user!.height.value)
                    let bmi = currWeight / (height*height)
                    let bmiStr = String(format: "BMI: %.2f",bmi)
                   
                    self.ibmLabel.text = bmiStr
                    
                    if (bmi < 18.5 && bmi != 0.0){
                        self.statusLabel.text = "Underweight"
                    } else if (bmi >= 18.5 && bmi < 24.9 ){
                        self.statusLabel.text = "Normal"
                    } else if (bmi >= 24.9 && bmi < 29.9){
                        self.statusLabel.text = "Overweight"
                    } else if (bmi >= 29.9){
                        self.statusLabel.text = "Obesity"
                    }else{
                        self.statusLabel.text = "No data"
                    }
                }
            }
        }
        
        
        let idStr = String(format: "%04d", viewModel.user!.id)
        nameLabel.text = viewModel.user!.name.value
        idLabel.text = "ID:" + idStr
        goalWeightLabel.text = "Goal weight: \(viewModel.user!.goalWeight.value)"
        goalDayLabel.text = "Goal day: \(viewModel.user!.goalDay.value)"
        heightLabel.text = "Height: \(viewModel.user!.height.value)"
        
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindViewModel(completionHandler:()->Void = {}){
        viewModel.loadScaleData(){
            completionHandler()
        }
    }


    
    // MARK: - Navigation

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
