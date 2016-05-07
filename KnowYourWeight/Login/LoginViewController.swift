//
//  LoginViewController.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/5/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import Bond
class LoginViewController: UIViewController {

    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        let tmp: UIImage =  Utility.imageWithImage(UIImage(named: "blurred-background-1")!,scaledToSize: self.view.bounds.size)
        self.view.backgroundColor = UIColor.init(patternImage:tmp)
        
        combineLatest(usernameTextField.bnd_text, passwordTextField.bnd_text)
            .map { (username, password) -> Bool in
            return (username?.characters.count > 0 && password?.characters.count > 0)
        }.bindTo(okButton.bnd_enabled)
        
        okButton.bnd_enabled.map { (val) -> UIColor in
            return val ? UIColor.blackColor() : UIColor.lightGrayColor()
        }.bindTo(okButton.bnd_backgroundColor)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okButtonTapped(sender: AnyObject) {
        viewModel.validateUserLogin(usernameTextField.bnd_text.value!, password: passwordTextField.bnd_text.value!){
            self.performSegueWithIdentifier(Route.FROM_LOGIN_TO_TABBAR, sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Route.FROM_LOGIN_TO_TABBAR{
            let tabBarVc = segue.destinationViewController as! UITabBarController
            let destinationVc1 = tabBarVc.viewControllers![0] as! HomeViewController
            let destinationVc2 = tabBarVc.viewControllers![1] as! GraphViewController
            
            let user = viewModel.user
            
            let homeViewModel = HomeViewModel()
            let graphViewModel = GraphViewModel()
            homeViewModel.user = user
            graphViewModel.user = user
            
            destinationVc1.viewModel = homeViewModel
            destinationVc2.viewModel = graphViewModel
            
            
        }
    }
    
    
    @IBAction func cancelSignUp(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveUser(segue:UIStoryboardSegue) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    



}
