//
//  MeusLivrosViewController.swift
//  MyLibrary
//
//  Created by Augusto Boranga on 06/05/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

class MeusLivrosViewController: UIViewController {
    
    var parseMngr = ParseManager()
    var arrayBooks = [NSDictionary]()
    
    @IBOutlet weak var meusLivrosTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        self.arrayBooks = self.parseMngr.returnBooksByUser() as! [(NSDictionary)]
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return arrayBooks.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> MeusLivrosTableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("meusLivrosCell") as! MeusLivrosTableViewCell
            
            cell.nomeLabel.text = arrayBooks[indexPath.row].objectForKey("title") as? String
            //cell.bibliotecaLabel.text = arrayBooks[indexPath.row].objectForKey("libraryid") as? String
            
            cell.bibliotecaLabel.text = parseMngr.returnLibraryName((arrayBooks[indexPath.row].objectForKey("libraryid") as? String)!)
            let userImageFile = arrayBooks[indexPath.row].objectForKey("bookCover") as! PFFile
            cell.imageView?.image = UIImage(data: userImageFile.getData()!)
            
            println("livraria",parseMngr.returnLibrary((arrayBooks[indexPath.row].objectForKey("libraryid") as? String)!))
            
            var dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
            
            cell.dataLabel.text = dateFormatter.stringFromDate((arrayBooks[indexPath.row].objectForKey("datereserved") as? NSDate)!)
            return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            // self.removeCloudKit(dataSource.objectAtIndex(indexPath.row) as! CKRecord, itemIndex: indexPath)
            //            self.parseMngr.bookGetBack((arrayBooks[indexPath.row].objectForKey("id") as? String)!)
            //            self.arrayBooks.removeAtIndex(indexPath.row)
            //            self.meusLivrosTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            //           self.meusLivrosTableView.reloadData()
            
        }
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var button1 = UITableViewRowAction(style: .Default, title: "Devolver!", handler: { (action, indexPath) in
            self.parseMngr.bookGetBack((self.arrayBooks[indexPath.row].objectForKey("id") as? String)!)
            self.arrayBooks.removeAtIndex(indexPath.row)
            self.meusLivrosTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.meusLivrosTableView.reloadData()
        })
        button1.backgroundColor = UIColor(red: 67/255, green: 93/255, blue: 168/255, alpha: 1)
        
        var button2 = UITableViewRowAction(style: .Default, title: "Renovar!", handler: { (action, indexPath) in
            self.parseMngr.renewBook((self.arrayBooks[indexPath.row].objectForKey("id") as? String)!)
            var date = NSDate().dateByAddingTimeInterval(3600*12*5)
            self.arrayBooks = self.parseMngr.returnBooksByUser() as! [(NSDictionary)]
            self.meusLivrosTableView.reloadData()
        })
        button2.backgroundColor = UIColor(red: 120/255, green: 195/255, blue: 97/255, alpha: 1)
        
        
        return [button1,button2]
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
