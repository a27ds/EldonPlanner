//
//  ViewController.swift
//  EldonPlanner
//
//  Created by a27 on 2018-01-15.
//  Copyright © 2018 a27. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dateBox: UITextField!
    @IBOutlet weak var getInBox: UITextField!
    @IBOutlet weak var dinnerBox: UITextField!
    @IBOutlet weak var doorsBox: UITextField!
    @IBOutlet weak var musicCurfewBox: UITextField!
    @IBOutlet weak var venueCurfewBox: UITextField!
    @IBOutlet weak var howManyPreformersBox: UITextField!
    
    var activeTimeTextField: UITextField!
    var event: Event? = nil
    var timeForTimeWheel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let testDate = Date()
        
    }
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        if (dateBox.text?.isEmpty)! || (getInBox.text?.isEmpty)! || (dinnerBox.text?.isEmpty)! || (doorsBox.text?.isEmpty)! || (musicCurfewBox.text?.isEmpty)! || (venueCurfewBox.text?.isEmpty)!{
            alertIfAnyInputFieldIsEmpty()
        } else {
            self.performSegue(withIdentifier: "toAddPreformers", sender: sender)
        }
    }
    @IBAction func dateBoxBeganEdit(_ sender: UITextField) {
        dateBoxBeganEdit()
    }
    
    @IBAction func getInBoxBeganEdit(_ sender: UITextField) {
        activeTimeTextField = sender
        timeForTimeWheel = "14:00"
        timeBoxBeganEdit()
    }
    
    @IBAction func dinnerBoxBeganEdit(_ sender: UITextField) {
        activeTimeTextField = sender
        timeForTimeWheel = "17:00"
        timeBoxBeganEdit()
    }
    
    @IBAction func doorsBoxBeganEdit(_ sender: UITextField) {
        activeTimeTextField = sender
        timeForTimeWheel = "20:00"
        timeBoxBeganEdit()
    }
    
    @IBAction func musicCurfewBoxBeganEdit(_ sender: UITextField) {
        activeTimeTextField = sender
        timeForTimeWheel = "23:00"
        timeBoxBeganEdit()
    }
    
    @IBAction func venueCurfewBoxBeganEdit(_ sender: UITextField) {
        activeTimeTextField = sender
        timeForTimeWheel = "01:00"
        timeBoxBeganEdit()
        
    }
    
    func dateBoxBeganEdit () {
        let datePicker = datePickerLoad()
        datePicker.addTarget(self, action: #selector(datePickerValueChangedStart(sender:)), for: UIControlEvents.valueChanged)
        dateBox.inputView = datePicker
    }
    
    @objc func datePickerValueChangedStart(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = DateFormatter.Style.none
        dateBox.text = formatter.string(from: sender.date)
    }
    
    func datePickerLoad() -> UIDatePicker{
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        return datePicker
    }
    
    func timeBoxBeganEdit () {
        let timePicker = timePickerLoad()
        timePicker.addTarget(self, action: #selector(timePickerValueChangedStart(sender:)), for: UIControlEvents.valueChanged)
        activeTimeTextField.inputView = timePicker
    }
    
    @objc func timePickerValueChangedStart(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.none
        formatter.timeStyle = DateFormatter.Style.short
        activeTimeTextField.text = formatter.string(from: sender.date)
    }
    
    func timePickerLoad() -> UIDatePicker{
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.minuteInterval = 5
        datePicker.setDate(dateSet(testDate: timeForTimeWheel!), animated: true)
        return datePicker
    }
    
    func dateSet(testDate: String) -> Date {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        formatter.string(from: date)
        return formatter.date(from: testDate)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddPreformers" {
            let destVC = segue.destination as! PreformViewController
            destVC.event = Event(date: dateBox.text!, getIn: getInBox.text!, dinner: dinnerBox.text!, doors: doorsBox.text!, musicCurfew: musicCurfewBox.text!, venueCurfew: venueCurfewBox.text!, howManyPreformers: Int(howManyPreformersBox.text!)!)
        }
    }
    
    func alertIfAnyInputFieldIsEmpty () {
        let alert = UIAlertController(title: "What are you trying to do?", message: "You must fill out all the boxes before continuing.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

