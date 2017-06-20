//
//  SecondViewController.swift
//  Booze Tracker
//
//  Created by Paul Keller on 30/11/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import UIKit
import iAd
import Social

class BoozeTrackerViewController: UIViewController, ADBannerViewDelegate {
    
    var defaults = UserDefaults.standard
    var sessionPriceList: PriceList = PriceList(useZero: true)
    var UIiAd: ADBannerView = ADBannerView()
        
    @IBOutlet var beerLabel: UILabel!
    @IBOutlet var redWineLabel: UILabel!
    @IBOutlet var whiteWineLabel: UILabel!
    @IBOutlet var spiritLabel: UILabel!
    @IBOutlet var shotsLabel: UILabel!
    @IBOutlet var cocktailLabel: UILabel!
    @IBOutlet var bubblesLabel: UILabel!
    @IBOutlet var softLabel: UILabel!
    @IBOutlet var coffeeLabel: UILabel!
    @IBOutlet var barSnacksLabel: UILabel!
    @IBOutlet var liteBitesLabel: UILabel!
    @IBOutlet var bigFoodLabel: UILabel!
    @IBOutlet var runningTotalLabel: UILabel!
    @IBOutlet var beerStepper: UIStepper!
    @IBOutlet var redWineStepper: UIStepper!
    @IBOutlet var whiteWineStepper: UIStepper!
    @IBOutlet var spiritStepper: UIStepper!
    @IBOutlet var shotsStepper: UIStepper!
    @IBOutlet var cocktailStepper: UIStepper!
    @IBOutlet var bubblesStepper: UIStepper!
    @IBOutlet var softDrinkStepper: UIStepper!
    @IBOutlet var coffeeTeaStepper: UIStepper!
    @IBOutlet var barSnacksStepper: UIStepper!
    @IBOutlet var liteBitesStepper: UIStepper!
    @IBOutlet var mainMealStepper: UIStepper!
    @IBOutlet var sessionLocation: UITextField!
    @IBAction func newSession(_ sender: AnyObject) {
        ClearAllTotals()
        refreshSessionPriceList()
        
        sessionLocation.text = ""
        defaults.set("", forKey: "SessionLocation")
        defaults.set("", forKey: "SessionAmount")
    }
    

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let labelName = getLabelNameFromTag(sender.tag)
        labelName.text = Int(sender.value).description
        
        runningTotalLabel.text = sessionPriceList.currency + " \(updateRunningTotal())"
    }
    
    @IBAction func twitterButtonPushed(_ sender: AnyObject) {
        
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Another booze session tracked at \(defaults.string(forKey: "SessionLocation")!) on the Booze Tracker App. \(socialNetworkMessage())")
            self.present(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func facebookButtonPushed(_ sender: AnyObject) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Another booze session tracked at \(defaults.string(forKey: "SessionLocation")!) on the Booze Tracker App. \(socialNetworkMessage())")
            self.present(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func socialNetworkMessage() -> String {
        var message: String = ""
        let currentTotal: Int = updateRunningTotal()
        if (currentTotal <= 50)
        {
            message = "Only \(sessionPriceList.currency)\(currentTotal) to pay!"
        }
        else if (currentTotal <= 100)
        {
            message = "Not bad, \(sessionPriceList.currency)\(currentTotal) to pay!"
        }
        else
        {
            message = "Whoops, \(sessionPriceList.currency)\(currentTotal) to pay!"
        }
        
        return message
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupLocationEntry()
        refreshSessionPriceList()
        runningTotalLabel.text = sessionPriceList.currency + " \(updateRunningTotal())"
        if (defaults.string(forKey: "SessionLocation") == nil || defaults.string(forKey: "SessionLocation") == "")
        {
            sessionLocation.text = ""
        }
        else
        {
            sessionLocation.text = defaults.string(forKey: "SessionLocation")!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRunningTotal() -> Int{
        
        var runningTotal:Int = 0
        
        for var i = 0; i <= 11; i += 1 {
            let lblLabel:UILabel = getLabelNameFromTag(i)
            let count:String? = lblLabel.text
            let a:Int? = Int(count ?? "")
            runningTotal += a! * getPriceFromTag(i)
        }
        
        defaults.set(sessionPriceList.currency + String(runningTotal), forKey: "SessionAmount")
        
        return runningTotal
    }
    
    func getLabelNameFromTag(_ stepperTag: Int) -> UILabel {
        switch stepperTag {
        
        case 0:
            return beerLabel
        case 1:
            return redWineLabel
        case 2:
            return whiteWineLabel
        case 3:
            return spiritLabel
        case 4:
            return shotsLabel
        case 5:
            return cocktailLabel
        case 6:
            return bubblesLabel
        case 7:
            return softLabel
        case 8:
            return coffeeLabel
        case 9:
            return barSnacksLabel
        case 10:
            return liteBitesLabel
        case 11:
            return bigFoodLabel
        default:
            return beerLabel
        }
    }
    
    func getPriceFromTag(_ stepperTag: Int) -> Int {
        
        switch stepperTag {
            
        case 0: //beerLabel
            return sessionPriceList.beer
        case 1: //redWineLabel
            return sessionPriceList.redWine
        case 2: //whiteWineLabel
            return sessionPriceList.whiteWine
        case 3: //spiritLabel
            return sessionPriceList.spirit
        case 4: //shotsLabel
            return sessionPriceList.shots
        case 5: //cocktailLabel
            return sessionPriceList.cocktail
        case 6: //bubblesLabel
            return sessionPriceList.bubbles
        case 7: //softLabel
            return sessionPriceList.softDrink
        case 8: //coffeeLabel
            return sessionPriceList.coffeeTea
        case 9: //barSnacksLabel
            return sessionPriceList.barSnacks
        case 10: //liteBitesLabel
            return sessionPriceList.liteBites
        case 11: //bigFoodLabel
            return sessionPriceList.mainMeal
        default:
            return 0
        }
    }
    
    func ClearAllTotals(){
        
        beerStepper.value = 0
        redWineStepper.value = 0
        whiteWineStepper.value = 0
        spiritStepper.value = 0
        shotsStepper.value = 0
        cocktailStepper.value = 0
        bubblesStepper.value = 0
        softDrinkStepper.value = 0
        coffeeTeaStepper.value = 0
        barSnacksStepper.value = 0
        liteBitesStepper.value = 0
        mainMealStepper.value = 0
        
        beerLabel.text = String("0")
        redWineLabel.text = String("0")
        whiteWineLabel.text = String("0")
        spiritLabel.text = String("0")
        shotsLabel.text = String("0")
        cocktailLabel.text = String("0")
        bubblesLabel.text = String("0")
        softLabel.text = String("0")
        coffeeLabel.text = String("0")
        barSnacksLabel.text = String("0")
        liteBitesLabel.text = String("0")
        bigFoodLabel.text = String("0")
        runningTotalLabel.text = sessionPriceList.currency + " \(updateRunningTotal())"
    }
    
    func refreshSessionPriceList(){
        sessionPriceList.beer = defaults.integer(forKey: "beer")
        sessionPriceList.redWine = defaults.integer(forKey: "redWine")
        sessionPriceList.whiteWine = defaults.integer(forKey: "whiteWine")
        sessionPriceList.spirit = defaults.integer(forKey: "spirit")
        sessionPriceList.shots = defaults.integer(forKey: "shots")
        sessionPriceList.cocktail = defaults.integer(forKey: "cocktail")
        sessionPriceList.bubbles = defaults.integer(forKey: "bubbles")
        sessionPriceList.softDrink = defaults.integer(forKey: "softDrink")
        sessionPriceList.coffeeTea = defaults.integer(forKey: "coffeeTea")
        sessionPriceList.barSnacks = defaults.integer(forKey: "barSnacks")
        sessionPriceList.liteBites = defaults.integer(forKey: "liteBites")
        sessionPriceList.mainMeal = defaults.integer(forKey: "mainMeal")
        
        
        if (defaults.string(forKey: "currency") != nil)
        {
            sessionPriceList.currency = defaults.string(forKey: "currency")!
        }
    }
    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (defaults.bool(forKey: "isAdFree") == false) {
            UIiAd.delegate = self
            UIiAd = self.appDelegate().UIiAd
            UIiAd.frame = CGRect(x: 0, y: 21, width: 0, height: 0)
            view.addSubview(UIiAd)
        }
        
        refreshSessionPriceList()
        loadSessionValues()
        runningTotalLabel.text = sessionPriceList.currency + " \(updateRunningTotal())"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (defaults.bool(forKey: "isAdFree") == false) {
            UIiAd.delegate = nil
            UIiAd.removeFromSuperview()
        }
        
        saveSessionValues()
    }
    
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        //UIiAd.hidden = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 1
        UIView.commitAnimations()
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 0
        UIView.commitAnimations()
        //UIiAd.hidden = true
    }
    
    func setupLocationEntry(){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BoozeTrackerViewController.doneLocation))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        sessionLocation.keyboardType = UIKeyboardType.default
        sessionLocation.inputAccessoryView = toolBar
    }
    
    func doneLocation(){
        defaults.set(sessionLocation.text, forKey: "SessionLocation")
        sessionLocation.resignFirstResponder()
    }
    
    func loadSessionValues()
    {
        print("TODO: BoozeTracker Session - loadSessionValues")
    }
    
    func saveSessionValues()
    {
        print("TODO: BoozeTracker Session - saveSessionValues")
    }
}

