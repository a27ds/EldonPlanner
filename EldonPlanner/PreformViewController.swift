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
    
    let pickerData = ["5 min", "10 min", "15 min", "20 min", "25 min", "30 min", "35 min", "40 min", "45 min", "50 min", "55 min", "60 min", "65 min", "70 min", "75 min", "80 min", "85 min", "90 min", "95 min", "100 min", "105 min", "110 min", "115 min", "120 min", "125 min", "130 min", "135 min", "140 min", "145 min", "150 min", "155 min", "160 min", "165 min", "170 min", "175 min", "180 min", "185 min", "190 min", "195 min", "200 min", ]
    
    var lineUpPlacementData: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...event!.howManyPreformers {
            lineUpPlacementData.append("\(i)")
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
        activeCountDownTimerTextField = sender
        countDownTimerBoxBeganEdit()
    }
    
    @IBAction func rigUpTimeBeganEdit(_ sender: UITextField) {
        activeCountDownTimerTextField = sender
        countDownTimerBoxBeganEdit()
    }
    
    @IBAction func showTimeBeganEdit(_ sender: UITextField) {
        activeCountDownTimerTextField = sender
        countDownTimerBoxBeganEdit()
    }
    
    @IBAction func rigDownTimeBeganEdit(_ sender: UITextField) {
        activeCountDownTimerTextField = sender
        countDownTimerBoxBeganEdit()
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
        preformenceName.text = nil
        soundcheckTime.text = nil
        rigUpTime.text = nil
        showTime.text = nil
        rigDownTime.text = nil
        lineUpPlacement.text = nil
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
            return pickerData.count
        } else if pickerView.tag == 2 {
            return lineUpPlacementData.count
        }
        return -1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return pickerData[row]
        } else if pickerView.tag == 2 {
            return lineUpPlacementData[row]
        }
        return "Nothing"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            activeCountDownTimerTextField.text = pickerData[row]
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
