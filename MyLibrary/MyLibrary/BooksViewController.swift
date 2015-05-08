//
//  BooksViewController.swift
//  MyLibrary
//
//  Created by Rafael on 7/5/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit
import Parse
class BooksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println(PFUser.currentUser()!.username!)
        
        var query = PFQuery(className:"Library")
        //query.whereKey("libraryid", equalTo:"zbMH2yPEYR")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        //println(object.objectForKey("geolocation")!)
                    }
                }
            } else {
                // Log details of the failure
                //println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        // Do any additional setup after loading the view.
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
