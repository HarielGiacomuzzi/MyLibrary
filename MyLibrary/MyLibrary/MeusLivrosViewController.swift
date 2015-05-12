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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    @IBAction func logoutPressed(sender: AnyObject) {
        
        var refreshAlert = UIAlertController(title: "Logout", message: "Tem certeza que deseja sair?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Não", style: .Default, handler: { (action: UIAlertAction!) in
            
            println("Não deslogou")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction!) in
            
            PFUser.logOut()
            println("Deslogou")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func meusLivrosInfo(sender: AnyObject) {
        var infoAlert = UIAlertController(title: "Info", message: "Aqui são mostrados os livros que você está locando. Deslize para renovar ou devolver", preferredStyle: UIAlertControllerStyle.Alert)
        
        infoAlert.addAction(UIAlertAction(title: "Entendi", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
        self.presentViewController(infoAlert, animated: true, completion: nil)
    }

    
}
