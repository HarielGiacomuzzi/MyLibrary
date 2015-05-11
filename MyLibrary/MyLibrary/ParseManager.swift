//
//  ParseManager.swift
//  MyLibrary
//
//  Created by Rafael on 8/5/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit
import Parse

//esta classe retorna os dados do parse, cada metodo retorna um array de dictionary

class ParseManager: NSObject {
    
    //retorna todas as bibliotecas
    //para converter o objeto geolocation basta instanciar com var location = object.objectForKey("geolocation")! as! PFlocation
    func returnAllLibraries() -> NSArray{
        var arrayLibrary = [NSDictionary]()
        var query = PFQuery(className:"Library")
        //query.whereKey("libraryid", equalTo:"zbMH2yPEYR")
        var objects = query.findObjects()!
        for object in objects{
            var dict = ["id":object.objectId!!, "name":object.objectForKey("name")!, "geolocation":object.objectForKey("geolocation")!]
            arrayLibrary.append(dict)
        }
        return arrayLibrary
    }
    
    //retorna todos os livros
    func returnAllBooks() -> NSArray{
        var arrayBooks = [NSDictionary]()
        var query = PFQuery(className:"Book")
        //query.whereKey("libraryid", equalTo:"zbMH2yPEYR")
        var objects = query.findObjects()!
        for object in objects{
            var dict = ["id":object.objectId!!,"bookCover":object.objectForKey("cover")! as! PFFile, "name":object.objectForKey("title")!, "reserved":object.objectForKey("reserved")!, "libraryid":object.objectForKey("libraryid")!]
            arrayBooks.append(dict)
        }
        return arrayBooks
    }
    
    //retorna todos os livros de uma determinada livraria
    func returnBooksByLibrary(libraryid: String) -> NSArray{
        var arrayBooks = [NSDictionary]()
        var query = PFQuery(className:"Book")
        query.whereKey("libraryid", equalTo:libraryid)
        var objects = query.findObjects()!
        for object in objects{
            var dict = ["id":object.objectId!!,"bookCover":object.objectForKey("cover")! as! PFFile, "title":object.objectForKey("title")!, "reserved":object.objectForKey("reserved")!, "libraryid":object.objectForKey("libraryid")!]
            arrayBooks.append(dict)
        }
        return arrayBooks
    }
    
    //retorna livros do usuario
    func returnBooksByUser() -> NSArray{
        var arrayBooks = [NSDictionary]()
        var query = PFQuery(className:"Book")
        let user = PFUser.currentUser()?.objectId!
        query.whereKey("userid", equalTo:user!)
        var objects = query.findObjects()!
        for object in objects{
            var dict = ["id":object.objectId!!,"bookCover":object.objectForKey("cover")! as! PFFile, "title":object.objectForKey("title")!, "reserved":object.objectForKey("reserved")!, "libraryid":object.objectForKey("libraryid")!]
            arrayBooks.append(dict)
        }
        return arrayBooks
        
    }

    
    //reserva livro por usuario
    func bookGetReserve(bookId: String){
        var arrayBooks = [NSDictionary]()
        var query = PFQuery(className:"Book")
        var currentUser = PFUser.currentUser()?.username
        if(currentUser != ""){
            if let object = query.getObjectWithId(bookId){
                object["reserved"]  = "y"
                self.addAlarm(object)
                object["userid"] = PFUser.currentUser()?.objectId
                object.save()
            }
        }
    }
    //devolve livro do usuario
    func bookGetBack(bookId: String){
        var arrayBooks = [NSDictionary]()
        var query = PFQuery(className:"Book")
        var currentUser = PFUser.currentUser()?.username
        if(currentUser != ""){
            if let object = query.getObjectWithId(bookId){
                object["reserved"]  = "n"
                object["userid"] = ""
                object.save()
            }
        }
    }
    
    func addAlarm(object: PFObject){
        let notification = UILocalNotification()
        let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        notification.timeZone = NSTimeZone.localTimeZone()
        notification.fireDate = NSDate().dateByAddingTimeInterval(10)
        notification.alertBody = "Devolver o livro " + (object.objectForKey("title")! as! String)
        notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        notification.hasAction = true
        notification.alertAction = "View"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    
    
   
}
