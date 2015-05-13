//
//  LojaViewController.swift
//  MyLibrary
//
//  Created by Augusto Boranga on 06/05/15.
//  Copyright (c) 2015 Hariel Giacomuzzi. All rights reserved.
//

import UIKit
import StoreKit

class LojaViewController: UIViewController,UITableViewDataSource,UITableViewDelegate , SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //MARK:Variables
    var removeAdsProduct : SKProduct?
    var productsRequest : SKProductsRequest?
    let comprasArray = ["Remover ads", "Conta Premium"]
    let precosArray = ["US$ 0.99", "US$ 1.99"]
    @IBOutlet weak var comprasTableView: UITableView!
    
    
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
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return comprasArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(SKPaymentQueue.canMakePayments()){
            var infoAlert = UIAlertController(title: "Sucesso", message: "Obrigado pela compra", preferredStyle: UIAlertControllerStyle.Alert)
            
            infoAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            self.presentViewController(infoAlert, animated: true, completion: nil)
            //let payment:SKPayment = SKPayment(product: removeAdsProduct)
            //SKPaymentQueue.defaultQueue().addPayment(payment)
        }else{
            var infoAlert = UIAlertController(title: "Erro", message: "Desculpe, mas você não pode realizar compras", preferredStyle: UIAlertControllerStyle.Alert)
            
            infoAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            self.presentViewController(infoAlert, animated: true, completion: nil)
        }
        
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
            self.failedTransaction(trans)
            println("Purchase Failed");
        break;
        case .Restored:
            self.restoreTransaction(trans)
            println("Product Restored");
        break;
        case .Purchased:
                self.completeTransactions(trans);
                println("Product Purchased");
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
    
    func restoreTransaction(transaction: SKPaymentTransaction){
        self.provideContent(transaction.originalTransaction.payment.productIdentifier)
        self.finishTransaction(true, transaction: transaction)
    }
    
    func provideContent(productId : String){
        if (productId == removeAdsProduct?.productIdentifier)
        {
            println("Ads Removed");
            var infoAlert = UIAlertController(title: "Info", message: "Ads Removed", preferredStyle: UIAlertControllerStyle.Alert)
            
            infoAlert.addAction(UIAlertAction(title: "Got it !", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            self.presentViewController(infoAlert, animated: true, completion: nil)
        }
    }
    
    func failedTransaction(transaction: SKPaymentTransaction){
        if (transaction.error.code != SKErrorPaymentCancelled)
        {
            // error!
            self.finishTransaction(false, transaction: transaction)
        }
        else
        {
            // this is fine, the user just cancelled, so don’t notify
            SKPaymentQueue.defaultQueue().finishTransaction(transaction)
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