//
//  SignUpViewController.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/3/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var heighttextField: UITextField!
    @IBOutlet weak var goalDayTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tmp: UIImage =  Utility.imageWithImage(UIImage(named: "blurred-background-1")!,scaledToSize: self.view.bounds.size)
        self.view.backgroundColor = UIColor.init(patternImage:tmp)
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
