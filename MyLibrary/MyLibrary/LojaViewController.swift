//
//  LojaViewController.swift
//  MyLibrary
//
//  Created by Augusto Boranga on 06/05/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

class LojaViewController: UIViewController {
    
    let comprasArray = ["Remover ads", "Conta Premium"]
    let precosArray = ["US$ 0.99", "US$ 1.99"]

    @IBOutlet weak var comprasTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return comprasArray.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> LojaTableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("lojaCell") as! LojaTableViewCell
            
            cell.compraLabel.text = comprasArray[indexPath.row]
            cell.precoLabel.text = precosArray[indexPath.row]
            
            return cell
    }
    
    @IBAction func lojaInfo(sender: AnyObject) {
        var infoAlert = UIAlertController(title: "Info", message: "Encontre aqui os upgrades para o app", preferredStyle: UIAlertControllerStyle.Alert)
        
        infoAlert.addAction(UIAlertAction(title: "Entendi", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
        self.presentViewController(infoAlert, animated: true, completion: nil)
    }
}