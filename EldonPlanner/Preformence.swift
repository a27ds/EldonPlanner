//
//  Preformence.swift
//  EldonPlanner
//
//  Created by a27 on 2018-01-17.
//  Copyright © 2018 a27. All rights reserved.
//

import Foundation

class Preformence {
    var preformenceName: String
    var soundcheckTime: String
    var rigUpTime: String
    var showTime: String
    var rigDownTime: String
    var lineUpPlacement: String
    var preformerTotalTimeInMin: Int
    
    init(preformenceName: String,soundcheckTime: String, rigUpTime: String, showTime: String, rigDownTime: String, lineUpPlacement: String) {
        self.preformenceName = preformenceName
        self.soundcheckTime = soundcheckTime
        self.rigUpTime = rigUpTime
        self.showTime = showTime
        self.rigDownTime = rigDownTime
        self.lineUpPlacement = lineUpPlacement
        self.preformerTotalTimeInMin = 0
    }
    
    
}
