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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
            cell.bibliotecaLabel.text = arrayBooks[indexPath.row].objectForKey("libraryid") as? String
            
            println(arrayBooks[indexPath.row].objectForKey("title") as? String)
            
            
            
//*** Transforma os PFFile em UIImage e põe na célula ***
//            let imageFile : PFFile = arrayBooks[indexPath.row].objectForKey("cover") as! PFFile
//            imageFile.getDataInBackgroundWithBlock ({ (imageData: NSData?, error : NSError?) -> Void in
//                if (error == nil) {
//                    let imageLoaded = UIImage(data:imageData!)
//                    //                    println(imageLoaded)
//                    cell.capaImageView.image = imageLoaded
//                }
//                }, progressBlock: {
//                    (percentDone: CInt) -> Void in
//                }
//            )
            
            return cell
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
