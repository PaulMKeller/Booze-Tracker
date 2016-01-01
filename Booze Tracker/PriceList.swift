//
//  PriceList.swift
//  Booze Tracker
//
//  Created by Paul Keller on 28/12/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import Foundation

class PriceList {
    var defaults = NSUserDefaults.standardUserDefaults()
    var beer: Int
    var redWine: Int
    var whiteWine: Int
    var spirit: Int
    var shots: Int
    var cocktail: Int
    var bubbles: Int
    var softDrink: Int
    var coffeeTea: Int
    var barSnacks: Int
    var liteBites: Int
    var mainMeal: Int
    var currency: String
    
    init(useZero: Bool)
    {
        if (useZero)
        {
            self.beer = 0
            self.redWine = 0
            self.whiteWine = 0
            self.spirit = 0
            self.shots = 0
            self.cocktail = 0
            self.bubbles = 0
            self.softDrink = 0
            self.coffeeTea = 0
            self.barSnacks = 0
            self.liteBites = 0
            self.mainMeal = 0
            self.currency = "$"
        }
        else
        {
            self.beer = defaults.integerForKey("beer")
            self.redWine = defaults.integerForKey("redWine")
            self.whiteWine = defaults.integerForKey("whiteWine")
            self.spirit = defaults.integerForKey("spirit")
            self.shots = defaults.integerForKey("shots")
            self.cocktail = defaults.integerForKey("cocktail")
            self.bubbles = defaults.integerForKey("bubbles")
            self.softDrink = defaults.integerForKey("softDrink")
            self.coffeeTea = defaults.integerForKey("coffeeTea")
            self.barSnacks = defaults.integerForKey("barSnacks")
            self.liteBites = defaults.integerForKey("liteBites")
            self.mainMeal = defaults.integerForKey("mainMeal")
            self.currency = defaults.stringForKey("currency")!
        }
    }
}