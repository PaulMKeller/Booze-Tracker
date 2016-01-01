//
//  LastSession.swift
//  Booze Tracker
//
//  Created by Paul Keller on 01/01/2016.
//  Copyright © 2016 Planet K Games. All rights reserved.
//

import Foundation

class LastSession {
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var sessionLocation: String
    var sessionAmount: String
    
    init (){
        sessionLocation = defaults.stringForKey("SessionLocation")!
        sessionAmount = defaults.stringForKey("SessionAmount")!
    }
    
}