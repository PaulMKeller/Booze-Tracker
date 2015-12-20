//
//  SessionPrice.swift
//  Booze Tracker
//
//  Created by Paul Keller on 12/12/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import Foundation

class SessionPrice {
    var itemName: String
    var cost: Int
    
    init() {
        self.itemName = ""
        self.cost = 0
    }
    
    init(ItemName: String, Cost: Int) {
        self.itemName = ItemName
        self.cost = Cost
    }
}