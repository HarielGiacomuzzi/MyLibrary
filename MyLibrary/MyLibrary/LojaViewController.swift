//
//  LojaViewController.swift
//  MyLibrary
//
//  Created by Augusto Boranga on 06/05/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit
import StoreKit

class LojaViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //MARK:Variables
    var removeAdsProduct : SKProduct?
    var productsRequest : SKProductsRequest?
    
    //MARK:Main Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        requestProductsData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestProductsData(){
        var productsIdentifiers = NSSet(object: "com.giacomuzzi")
        productsRequest = SKProductsRequest(productIdentifiers: productsIdentifiers as Set<NSObject>)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    
    //MARK:TransactionsControl
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction {
            switch trans.transactionState {
        case .Purchasing:
            println("Purchasing Product");
        break;
        case .Failed:
            println("Purchase Failed");
        break;
        case .Restored:
            println("Product Restored");
        break;
        case .Purchased:
                self.completeTransactions(trans);
                println("Product Purchased");
        SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
        break;
        default:
            break;
            }; }
        }
    }
    
    func completeTransactions(transaction: SKPaymentTransaction){
                self.provideContent(transaction.payment.productIdentifier)
                self.finishTransaction(true, transaction: transaction);
    }
    
    func provideContent(productId : String){
        if (productId == removeAdsProduct?.productIdentifier)
        {
            println("Ads Removed");
            var infoAlert = UIAlertController(title: "Info", message: "Ads Removed", preferredStyle: UIAlertControllerStyle.Alert)
            
            infoAlert.addAction(UIAlertAction(title: "Entendi", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            self.presentViewController(infoAlert, animated: true, completion: nil)
        }
    }
    
    func finishTransaction(success : Bool, transaction : SKPaymentTransaction){
            SKPaymentQueue.defaultQueue().finishTransaction(transaction)
            if(success){
                println("Success");
            }else{
                println("Transaction Failed");
            }
    }
    
    //MARK:SKProductsRequestDelegate
    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
        var products = response.products
        if products.count == 1 {
            removeAdsProduct = products.first as? SKProduct
        }else{
            removeAdsProduct = nil
        }
            
        if (removeAdsProduct != nil)
        {
            //TODO:finish this part
        }
        
        for invalid in response.invalidProductIdentifiers{
            println(invalid)
        }

    }
    
    
}

