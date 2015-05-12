//
//  TabBarViewController.swift
//  MyLibrary
//
//  Created by Augusto Boranga on 12/05/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

class TabBarViewController: UITabBarController {

    let selectedItemColor = UIColor.whiteColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = selectedItemColor
        
        for item in self.tabBar.items as! [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithRenderingMode(.AlwaysOriginal)
            }
        }
        
    }



}