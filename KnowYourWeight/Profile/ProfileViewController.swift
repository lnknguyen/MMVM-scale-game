//
//  ProfileViewController.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/12/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import Bond

class ProfileViewController: UIViewController {
    
    var viewModel = ProfileViewModel()
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmp: UIImage =  Utility.imageWithImage(UIImage(named: "blurred-background-1")!,scaledToSize: self.view.bounds.size)
        self.view.backgroundColor = UIColor.init(patternImage:tmp)
        
        
        saveButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        heightTextField.bnd_text.map { (value) -> Float in
            guard let val=Float(value!) else {
                return 0.0
            }
            return val
            }.bindTo(viewModel.user!.height)
        
        weightTextField.bnd_text.map { (value) -> Float in
            guard let val=Float(value!) else {
                return 0.0
            }
            return val
            }.bindTo(viewModel.user!.goalWeight)
        
        dayTextField.bnd_text.map { (value) -> Int in
            guard let val=Int(value!) else {
                return 0
            }
            return val
            }.bindTo(viewModel.user!.goalDay)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //heightTextField.text = String(format: "%.02f m", viewModel.user!.height.value)
        heightTextField.clearsOnBeginEditing = true
        
        //weightTextField.text = String(format: "%.02f kg", viewModel.user!.goalWeight.value)
        weightTextField.clearsOnBeginEditing = true
        
        //dayTextField.text = "\(viewModel.user!.goalDay.value)"
        dayTextField.clearsOnBeginEditing = true
        
        
        
        combineLatest(heightTextField.bnd_text, weightTextField.bnd_text, dayTextField.bnd_text)
            .map { (height, weight, day) -> Bool in
                let valid = (height!.characters.count > 0 && weight!.characters.count > 0 && day!.characters.count > 0)
                return !valid
            }
            .bindTo(saveButton.bnd_hidden)
        
        saveButton.bnd_enabled.map { (val) -> UIColor in
            return val ? UIColor.init(red: 229/255, green: 229/255, blue: 229/255, alpha: 100): UIColor.clearColor()
            }.bindTo(saveButton.bnd_backgroundColor)
        
        
        saveButton.hidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSaveButtonTap(){
        
        viewModel.updateUserInfo(viewModel.user!)
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
