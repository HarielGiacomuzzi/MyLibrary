//
//  ParseManager.swift
//  MyLibrary
//
//  Created by Rafael on 8/5/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit
import Parse

class ParseManager: NSObject {
    
    var arrayMaster : [NSDictionary] = []
//    var arrayMaster = [NSDictionary]()
    
    func returnAllLibraries() -> NSArray{
        var arrayLibrary = [NSDictionary]()
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
                        var dict = ["name":object.objectForKey("name")!,"geolocation":object.objectForKey("geolocation")!]
                        arrayLibrary.append(dict)
                        //println(self.arrayMaster.description)
                    }
                }
            }else {
                // Log details of the failure
                println("Error: \(error!)")
            }
        
            dispatch_async(dispatch_get_main_queue(),{
        
                
                self.arrayMaster = arrayLibrary
                println(self.arrayMaster.description)
            })
        }
        println(self.arrayMaster.description)
        return self.arrayMaster
    }
   
}
