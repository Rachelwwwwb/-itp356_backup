//
//  ViewController.swift
//  WangWenbeiHW4
//
//  Created by 王文贝 on 2019/10/5.
//  Copyright © 2019 Wenbei Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //create global variables to hold calculation result
    var includeTax = true
    var billAmount = 0.0
    var taxValue = 0.0
    var taxPercentage = 0.0
    var tipAmount = 0.0
    var tipPercentage = 0.0
    var subtotal = 0.0
    var tWithTip = 0.0
    var splitNum = 1;
    var tPP = 0.0
    
    @IBOutlet weak var tipSliderLabel: UILabel!
    @IBOutlet weak var splitNumLabel: UILabel!
    @IBOutlet weak var billAmountLabel: UITextField!
    @IBOutlet weak var taxSegmented: UISegmentedControl!
    @IBOutlet weak var taxSlider: UISlider!
    @IBOutlet weak var spiltStepper: UIStepper!
    @IBOutlet weak var taxSwitch: UISwitch!
    
    
    //second view
    
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalWithTipLabel: UILabel!
    @IBOutlet weak var totalPPLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDefaultValues()
    }

    func setDefaultValues(){
        billAmountLabel.text = ""
        taxSegmented.selectedSegmentIndex = 0
        taxSlider.value = 0
        spiltStepper.value = 1
        
        splitNumLabel.text = "1"
        tipSliderLabel.text = "0%"
        taxLabel.text = "$0.00"
        subtotalLabel.text = "$0.00"
        tipLabel.text = "$0.00"
        totalWithTipLabel.text = "$0.00"
        totalPPLabel.text = "$0.00"
        
        includeTax = true
        billAmount = 0.0
        taxValue = 0.0
        subtotal = 0.0
    }
    
    
    @IBAction func billEntered(_ sender: UITextField) {
        print ("hi")
        let amount = billAmountLabel.text ?? ""
        if amount.count > 0{
            billAmount = Double(amount)!
        }
        if tipPercentage != 0 {
            
            tipAmount = billAmount * (1 + tipPercentage)
            tipLabel.text = "$" + String (format: "%.2f", tipAmount)
        }
        tPP = billAmount/Double(splitNum)
        totalPPLabel.text = "$" + String (format: "%.2f", tPP)
    }
        
    @IBAction func sliderChanged(_ sender: UISlider) {
        let num = sender.value
        tipPercentage = Double(sender.value/100)
        tipSliderLabel.text = "\(Int(num))%"

        if billAmountLabel.text != ""{
            let amount = billAmountLabel.text ?? ""
            if amount.count > 0{
                billAmount = Double(amount)!
            }
            tipAmount = billAmount * (1 + tipPercentage)
            tWithTip = billAmount + tipAmount
            tipLabel.text = "$" + String (format: "%.2f", tipAmount)
            if includeTax{
                tWithTip += taxValue
            }
            totalWithTipLabel.text = "$" + String (format: "%.2f", tWithTip)
        }
    }
    
    @IBAction func taxChanged(_ sender: UISegmentedControl) {
        switch taxSegmented.selectedSegmentIndex{
            case 0:
               taxPercentage = 7.5
            case 1:
               taxPercentage = 8
            case 2:
                taxPercentage = 8.5
            case 3:
                taxPercentage = 9
            case 4:
                taxPercentage = 9.5
            default:
                break
        }
        // if there's a input value
        if billAmountLabel.text != "" {
            let amount = billAmountLabel.text ?? ""
            if amount.count > 0{
                billAmount = Double(amount)!
        }
        taxValue = billAmount * (taxPercentage/100.0)
        taxLabel.text = "$" + String (format: "%.2f", taxValue)
        }
        
        // change the subtotal
        if includeTax {
            subtotal = billAmount + taxValue
            tWithTip = billAmount + taxValue + tipAmount
        }
        else {
            subtotal = billAmount
            tWithTip = billAmount + tipAmount
        }
        tPP = tWithTip / Double(splitNum)
        subtotalLabel.text = "$" + String (format: "%.2f", subtotal)
        totalWithTipLabel.text = "$" + String (format: "%.2f", tWithTip)
        totalPPLabel.text = "$" + String (format: "%.2f", tPP)
                      
    }

    @IBAction func taxSwitched(_ sender: UISwitch) {
        if taxSwitch.isOn{
            includeTax = true
        }
        else {
            includeTax = false
        }
        if billAmountLabel.text != "" {
            let amount = billAmountLabel.text ?? ""
            if amount.count > 0{
                billAmount = Double(amount)!
            }
            if (includeTax) {
            subtotal = billAmount + taxValue
            tWithTip = billAmount + tipAmount + taxValue
            }
            else {
                subtotal = billAmount
                tWithTip = billAmount + tipAmount
            }
            subtotalLabel.text = "$" + String (format: "%.2f", subtotal)
            totalWithTipLabel.text = "$" + String (format: "%.2f", tWithTip)

        }
    }
    
        
    @IBAction func changeSplitNum(_ sender: UIStepper) {
        splitNumLabel.text = Int(sender.value).description
        splitNum = Int(sender.value)
        
        if billAmountLabel.text != "" {
            let amount = billAmountLabel.text ?? ""
            if amount.count > 0{
                billAmount = Double(amount)!
            }
            if includeTax {
                tPP = (billAmount + tipAmount + taxValue) / Double(splitNum)
            }
            else {
                tPP = (billAmount + tipAmount) / Double(splitNum)
            }
            totalPPLabel.text = "$" + String (format: "%.2f", tPP)
        }

    }
    
    
    @IBAction func clearAll(_ sender: UIButton) {
        setDefaultValues()
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first

        if billAmountLabel.isFirstResponder && touch?.view != billAmountLabel {
            billAmountLabel.resignFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }

    
}

