//
//  LastSession.swift
//  Booze Tracker
//
//  Created by Paul Keller on 01/01/2016.
//  Copyright © 2016 Planet K Games. All rights reserved.
//

import Foundation

class LastSession {
    
    var defaults = UserDefaults.standard
    var sessionLocation: String
    var sessionAmount: String
    
    init (){
        sessionLocation = defaults.string(forKey: "SessionLocation")!
        sessionAmount = defaults.string(forKey: "SessionAmount")!
    }
    
}
