//
//  ViewController.swift
//  MyLibrary
//
//  Created by Hariel Giacomuzzi on 5/6/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var parseMngr = ParseManager()
        var arrayBooks = [NSDictionary]()
        //println(parseMngr.returnBookByLibrary("7nm4Ed3Hct").description)
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            arrayBooks = parseMngr.returnBooksByLibrary("7nm4Ed3Hct") as! [(NSDictionary)]
            
             dispatch_async(dispatch_get_main_queue()) {
            println(arrayBooks.description)
            }
        }
        //println(parseMngr.returnAllBooks().description)

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        
        var username = self.usernameField.text
        var password = self.passwordField.text
        
        var currentUser = PFUser.currentUser()?.username
        if(currentUser != "") {
            // do stuff with the user
            PFUser.logOut()
        }
        
        if(username == "" || password == ""){
            var alert = UIAlertView(title: "Error", message: "Username or Password is empty", delegate: self, cancelButtonTitle: "ok")
            alert.show()
        }else{
            
            self.activity.startAnimating()
            PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) ->
                Void in
                
                self.activity.stopAnimating()
                
                if(user != nil){
                    //perform login
                    self.performSegueWithIdentifier("gotoMain", sender: self)
                    
                }else{
                    
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "ok")
                    alert.show()
                
                }
                
            
            
            })
                
        }
        
    }

    
    @IBAction func signup(sender: AnyObject) {
        self.performSegueWithIdentifier("gotoSignup", sender: self)

    }

}

