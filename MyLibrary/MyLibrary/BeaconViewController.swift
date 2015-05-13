//
//  BeaconViewController.swift
//  MyLibrary
//
//  Created by Augusto Boranga on 06/05/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconViewController: UIViewController, CLLocationManagerDelegate {
    
    
    //MARK: Outlets
    @IBOutlet weak var lbl_BookTittle: UILabel!
    @IBOutlet weak var txt_BookLocation: UITextView!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var bibliotecaNome: UILabel!
    
    //MARK: UsefullVariables
    var bookTittle : String?
    var bookLocation : String?
    var beaconUUID : NSUUID?
    var beaconIdentifier : String?;
    let locationManager = CLLocationManager()
    var beaconRegion : CLBeaconRegion?
    var beaconMajor : CLBeaconMajorValue?
    var beaconMinor : CLBeaconMinorValue?
    
    //MARK: MainMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // testing Variables
        if(bookTittle == nil){
            bookTittle = "Divina Comédia"
        }
        if(bookLocation == nil){
            bookLocation = "Biblioteca Pucrs - 3ro andar - prateleira 6c"
        }
        if(beaconUUID == nil){
            beaconUUID = NSUUID(UUIDString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
        }
        if(beaconIdentifier == nil){
            beaconIdentifier = "com.example.apple-samplecode.AirLocate"
        }
        if(beaconMinor == nil){
            beaconMinor = 1
        }
        if(beaconMajor == nil){
            beaconMajor = 2
        }
        // testing Variables
        
        
        self.lbl_BookTittle.text = self.bookTittle;
        self.txt_BookLocation.text = self.bookLocation;
        beaconRegion = CLBeaconRegion(proximityUUID: self.beaconUUID, identifier: self.beaconIdentifier);
    }
    
    override func viewDidAppear(animated: Bool) {
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization();
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways {
            locationManager.startMonitoringForRegion(beaconRegion)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        locationManager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        if (beacons.count > 0) {
            for(var i = 0; i < (beacons as! [CLBeacon]).count; i++){
                
                let currentBeacon = beacons[i] as! CLBeacon
                
                if (currentBeacon.major.unsignedShortValue as CLBeaconMajorValue) == beaconMajor! && (currentBeacon.minor.unsignedShortValue as CLBeaconMinorValue) == beaconMinor! {
                    if((beacons[i] as! CLBeacon).accuracy == -1) {
                        self.lblDistance.text = "Out of Range!";
                    }else{
                        self.lblDistance.text = round((beacons[i] as! CLBeacon).accuracy).description;
                    }
                }
            }
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        locationManager.stopMonitoringForRegion(beaconRegion);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: RentButtonAction
    @IBAction func bookRented(sender: AnyObject) {
    }
    
}
