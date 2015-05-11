//
//  MeusLivrosViewController.swift
//  MyLibrary
//
//  Created by Augusto Boranga on 06/05/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

class MeusLivrosViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var parseMngr = ParseManager()
        parseMngr.bookGetReserve("SuzNSUG5En")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
