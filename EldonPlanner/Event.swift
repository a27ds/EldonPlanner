//
//  Event.swift
//  EldonPlanner
//
//  Created by a27 on 2018-01-17.
//  Copyright © 2018 a27. All rights reserved.
//

import Foundation

class Event {
    var preformers = [Preformence]()
    var date: String
    var getIn: String
    var dinner: String
    var doors: String
    var musicCurfew: String
    var venueCurfew: String
    var howManyPreformers: Int
    var showTimeTotalInMin: Int
    var soundcheckTimeTotalInMin: Int
    
    init(date: String, getIn: String, dinner: String, doors: String, musicCurfew: String, venueCurfew: String, howManyPreformers: Int) {
        self.date = date
        self.getIn = getIn
        self.dinner = dinner
        self.doors = doors
        self.musicCurfew = musicCurfew
        self.venueCurfew = venueCurfew
        self.howManyPreformers = howManyPreformers
        self.showTimeTotalInMin = 0
        self.soundcheckTimeTotalInMin = 0
    }
    
}
