//
//  SignUpViewController.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/3/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import Bond
class SignUpViewController: UIViewController{

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var heighttextField: UITextField!
    @IBOutlet weak var goalDayTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var goalWeightTextField: UITextField!
    let viewModel = SignUpViewModel()
    var pass = Observable<String>("")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tmp: UIImage =  Utility.imageWithImage(UIImage(named: "blurred-background-1")!,scaledToSize: self.view.bounds.size)
        self.view.backgroundColor = UIColor.init(patternImage:tmp)
        
        validateSignup()
    }
    
    func validateSignup(){
        usernameTextField.bnd_text.map { (value) -> String in
            guard let val = value else {
                return ""
            }
            return val
        }.bindTo(viewModel.user.name)
        
        
        goalDayTextField.bnd_text.map { (value) -> Int in
            guard let val=Int(value!) else {
                return 0
            }
            return val
        }.bindTo(viewModel.user.goalDay)
        
        goalWeightTextField.bnd_text.map { (value) -> Float in
            guard let val=Float(value!) else {
                return 0.0
            }
            return val
        }.bindTo(viewModel.user.goalWeight)
        
        heighttextField.bnd_text.map { (value) -> Float in
            guard let val=Float(value!) else {
                return 0.0
            }
            return val
        }.bindTo(viewModel.user.height)
        
        passwordTextField.bnd_text.map { (value) -> String in
            guard let val = value else {
                return ""
            }
            return val
        }.bindTo(pass)
        
        pass.observe { (str) in
            print(str)
        }
        
        combineLatest(usernameTextField.bnd_text, passwordTextField.bnd_text,
            confirmPasswordTextField.bnd_text,goalDayTextField.bnd_text,
            goalWeightTextField.bnd_text,heighttextField.bnd_text)
            .map { name, pass, confirmPass, day, weight, height  in
                
                let valid = (name?.characters.count > 0 && pass?.characters.count > 0
                && confirmPass?.characters.count > 0 && day?.characters.count > 0
                && weight?.characters.count > 0 && height?.characters.count > 0)
                && (confirmPass == pass)
                
                return valid
            }
            .bindTo(doneButton.bnd_enabled)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onDoneButtonTapped(){
        viewModel.signUpForUserWithPassword(pass.value)
      //  self.performSegueWithIdentifier(Route.FROM_LOGIN_TO_SIGN_UP, sender: self)
    }
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

  
    

}
