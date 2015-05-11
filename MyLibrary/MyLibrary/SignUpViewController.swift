//
//  SignUpViewController.swift
//  MyLibrary
//
//  Created by Rafael on 7/5/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signup(sender: AnyObject) {
        
        var currentUser = PFUser.currentUser()?.username
        if(currentUser != "") {
            // do stuff with the user
            PFUser.logOut()
        }
        
        var username = self.usernameField.text
        var password = self.passwordField.text
        var confirmPassword = self.confirmPasswordField.text
        
        if(username == "" || password == "" || confirmPassword == "" ){
            var alert = UIAlertView(title: "Error", message: "Empty Field detected", delegate: self, cancelButtonTitle: "ok")
            alert.show()
        }else if(password != confirmPassword){
            var alert = UIAlertView(title: "Error", message: "Passwords didn't match", delegate: self, cancelButtonTitle: "ok")
            alert.show()
        }else{
            
            var newUser = PFUser()
            newUser.username = username
            newUser.password = password
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
            
                if(error != nil){
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "ok")
                    alert.show()
                }else{
                    self.performSegueWithIdentifier("gotoMain", sender: self)
                }
            
            })
            
        }
        
    }
    
}
