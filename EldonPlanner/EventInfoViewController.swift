//
//  EventInfoViewController.swift
//  EldonPlanner
//
//  Created by a27 on 2018-01-16.
//  Copyright © 2018 a27. All rights reserved.
//

import UIKit

class EventInfoViewController: UIViewController {
    @IBOutlet weak var eventInfo: UITextView!
    
    var event: Event? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventInfo.text = eventInfoText()
    }
    
    func eventInfoText() -> String{
        let eventInfoTextString: String = """
        Get in: \((event!.getIn))
        \(soundcheckInfo())
        Dinner: \((event!.dinner))
        Doors: \((event!.doors))
        \((showInfo()))
        Live Music Curfew: \((event!.musicCurfew)) STRICT
        Venue Curfew: \((event!.venueCurfew))
        """
        return eventInfoTextString
    }
    
    func soundcheckInfo () -> String {
        event?.preformers.sort(by: { Int($0.lineUpPlacement)! > Int($1.lineUpPlacement)! }) //Sortera preformers
        var soundcheckInfo = String()
        soundcheckInfo.append("\n")
        for preformer in event!.preformers {
            soundcheckInfo.append("Soundcheck \(preformer.preformenceName): \(preformer.soundcheckTime)")
            soundcheckInfo.append("\n")
        }
        return soundcheckInfo
    }
    
    func showInfo () -> String {
        event?.preformers.sort(by: { Int($0.lineUpPlacement)! < Int($1.lineUpPlacement)! }) //Sortera preformers
        var showInfo = String()
        showInfo.append("\n")
        for preformer in event!.preformers {
            showInfo.append("\(preformer.preformenceName): \(preformer.preformerTotalTimeInMin)")
            showInfo.append("\n")
        }
        return showInfo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func copyTextButtonPressed(_ sender: UIButton) {
        UIPasteboard.general.string = eventInfo.text
    }
    
    
    
    
}
