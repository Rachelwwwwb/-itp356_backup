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
    @IBOutlet weak var resetButton: UIButton!
    
    //first view
    //dynamic label
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    
    //static label
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var billStaticLabel: UILabel!
    @IBOutlet weak var taxStaticLabel: UILabel!
    @IBOutlet weak var includeTaxLabel: UILabel!
    @IBOutlet weak var spiltStaticLabel: UILabel!
    
    //second view
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalWithTipLabel: UILabel!
    @IBOutlet weak var totalPPLabel: UILabel!
    
    //static label

    @IBOutlet weak var taxSecondLabel: UILabel!
    @IBOutlet weak var subtotalStaticLabel: UILabel!
    @IBOutlet weak var tipStaticLabel: UILabel!
    @IBOutlet weak var totalWithTipStaticLabel: UILabel!
    @IBOutlet weak var totalPPStaticLabel: UILabel!
    
    @IBOutlet var oneView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityIdentifiers()
        // Do any additional setup after loading the view.
        setDefaultValues()
    }

    private func setDefaultValues(){
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
        taxPercentage = 0.0
        tipAmount = 0.0
        tipPercentage = 0.0
        tWithTip = 0.0
        splitNum = 1;
        tPP = 0.0
    }
    
    
    @IBAction func billEntered(_ sender: UITextField) {
        guard let value = billAmountLabel.text else {
            return
        }
        if value.count > 0{
            billAmount = Double(value)!
        
                
            tipAmount = billAmount * tipPercentage
            tipLabel.text = "$" + String (format: "%.2f", tipAmount)
            taxValue = billAmount * tipPercentage
            taxLabel.text = "$" + String (format: "%.2f", taxValue)
            
            subtotal = taxValue
            tWithTip = billAmount + tipAmount
            
            if includeTax {
                subtotal += taxValue
                tWithTip += taxValue
            }

            tPP = billAmount/Double(splitNum)
            subtotalLabel.text = "$" + String (format: "%.2f", subtotal)
            totalWithTipLabel.text = "$" + String (format: "%.2f", tWithTip)
            totalPPLabel.text = "$" + String (format: "%.2f", tPP)
        }
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
            tipAmount = billAmount * tipPercentage
            tWithTip = billAmount + tipAmount
            tipLabel.text = "$" + String (format: "%.2f", tipAmount)
            if includeTax{
                tWithTip += taxValue
            }
            tPP = tWithTip / Double(splitNum)
            totalWithTipLabel.text = "$" + String (format: "%.2f", tWithTip)
            totalPPLabel.text = "$" + String (format: "%.2f", tPP)

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
            tPP = tWithTip/Double(splitNum)
            subtotalLabel.text = "$" + String (format: "%.2f", subtotal)
            totalWithTipLabel.text = "$" + String (format: "%.2f", tWithTip)
            totalPPLabel.text = "$" + String (format: "%.2f", tPP)

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
        let alert = UIAlertController(title: "Clear All Values", message: "Are you sure you want to clear all values?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "Clear All", style: .default, handler:clear)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert,animated: true)
    }
    
    private func clear(action:UIAlertAction) {
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
    
    func setAccessibilityIdentifiers() {
        //set up all the identfiers

        //ui components you can interact with

        billAmountLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.billTextField

        taxSegmented.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedTax

        taxSwitch.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxSwitch

        taxSlider.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipSlider

        spiltStepper.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitStepper

        resetButton.accessibilityIdentifier = HW4AccessibilityIdentifiers.resetButton

        

        

        //dyanmic labels that will change based on userinput

        taxLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxAmountLabel

        subtotalLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalAmountLabel

        tipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipAmountLabel

        totalWithTipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipAmountLabel

        totalPPLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonAmountLabel

        sliderLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.sliderLabel

        splitLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitLabel

        

        //static labels that dont change - title labels

        titleLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipCalculaterLabel

        billStaticLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.billLabel

        taxStaticLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedLabel

        includeTaxLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxLabel

        spiltStaticLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.evenSplitLabel

        taxSecondLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxLabel

        subtotalStaticLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalLabel

        tipStaticLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipLabel

        totalWithTipStaticLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipLabel

        totalPPStaticLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonLabel

        

        //user view; only need to connect one

        oneView.accessibilityIdentifier = HW4AccessibilityIdentifiers.view

        

    }

    
}

