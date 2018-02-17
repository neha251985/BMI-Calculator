//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Neha Tiwari on 2/5/18.
//  Copyright © 2018 Neha Tiwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var metricSwitch: UISwitch!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var heightinfeets: UITextField!
    @IBOutlet weak var heightininches: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addToolbar()
        navigationController?.navigationBar.barTintColor = UIColor(red:36/255,green:178/255,blue:255/255,alpha:1.0)
       navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]; self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: Adding toolbar with done button to dismiss the keyboard
    func addToolbar(){
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem.init(barButtonSystemItem:.flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem.init(barButtonSystemItem:.done, target: self, action: #selector(ViewController.doneClicked))
        toolBar.setItems([flexibleSpace,done], animated: false)
        toolBar.sizeToFit()
        self.weightTextField.inputAccessoryView = toolBar
        self.heightTextField.inputAccessoryView = toolBar
        self.heightinfeets.inputAccessoryView = toolBar
        self.heightininches.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked(){
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: TextfieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: Submit Button Function
    @IBAction func submitButton(_ sender: Any) {
        if metricSwitch.isOn{
            if let weight = Double(weightTextField?.text ?? ""),let heightInFeet = Double(heightinfeets?.text ?? ""),let heightInInches = Double(heightininches?.text ?? ""){
                let weightconversionOfLbToKg =  weight * 0.45359237
                let heightinmetres = heightInFeet * 0.3048 + heightInInches * 0.0254
                print(heightinmetres)
                let BMI = calculateBMI(weight: weightconversionOfLbToKg, height:heightinmetres )
                let rounded = Double(round(10*BMI)/10)
                resultLabel.text = String(rounded) + "kg/m*m"
            }
        }
        else{
            if let weight = Double(weightTextField?.text ?? ""),let height = Double(heightTextField?.text ?? ""){
                let BMI = calculateBMI(weight: weight, height:height )
                let rounded = Double(round(10*BMI)/10)
                resultLabel.text = String(rounded) + "kg/m*m"
        }
       }
}
    func calculateBMI(weight wt:Double,height ht:Double) -> Double{
        let totalBMI = wt / (ht*ht)
        return totalBMI
    }
    
    //MARK: Switch Function
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        selectSwitch()
    }
    func selectSwitch(){
        if metricSwitch.isOn{
            weightTextField.placeholder = "Please enter weight in pounds."
            heightTextField.isHidden = true
            heightinfeets.isHidden = false
            heightininches.isHidden = false
            weightTextField.text = ""
            resultLabel.text  = ""
            heightinfeets.text = ""
            heightininches.text = ""
        }else{
            heightinfeets.isHidden = true
            heightininches.isHidden = true
            heightTextField.isHidden = false
            weightTextField.text = ""
            heightTextField.text = ""
            resultLabel.text = ""
            weightTextField.placeholder = "Please enter weight in kilograms."
            heightTextField.placeholder = "Please enter height in metres."
        }
    }
}

