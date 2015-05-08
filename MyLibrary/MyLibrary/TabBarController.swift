//
//  TabBarController.swift
//  MyLibrary
//
//  Created by Augusto Boranga on 07/05/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let defaultItemColor = UIColor(red: 76.0/255.0, green: 76.0/255.0, blue: 82.0/255.0, alpha: 1.0)
    let selectedItemColor = UIColor.whiteColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = selectedItemColor
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : defaultItemColor], forState: UIControlState.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: UIControlState.Selected)
        
        
        for item in self.tabBar.items as! [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithRenderingMode(.AlwaysOriginal)
            }
        }
        
    }
    
}