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
    //para converver o objeto geolocation basta instanciar com var location = object.objectForKey("geolocation")! as! PFlocation
    
    
    
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
    
    func returnLibrary(libraryid: String) -> NSArray{
        var arrayLibrary = [NSDictionary]()
        var query = PFQuery(className:"Library")
        query.getObjectWithId(libraryid)
        var objects = query.findObjects()!
        for object in objects{
            var dict = ["id":object.objectId!!, "name":object.objectForKey("name")!, "geolocation":object.objectForKey("geolocation")!]
            arrayLibrary.append(dict)
        }
        
        return arrayLibrary
        
    }
    
    func returnLibraryName(libraryid: String) -> String{
        var libraryName = String()
        var query = PFQuery(className:"Library")
        query.getObjectWithId(libraryid)
        var objects = query.findObjects()!
        for object in objects{
            libraryName = object.objectForKey("name")! as! String
        }
        
        return libraryName
        
    }
    
    
    
    func returnBookByName(bookName: String) -> NSArray{
        var arrayBooks = [NSDictionary]()
        var query = PFQuery(className:"Book")
        query.whereKey("libraryid", equalTo:bookName)
        var objects = query.findObjects()!
        for object in objects{
            var dict = ["id":object.objectId!!,"bookCover":object.objectForKey("cover")! as! PFFile, "title":object.objectForKey("title")!, "reserved":object.objectForKey("reserved")!, "libraryid":object.objectForKey("libraryid")!,"datereserved":object.objectForKey("datereserved")!,"majorid":object.objectForKey("majorid")!,"minor":object.objectForKey("minorid")!,"beaconuuid":object.objectForKey("beaconuuid")!,"beaconidentifier":object.objectForKey("beaconidentifier")!]
            arrayBooks.append(dict)
        }
        return arrayBooks
        
        
    }
    
    
    
    //retorna todos os livros
    func returnAllBooks() -> NSArray{
        var arrayBooks = [NSDictionary]()
        var query = PFQuery(className:"Book")
        //query.whereKey("libraryid", equalTo:"zbMH2yPEYR")
        var objects = query.findObjects()!
        for object in objects{
            var dict = ["id":object.objectId!!,"bookCover":object.objectForKey("cover")! as! PFFile, "title":object.objectForKey("title")!, "reserved":object.objectForKey("reserved")!, "libraryid":object.objectForKey("libraryid")!,"datereserved":object.objectForKey("datereserved")!,"majorid":object.objectForKey("majorid")!,"minor":object.objectForKey("minorid")!,"beaconuuid":object.objectForKey("beaconuuid")!,"beaconidentifier":object.objectForKey("beaconidentifier")!]
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
            var dict = ["id":object.objectId!!,"bookCover":object.objectForKey("cover")! as! PFFile, "title":object.objectForKey("title")!, "reserved":object.objectForKey("reserved")!, "libraryid":object.objectForKey("libraryid")!,"majorid":object.objectForKey("majorid")!,"minor":object.objectForKey("minorid")!,"beaconuuid":object.objectForKey("beaconuuid")!,"beaconidentifier":object.objectForKey("beaconidentifier")!]
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
            var dict = ["id":object.objectId!!,"bookCover":object.objectForKey("cover")! as! PFFile, "title":object.objectForKey("title")!, "reserved":object.objectForKey("reserved")!, "libraryid":object.objectForKey("libraryid")!,"datereserved":object.objectForKey("datereserved")!,"majorid":object.objectForKey("majorid")!,"minor":object.objectForKey("minorid")!,"beaconuuid":object.objectForKey("beaconuuid")!,"beaconidentifier":object.objectForKey("beaconidentifier")!]
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
                object["datereserved"] = NSDate().dateByAddingTimeInterval(3600*24*5)
                self.addAlarm(object)
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
                self.removeAlarm(object["title"]! as! String)
                //object["datereserved"] = ""
                object.save()
            }
        }
    }
    
    func renewBook(bookId: String){
        var arrayBooks = [NSDictionary]()
        var query = PFQuery(className:"Book")
        var currentUser = PFUser.currentUser()?.username
        if(currentUser != ""){
            if let object = query.getObjectWithId(bookId){
                object["reserved"]  = "y"
                object["userid"] = PFUser.currentUser()?.objectId
                object["datereserved"] = NSDate().dateByAddingTimeInterval(3600*24*5)
                self.removeAlarm(object["title"]! as! String)
                self.addAlarm(object)
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
    
    func removeAlarm(bookName: String){
        var notifications = UIApplication.sharedApplication().scheduledLocalNotifications
        var name = "Devolver o livro " + bookName
        for notification in notifications{
            if (notification.alertBody == name){
                UIApplication.sharedApplication().cancelLocalNotification(notification as! UILocalNotification)
            }
        }
    }
    
    
}
