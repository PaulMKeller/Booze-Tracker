//
//  PriceList.swift
//  Booze Tracker
//
//  Created by Paul Keller on 28/12/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import Foundation

class PriceList {
    var defaults = UserDefaults.standard
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
            self.beer = defaults.integer(forKey: "beer")
            self.redWine = defaults.integer(forKey: "redWine")
            self.whiteWine = defaults.integer(forKey: "whiteWine")
            self.spirit = defaults.integer(forKey: "spirit")
            self.shots = defaults.integer(forKey: "shots")
            self.cocktail = defaults.integer(forKey: "cocktail")
            self.bubbles = defaults.integer(forKey: "bubbles")
            self.softDrink = defaults.integer(forKey: "softDrink")
            self.coffeeTea = defaults.integer(forKey: "coffeeTea")
            self.barSnacks = defaults.integer(forKey: "barSnacks")
            self.liteBites = defaults.integer(forKey: "liteBites")
            self.mainMeal = defaults.integer(forKey: "mainMeal")
            self.currency = defaults.string(forKey: "currency")!
        }
    }
}
