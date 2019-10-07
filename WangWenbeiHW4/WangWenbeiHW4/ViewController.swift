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
    var includeTax = false
    var billAmount = 0.0
    var taxValue = 0
    var tipAmount = 0.0
    var tipPercentage = 0.0
    
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
        taxSegmented.selectedSegmentIndex = UISegmentedControl.noSegment
        taxSlider.value = 0
        spiltStepper.value = 1
        
        splitNumLabel.text = "1"
        tipSliderLabel.text = "0%"
        taxLabel.text = "$0.00"
        subtotalLabel.text = "$0.00"
        tipLabel.text = "$0.00"
        totalWithTipLabel.text = "$0.00"
        totalPPLabel.text = "$0.00"
        
        
        includeTax = false
        billAmount = 0.0
        taxValue = 0
    }
    
    @IBAction func billAmountEntered(_ sender: UITextField) {
        let amount = billAmountLabel.text ?? ""
        if amount.count > 0{
            billAmount = Double(amount)!
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        if billAmountLabel.text != ""{
            let num = sender.value
            tipPercentage = Double(sender.value)
            
            tipSliderLabel.text = "\(Int(num))%"
            tipAmount = billAmount * (1 + tipPercentage)
            tipLabel.text = "\(tipAmount) "
        }
    }
    
    @IBAction func changeSplitNum(_ sender: UIStepper) {
        if billAmountLabel.text != "" {
            splitNumLabel.text = Int(sender.value).description
        }
        else {
            sender.value = 1
            splitNumLabel.text = "1"
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

