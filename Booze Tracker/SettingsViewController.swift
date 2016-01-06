//
//  SettingsViewController.swift
//  Booze Tracker
//
//  Created by Paul Keller on 30/11/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import UIKit
import iAd
import StoreKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, ADBannerViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var pickerData: [String] = [String]()
    var defaults = NSUserDefaults.standardUserDefaults()
    var sessionPriceList: PriceList = PriceList(useZero: true)
    var UIiAd: ADBannerView = ADBannerView()
    
    //InApp Purchase
    var productIDs: Array<String!> = []
    var productsArray: Array<SKProduct!> = []
    var transactionInProgress = false
    
    @IBOutlet var beer: UITextField!
    @IBOutlet var redWine: UITextField!
    @IBOutlet var whiteWine: UITextField!
    @IBOutlet var spirit: UITextField!
    @IBOutlet var shots: UITextField!
    @IBOutlet var cocktail: UITextField!
    @IBOutlet var bubbles: UITextField!
    @IBOutlet var softDrink: UITextField!
    @IBOutlet var coffeeTea: UITextField!
    @IBOutlet var barSnacks: UITextField!
    @IBOutlet var liteBites: UITextField!
    @IBOutlet var bigFood: UITextField!
    @IBOutlet var currency: UITextField!
    
    @IBAction func AdFreePurchase(sender: AnyObject) {
        requestProductInfo()
        
        if transactionInProgress {
            return
        }
        
        let actionSheetController = UIAlertController(title: "Bar Bill Tracker", message: "Buy the Ad free version?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let buyAction = UIAlertAction(title: "Buy", style: UIAlertActionStyle.Default) { (action) -> Void in
            let payment = SKPayment(product: self.productsArray[0] as SKProduct)
            SKPaymentQueue.defaultQueue().addPayment(payment)
            self.transactionInProgress = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        
        actionSheetController.addAction(buyAction)
        actionSheetController.addAction(cancelAction)
        
        presentViewController(actionSheetController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func RestorePurchases(sender: AnyObject) {
        
        let actionSheetController = UIAlertController(title: "Bar Bill Tracker", message: "Restore Bar Bill Tracker Purchases?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let restoreAction = UIAlertAction(title: "Restore", style: UIAlertActionStyle.Default) { (action) -> Void in
            SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        
        actionSheetController.addAction(restoreAction)
        actionSheetController.addAction(cancelAction)
        
        presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        saveUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerData = ["$", "£", "€", "¥", "inr", "руб", "₩"]
        productIDs.append("bar_bill_ad_free")
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        currency.inputView = pickerView
        currency.inputAccessoryView = toolBar
        
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
        loadUserDefaults()
        FormLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currency.text = pickerData[row]
    }
    
    func FormLoad(){
        beer.text = String(sessionPriceList.beer)
        redWine.text = String(sessionPriceList.redWine)
        whiteWine.text = String(sessionPriceList.whiteWine)
        spirit.text = String(sessionPriceList.spirit)
        shots.text = String(sessionPriceList.shots)
        cocktail.text = String(sessionPriceList.cocktail)
        bubbles.text = String(sessionPriceList.bubbles)
        softDrink.text = String(sessionPriceList.softDrink)
        coffeeTea.text = String(sessionPriceList.coffeeTea)
        barSnacks.text = String(sessionPriceList.barSnacks)
        liteBites.text = String(sessionPriceList.liteBites)
        bigFood.text = String(sessionPriceList.mainMeal)
        currency.text = sessionPriceList.currency
        
        setNumericKeyPad()
    }
    
    func loadUserDefaults(){
        sessionPriceList.beer = defaults.integerForKey("beer")
        sessionPriceList.redWine = defaults.integerForKey("redWine")
        sessionPriceList.whiteWine = defaults.integerForKey("whiteWine")
        sessionPriceList.spirit = defaults.integerForKey("spirit")
        sessionPriceList.shots = defaults.integerForKey("shots")
        sessionPriceList.cocktail = defaults.integerForKey("cocktail")
        sessionPriceList.bubbles = defaults.integerForKey("bubbles")
        sessionPriceList.softDrink = defaults.integerForKey("softDrink")
        sessionPriceList.coffeeTea = defaults.integerForKey("coffeeTea")
        sessionPriceList.barSnacks = defaults.integerForKey("barSnacks")
        sessionPriceList.liteBites = defaults.integerForKey("liteBites")
        sessionPriceList.mainMeal = defaults.integerForKey("mainMeal")
        
        
        if (defaults.stringForKey("currency") != nil)
        {
            sessionPriceList.currency = defaults.stringForKey("currency")!
        }
    }
    
    func saveUserDefaults(){
        
        sessionPriceList.beer = Int(beer.text!)!
        sessionPriceList.redWine = Int(redWine.text!)!
        sessionPriceList.whiteWine = Int(whiteWine.text!)!
        sessionPriceList.spirit = Int(spirit.text!)!
        sessionPriceList.shots = Int(shots.text!)!
        sessionPriceList.cocktail = Int(cocktail.text!)!
        sessionPriceList.bubbles = Int(bubbles.text!)!
        sessionPriceList.softDrink = Int(softDrink.text!)!
        sessionPriceList.coffeeTea = Int(coffeeTea.text!)!
        sessionPriceList.barSnacks = Int(barSnacks.text!)!
        sessionPriceList.liteBites = Int(liteBites.text!)!
        sessionPriceList.mainMeal = Int(bigFood.text!)!
        sessionPriceList.currency = currency.text!
        
        defaults.setInteger(sessionPriceList.beer, forKey: "beer")
        defaults.setInteger(sessionPriceList.redWine, forKey: "redWine")
        defaults.setInteger(sessionPriceList.whiteWine, forKey: "whiteWine")
        defaults.setInteger(sessionPriceList.spirit, forKey: "spirit")
        defaults.setInteger(sessionPriceList.shots, forKey: "shots")
        defaults.setInteger(sessionPriceList.cocktail, forKey: "cocktail")
        defaults.setInteger(sessionPriceList.bubbles, forKey: "bubbles")
        defaults.setInteger(sessionPriceList.softDrink, forKey: "softDrink")
        defaults.setInteger(sessionPriceList.coffeeTea, forKey: "coffeeTea")
        defaults.setInteger(sessionPriceList.barSnacks, forKey: "barSnacks")
        defaults.setInteger(sessionPriceList.liteBites, forKey: "liteBites")
        defaults.setInteger(sessionPriceList.mainMeal, forKey: "mainMeal")
        defaults.setValue(sessionPriceList.currency, forKey: "currency")
    }
    
    func setNumericKeyPad(){
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneNumericPad")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: true)
        toolBar.userInteractionEnabled = true

        
        beer.keyboardType = UIKeyboardType.NumberPad
        redWine.keyboardType = UIKeyboardType.NumberPad
        whiteWine.keyboardType = UIKeyboardType.NumberPad
        spirit.keyboardType = UIKeyboardType.NumberPad
        shots.keyboardType = UIKeyboardType.NumberPad
        cocktail.keyboardType = UIKeyboardType.NumberPad
        bubbles.keyboardType = UIKeyboardType.NumberPad
        softDrink.keyboardType = UIKeyboardType.NumberPad
        coffeeTea.keyboardType = UIKeyboardType.NumberPad
        barSnacks.keyboardType = UIKeyboardType.NumberPad
        liteBites.keyboardType = UIKeyboardType.NumberPad
        bigFood.keyboardType = UIKeyboardType.NumberPad
        
        beer.inputAccessoryView = toolBar
        redWine.inputAccessoryView = toolBar
        whiteWine.inputAccessoryView = toolBar
        spirit.inputAccessoryView = toolBar
        shots.inputAccessoryView = toolBar
        cocktail.inputAccessoryView = toolBar
        bubbles.inputAccessoryView = toolBar
        softDrink.inputAccessoryView = toolBar
        coffeeTea.inputAccessoryView = toolBar
        barSnacks.inputAccessoryView = toolBar
        liteBites.inputAccessoryView = toolBar
        bigFood.inputAccessoryView = toolBar
        
    }
    
    func donePicker(){
        currency.resignFirstResponder()
    }
    
    func doneNumericPad(){
        beer.resignFirstResponder()
        redWine.resignFirstResponder()
        whiteWine.resignFirstResponder()
        spirit.resignFirstResponder()
        shots.resignFirstResponder()
        cocktail.resignFirstResponder()
        bubbles.resignFirstResponder()
        softDrink.resignFirstResponder()
        coffeeTea.resignFirstResponder()
        barSnacks.resignFirstResponder()
        liteBites.resignFirstResponder()
        bigFood.resignFirstResponder()
    }
    
    func appDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func viewDidAppear(animated: Bool) {
        if (defaults.boolForKey("isAdFree") == false) {
            UIiAd.delegate = self
            UIiAd = self.appDelegate().UIiAd
            UIiAd.frame = CGRectMake(0, 21, 0, 0)
            view.addSubview(UIiAd)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (defaults.boolForKey("isAdFree") == false) {
            UIiAd.delegate = nil
            UIiAd.removeFromSuperview()
        }
        
        saveUserDefaults()
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        //UIiAd.hidden = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 1
        UIView.commitAnimations()
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 0
        UIView.commitAnimations()
        //UIiAd.hidden = true
    }
    
    func requestProductInfo() {
        if SKPaymentQueue.canMakePayments() {
            let productIdentifiers = NSSet(array: productIDs)
            let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
            
            productRequest.delegate = self
            productRequest.start()
        }
        else {
            print("Cannot perform In App Purchases.")
        }
    }
    
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        if response.products.count != 0 {
            for product in response.products {
                productsArray.append(product as SKProduct)
            }
        }
        else {
            print("There are no products.")
        }
        
        if response.invalidProductIdentifiers.count != 0 {
            print(response.invalidProductIdentifiers.description)
        }
    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions as [SKPaymentTransaction] {
            switch transaction.transactionState {
            case SKPaymentTransactionState.Purchased:
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                transactionInProgress = false
                defaults.setBool(true, forKey: "isAdFree")
                self.appDelegate().isAdFree = true
                UIiAd.delegate = nil
                UIiAd.removeFromSuperview()
            case SKPaymentTransactionState.Failed:
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                transactionInProgress = false
                defaults.setBool(false, forKey: "isAdFree")
                self.appDelegate().isAdFree = false
                
            default:
                print("paymentQueue: Error in In-App Purchase")
            }
        }
    }
    
    /*
    func CreateCurrencyArray(){
        pickerData = [
            "Albania Lek (ALL): Lek",
            "Afghanistan Afghani (AFN): ؋",
            "Argentina Peso (ARS): $",
            "Aruba Guilder (AWG): ƒ",
            "Australia Dollar (AUD): $",
            "Azerbaijan New Manat (AZN): ман",
            "Bahamas Dollar (BSD): $",
            "Barbados Dollar (BBD): $",
            "Belarus Ruble (BYR): p.",
            "Belize Dollar (BZD): BZ$",
            "Bermuda Dollar (BMD): $",
            "Bolivia Boliviano (BOB): $b",
            "Bosnia and Herzegovina Convertible Marka (BAM): KM",
            "Botswana Pula (BWP): P",
            "Bulgaria Lev (BGN): лв",
            "Brazil Real (BRL): R$",
            "Brunei Darussalam Dollar (BND): $",
            "Cambodia Riel (KHR): ៛",
            "Canada Dollar (CAD): $",
            "Cayman Islands Dollar (KYD): $",
            "Chile Peso (CLP): $",
            "China Yuan Renminbi (CNY): ¥",
            "Colombia Peso (COP): $",
            "Costa Rica Colon (CRC): ₡",
            "Croatia Kuna (HRK): kn",
            "Cuba Peso (CUP): ₱",
            "Czech Republic Koruna (CZK): Kč",
            "Denmark Krone (DKK): kr",
            "Dominican Republic Peso (DOP): RD$",
            "East Caribbean Dollar (XCD): $",
            "Egypt Pound (EGP): £",
            "El Salvador Colon (SVC): $",
            "Euro Member Countries (EUR): €",
            "Falkland Islands (Malvinas) Pound (FKP): £",
            "Fiji Dollar (FJD): $",
            "Ghana Cedi (GHS): ¢",
            "Gibraltar Pound (GIP): £",
            "Guatemala Quetzal (GTQ): Q",
            "Guernsey Pound (GGP): £",
            "Guyana Dollar (GYD): $",
            "Honduras Lempira (HNL): L",
            "Hong Kong Dollar (HKD): $",
            "Hungary Forint (HUF): Ft",
            "Iceland Krona (ISK): kr",
            "India Rupee (INR): inr",
            "Indonesia Rupiah (IDR): Rp",
            "Iran Rial (IRR): ﷼",
            "Isle of Man Pound (IMP): £",
            "Israel Shekel (ILS): ₪",
            "Jamaica Dollar (JMD): J$",
            "Japan Yen (JPY): ¥",
            "Jersey Pound (JEP): £",
            "Kazakhstan Tenge (KZT): лв",
            "Korea (North) Won (KPW): ₩",
            "Korea (South) Won (KRW): ₩",
            "Kyrgyzstan Som (KGS): лв",
            "Laos Kip (LAK): ₭",
            "Lebanon Pound (LBP): £",
            "Liberia Dollar (LRD): $",
            "Macedonia Denar (MKD): ден",
            "Malaysia Ringgit (MYR): RM",
            "Mauritius Rupee (MUR): ₨",
            "Mexico Peso (MXN): $",
            "Mongolia Tughrik (MNT): ₮",
            "Mozambique Metical (MZN): MT",
            "Namibia Dollar (NAD): $",
            "Nepal Rupee (NPR): ₨",
            "Netherlands Antilles Guilder (ANG): ƒ",
            "New Zealand Dollar (NZD): $",
            "Nicaragua Cordoba (NIO): C$",
            "Nigeria Naira (NGN): ₦",
            "Korea (North) Won (KPW): ₩",
            "Norway Krone (NOK): kr",
            "Oman Rial (OMR): ﷼",
            "Pakistan Rupee (PKR): ₨",
            "Panama Balboa (PAB): B/.",
            "Paraguay Guarani (PYG): Gs",
            "Peru Nuevo Sol (PEN): S/.",
            "Philippines Peso (PHP): ₱",
            "Poland Zloty (PLN): zł",
            "Qatar Riyal (QAR): ﷼",
            "Romania New Leu (RON): lei",
            "Russia Ruble (RUB): руб",
            "Saint Helena Pound (SHP): £",
            "Saudi Arabia Riyal (SAR): ﷼",
            "Serbia Dinar (RSD): Дин.",
            "Seychelles Rupee (SCR): ₨",
            "Singapore Dollar (SGD): $",
            "Solomon Islands Dollar (SBD): $",
            "Somalia Shilling (SOS): S",
            "South Africa Rand (ZAR): R",
            "Korea (South) Won (KRW): ₩",
            "Sri Lanka Rupee (LKR): ₨",
            "Sweden Krona (SEK): kr",
            "Switzerland Franc (CHF): CHF",
            "Suriname Dollar (SRD): $",
            "Syria Pound (SYP): £",
            "Taiwan New Dollar (TWD): NT$",
            "Thailand Baht (THB): ฿",
            "Trinidad and Tobago Dollar (TTD): TT$",
            "Turkey Lira (TRY): try",
            "Tuvalu Dollar (TVD): $",
            "Ukraine Hryvnia (UAH): ₴",
            "United Kingdom Pound (GBP): £",
            "United States Dollar (USD): $",
            "Uruguay Peso (UYU): $U",
            "Uzbekistan Som (UZS): лв",
            "Venezuela Bolivar (VEF): Bs",
            "Viet Nam Dong (VND): ₫",
            "Yemen Rial (YER): ﷼",
            "Zimbabwe Dollar (ZWD): Z$"
        ]
    }
    */
}
