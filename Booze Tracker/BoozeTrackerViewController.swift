//
//  SecondViewController.swift
//  Booze Tracker
//
//  Created by Paul Keller on 30/11/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import UIKit
import iAd

class BoozeTrackerViewController: UIViewController, ADBannerViewDelegate {
    
    var defaults = NSUserDefaults.standardUserDefaults()
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
    @IBAction func newSession(sender: AnyObject) {
        ClearAllTotals()
        refreshSessionPriceList()
    }
    

    @IBAction func stepperValueChanged(sender: UIStepper) {
        let labelName = getLabelNameFromTag(sender.tag)
        labelName.text = Int(sender.value).description
        
        runningTotalLabel.text = sessionPriceList.currency + " \(updateRunningTotal())"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refreshSessionPriceList()
        runningTotalLabel.text = sessionPriceList.currency + " \(updateRunningTotal())"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRunningTotal() -> Int{
        
        var runningTotal:Int = 0
        
        for var i = 0; i <= 11; ++i {
            let lblLabel:UILabel = getLabelNameFromTag(i)
            let count:String? = lblLabel.text
            let a:Int? = Int(count ?? "")
            runningTotal += a! * getPriceFromTag(i)
        }
        
        return runningTotal
    }
    
    func getLabelNameFromTag(stepperTag: Int) -> UILabel {
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
    
    func getPriceFromTag(stepperTag: Int) -> Int {
        
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
    
    func appDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func viewDidAppear(animated: Bool) {
        UIiAd.delegate = self
        UIiAd = self.appDelegate().UIiAd
        UIiAd.frame = CGRectMake(0, 21, 0, 0)
        view.addSubview(UIiAd)
        
        refreshSessionPriceList()
        runningTotalLabel.text = sessionPriceList.currency + " \(updateRunningTotal())"
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIiAd.delegate = nil
        UIiAd.removeFromSuperview()
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        //UIiAd.hidden = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 1
        UIView.commitAnimations()
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        //bannerView.hidden = true
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 0
        UIView.commitAnimations()
    }
}

