//
//  PreformViewController.swift
//  EldonPlanner
//
//  Created by a27 on 2018-01-16.
//  Copyright © 2018 a27. All rights reserved.
//

import UIKit

class PreformViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var preformenceName: UITextField!
    @IBOutlet weak var soundcheckTime: UITextField!
    @IBOutlet weak var rigUpTime: UITextField!
    @IBOutlet weak var showTime: UITextField!
    @IBOutlet weak var rigDownTime: UITextField!
    @IBOutlet weak var lineUpPlacement: UITextField!
    @IBOutlet weak var addAnotherButton: UIButton!
    
    var event: Event? = nil
    
    var activeCountDownTimerTextField: UITextField!
    
    var showTimePickerData: [String] = []
    var soundcheckTimePickerData: [String] = []
    var lineUpPlacementData: [String] = []
    var everyFiveMinInTotalShowTime: Int = 0
    var everyFiveMinInTotalSoundcheckTime: Int = 0
    
    var soundcheckEdit: Bool = false
    var soundcheckTimeSave: Int = 0
    var rigUpEdit: Bool = false
    var rigUpTimeSave: Int = 0
    var showTimeEdit: Bool = false
    var showTimeSave: Int = 0
    var rigDownEdit: Bool = false
    var rigDownTimeSave: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...event!.howManyPreformers {
            lineUpPlacementData.append("\(i)")
        }
        showTimeEveryFiveMinInTotal()
        soundcheckTimeEveryFiveMinInTotal()
        
        
        
        
        
        
        
    }
    
    
    func showTimeEveryFiveMinInTotal() {
        everyFiveMinInTotalShowTime = (event?.showTimeTotalInMin)! / 5
        appendTimeInPickerData(runs: everyFiveMinInTotalShowTime, array: &showTimePickerData)
    }
    
    func soundcheckTimeEveryFiveMinInTotal() {
        everyFiveMinInTotalSoundcheckTime = (event?.soundcheckTimeTotalInMin)! / 5
        appendTimeInPickerData(runs: everyFiveMinInTotalSoundcheckTime, array: &soundcheckTimePickerData)
    }
    
    func appendTimeInPickerData(runs: Int, array: inout [String]) {
        array.removeAll()
        for i in 1...runs {
                array.append("\(i * 5) min")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if (preformenceName.text?.isEmpty)! || (soundcheckTime.text?.isEmpty)! || (rigUpTime.text?.isEmpty)! || (showTime.text?.isEmpty)! || (rigUpTime.text?.isEmpty)! || (lineUpPlacement.text?.isEmpty)! {
            alertIfAnyInputFieldIsEmpty()
        } else {
            self.performSegue(withIdentifier: "toEventInfo", sender: sender)
        }
    }
    
    @IBAction func addAnotherButtonPressed(_ sender: UIButton) {
        if (preformenceName.text?.isEmpty)! || (soundcheckTime.text?.isEmpty)! || (rigUpTime.text?.isEmpty)! || (showTime.text?.isEmpty)! || (rigDownTime.text?.isEmpty)! || (lineUpPlacement.text?.isEmpty)! {
            alertIfAnyInputFieldIsEmpty()
        } else {
            if lineUpPlacementData.count == 2 {
                addAnotherButton.setTitle("Done", for: [])
            }
            if lineUpPlacementData.count == 1 {
                self.performSegue(withIdentifier: "toEventInfo", sender: sender)
            }
            addPreformersInfoToPreformenceArray()
            removeSelectedLineUpPlacementFromArray()
            resetInputBoxes()
        }
    }
    
    @IBAction func soundcheckTimeBeganEdit(_ sender: UITextField) {
        if soundcheckEdit == true {
            event?.soundcheckTimeTotalInMin += soundcheckTimeSave
        }
        soundcheckEdit = false
        activeCountDownTimerTextField = sender
        soundcheckTimeEveryFiveMinInTotal()
        countDownTimerBoxBeganEdit()
    }
    @IBAction func soundcheckTimeEndEdit(_ sender: UITextField) {
        soundcheckEdit = true
        soundcheckTimeSave = Int((sender.text!).dropLast(4))!
        event?.soundcheckTimeTotalInMin = removeMinFromTotalTime(sender: sender, timeTotalMin: (event?.soundcheckTimeTotalInMin)!)
    }
    
    @IBAction func rigUpTimeBeganEdit(_ sender: UITextField) {
        if rigUpEdit == true {
            event?.showTimeTotalInMin += rigUpTimeSave
        }
        rigUpEdit = false
        activeCountDownTimerTextField = sender
        showTimeEveryFiveMinInTotal()
        countDownTimerBoxBeganEdit()
    }
    @IBAction func rigUpTimeEndEdit(_ sender: UITextField) {
        rigUpEdit = true
        rigUpTimeSave = Int((sender.text!).dropLast(4))!
        event?.showTimeTotalInMin = removeMinFromTotalTime(sender: sender, timeTotalMin: (event?.showTimeTotalInMin)!)
    }
    
    
    
    @IBAction func showTimeBeganEdit(_ sender: UITextField) {
        if showTimeEdit == true {
            event?.showTimeTotalInMin += showTimeSave
        }
        showTimeEdit = false
        activeCountDownTimerTextField = sender
        showTimeEveryFiveMinInTotal()
        countDownTimerBoxBeganEdit()
    }
    @IBAction func showtimeEndEdit(_ sender: UITextField) {
        showTimeEdit = true
        showTimeSave = Int((sender.text!).dropLast(4))!
        event?.showTimeTotalInMin = removeMinFromTotalTime(sender: sender, timeTotalMin: (event?.showTimeTotalInMin)!)
        
    }
    
    @IBAction func rigDownTimeBeganEdit(_ sender: UITextField) {
        if rigDownEdit == true {
            event?.showTimeTotalInMin += rigDownTimeSave
        }
        rigDownEdit = false
        activeCountDownTimerTextField = sender
        showTimeEveryFiveMinInTotal()
        countDownTimerBoxBeganEdit()
    }
    @IBAction func rigDownEndEdit(_ sender: UITextField) {
        rigDownEdit = true
        rigDownTimeSave = Int((sender.text!).dropLast(4))!
        event?.showTimeTotalInMin = removeMinFromTotalTime(sender: sender, timeTotalMin: (event?.showTimeTotalInMin)!)
        
    }
    
    @IBAction func lineUpPlacementBeganEdit(_ sender: UITextField) {
        lineUpPlacementBoxBeganEdit()
    }
    
    func lineUpPlacementBoxBeganEdit() {
        let lineUpPlacementPicker = lineUpPlacementPickerLoad()
        lineUpPlacement.inputView = lineUpPlacementPicker
    }
    
    func lineUpPlacementPickerLoad() -> UIPickerView {
        let lineUpPlacementPicker = UIPickerView()
        lineUpPlacementPicker.tag = 2
        lineUpPlacementPicker.delegate = self
        lineUpPlacementPicker.dataSource = self
        return lineUpPlacementPicker
    }
    
    func countDownTimerBoxBeganEdit () {
        let countDownTimerPicker = countDownTimerPickerLoad()
        activeCountDownTimerTextField.inputView = countDownTimerPicker
    }
    
    func countDownTimerPickerLoad() -> UIPickerView{
        let countDownTimer = UIPickerView()
        countDownTimer.tag = 1
        countDownTimer.delegate = self
        countDownTimer.dataSource = self
        countDownTimer.selectRow(5, inComponent: 0, animated: true) // väljer vart man vill börja i countDownTimer
        return countDownTimer
    }
    
    func addPreformersInfoToPreformenceArray() {
        event?.preformers.append(Preformence(preformenceName: preformenceName.text!, soundcheckTime: soundcheckTime.text!, rigUpTime: rigUpTime.text!, showTime: showTime.text!, rigDownTime: rigDownTime.text!, lineUpPlacement: lineUpPlacement.text!, howManyPreformers: (event?.howManyPreformers)!))
    }
    
    func resetInputBoxes() {
        soundcheckEdit = false
        rigUpEdit = false
        showTimeEdit = false
        rigDownEdit = false
        preformenceName.text = nil
        soundcheckTime.text = nil
        rigUpTime.text = nil
        showTime.text = nil
        rigDownTime.text = nil
        lineUpPlacement.text = nil
    }
    
    func removeMinFromTotalTime(sender: UITextField, timeTotalMin: Int) -> Int{
        return timeTotalMin - Int((sender.text!).dropLast(4))!
    }
    
    func removeSelectedLineUpPlacementFromArray() {
        if let index = lineUpPlacementData.index(of: lineUpPlacement.text!) {
            lineUpPlacementData.remove(at: index)
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return showTimePickerData.count
        } else if pickerView.tag == 2 {
            return lineUpPlacementData.count
        }
        return -1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return showTimePickerData[row]
        } else if pickerView.tag == 2 {
            return lineUpPlacementData[row]
        }
        return "Nothing"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            activeCountDownTimerTextField.text = showTimePickerData[row]
        } else if pickerView.tag == 2 {
            lineUpPlacement.text = lineUpPlacementData[row]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventInfo" {
            let destVC = segue.destination as! EventInfoViewController
            addPreformersInfoToPreformenceArray()
            destVC.event = event
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
