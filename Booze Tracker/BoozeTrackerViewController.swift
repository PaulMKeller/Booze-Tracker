//
//  SecondViewController.swift
//  Booze Tracker
//
//  Created by Paul Keller on 30/11/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import UIKit

class BoozeTrackerViewController: UIViewController {
    
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
    

    @IBAction func stepperValueChanged(sender: UIStepper) {
        //lblBeerCount.text = Int(sender.value).description
        let labelName = getLabelNameFromTag(sender.tag)
        labelName.text = Int(sender.value).description
        
        runningTotalLabel.text = "$ \(updateRunningTotal())"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        beerStepper.wraps = false
        beerStepper.autorepeat = false
        beerStepper.maximumValue = 100
        */
        
        runningTotalLabel.text = "$ \(updateRunningTotal())"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRunningTotal() -> Int{
        
        var runningTotal:Int = 0
        
        for var i = 0; i <= 11; ++i {
            let lblLabel:UILabel = getLabelNameFromTag(i)
            let cunt:String? = lblLabel.text
            let a:Int? = Int(cunt ?? "")
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
            return 15
        case 1: //redWineLabel
            return 11
        case 2: //whiteWineLabel
            return 11
        case 3: //spiritLabel
            return 16
        case 4: //shotsLabel
            return 10
        case 5: //cocktailLabel
            return 20
        case 6: //bubblesLabel
            return 22
        case 7: //softLabel
            return 5
        case 8: //coffeeLabel
            return 5
        case 9: //barSnacksLabel
            return 5
        case 10: //liteBitesLabel
            return 10
        case 11: //bigFoodLabel
            return 20
        default:
            return 0
        }
    }

}

