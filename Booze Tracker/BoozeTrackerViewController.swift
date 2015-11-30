//
//  SecondViewController.swift
//  Booze Tracker
//
//  Created by Paul Keller on 30/11/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import UIKit

class BoozeTrackerViewController: UIViewController {

    
    @IBOutlet var lblBeerCount: UILabel!
    @IBOutlet var beerStepper: UIStepper!
    @IBAction func stepperValueChanged(sender: UIStepper) {
        lblBeerCount.text = Int(sender.value).description
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        beerStepper.wraps = false
        beerStepper.autorepeat = false
        beerStepper.maximumValue = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

