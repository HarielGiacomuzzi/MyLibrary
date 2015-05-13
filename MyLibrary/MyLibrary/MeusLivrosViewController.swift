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
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            self.arrayBooks = self.parseMngr.returnBooksByUser() as! [(NSDictionary)]
            
            dispatch_async(dispatch_get_main_queue()) {
                self.meusLivrosTableView.reloadData()
            }
        }

       // self.arrayBooks = self.parseMngr.returnBooksByUser() as! [(NSDictionary)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.parseMngr.bookGetReserve("J0Oziyiz40")
//        self.parseMngr.bookGetReserve("aHRQPmMXHt")
//        self.parseMngr.bookGetReserve("SuzNSUG5En")
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return arrayBooks.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> MeusLivrosTableViewCell {
            var libraryName = ""
            let cell = tableView.dequeueReusableCellWithIdentifier("meusLivrosCell") as! MeusLivrosTableViewCell
            
            cell.nomeLabel.text = arrayBooks[indexPath.row].objectForKey("title") as? String
            //cell.bibliotecaLabel.text = arrayBooks[indexPath.row].objectForKey("libraryid") as? String
            
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
                libraryName = self.parseMngr.returnLibraryName((self.arrayBooks[indexPath.row].objectForKey("libraryid") as? String)!)
                
                dispatch_async(dispatch_get_main_queue()) {
                    cell.bibliotecaLabel.text = libraryName
                }
            }
            

            
            
            
            
            let userImageFile = arrayBooks[indexPath.row].objectForKey("bookCover") as! PFFile
            cell.imageView?.image = UIImage(data: userImageFile.getData()!)
            
//            println("livraria",parseMngr.returnLibrary((arrayBooks[indexPath.row].objectForKey("libraryid") as? String)!))
            
            var dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
            if(dateFormatter.stringFromDate((arrayBooks[indexPath.row].objectForKey("datereserved") as? NSDate)!) == dateFormatter.stringFromDate(NSDate()))
            {
                cell.dataLabel.textColor = UIColor.redColor()
            }
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
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
                self.parseMngr.bookGetBack((self.arrayBooks[indexPath.row].objectForKey("id") as? String)!)
                self.arrayBooks.removeAtIndex(indexPath.row)
                self.meusLivrosTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.meusLivrosTableView.reloadData()
                }
            }
        })
        button1.backgroundColor = UIColor.blueColor()
        
        var button2 = UITableViewRowAction(style: .Default, title: "Renovar!", handler: { (action, indexPath) in
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
                self.parseMngr.renewBook((self.arrayBooks[indexPath.row].objectForKey("id") as? String)!)
                var date = NSDate().dateByAddingTimeInterval(3600*12*5)
                self.arrayBooks = self.parseMngr.returnBooksByUser() as! [(NSDictionary)]
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.meusLivrosTableView.reloadData()
                }
            }
            
        })
        button2.backgroundColor = UIColor.orangeColor()
        
        
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
