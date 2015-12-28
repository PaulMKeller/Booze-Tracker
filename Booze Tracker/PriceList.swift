//
//  PriceList.swift
//  Booze Tracker
//
//  Created by Paul Keller on 28/12/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import Foundation

class PriceList {

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
            self.beer = 15
            self.redWine = 15
            self.whiteWine = 15
            self.spirit = 22
            self.shots = 10
            self.cocktail = 25
            self.bubbles = 25
            self.softDrink = 5
            self.coffeeTea = 7
            self.barSnacks = 5
            self.liteBites = 10
            self.mainMeal = 15
            self.currency = "$"
        }
    }
}