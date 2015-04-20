//
//  ViewController.swift
//  Calc
//
//  Created by Harrison Weinerman on 4/15/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var lastTyped : String!
    var selectedOperator : String!
    var currentlyTyped : String!
    var operatorIsSelected : Bool!
    var triedToDivideByZero : Bool!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lastTyped = ""
        selectedOperator = ""
        currentlyTyped = "0"
        operatorIsSelected = false
        triedToDivideByZero = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonDown(sender: AnyObject) {
        
        animateDown(sender)
        
    }
    
    @IBAction func buttonUp(sender: AnyObject) {
        animateUp(sender)
    }
    
    func selectOperatorAndPrepareForNextNumber(operatorSelected : String){

        selectedOperator = operatorSelected

        switch operatorSelected{
        case "+":
            plusButton.layer.borderColor = UIColor.whiteColor().CGColor
            plusButton.layer.borderWidth = 2
        case "−":
            minusButton.layer.borderColor = UIColor.whiteColor().CGColor
            minusButton.layer.borderWidth = 2
        case "x":
            multiplyButton.layer.borderColor = UIColor.whiteColor().CGColor
            multiplyButton.layer.borderWidth = 2
        case "÷":
            divideButton.layer.borderColor = UIColor.whiteColor().CGColor
            divideButton.layer.borderWidth = 2
        default:
            println("This will never show up in the console...")
        }
        
        operatorIsSelected = true

        
    }
    
    func performOperation(){
        

        switch selectedOperator{
            
        case "+":
            currentlyTyped = "\(lastTyped.doubleValue + currentlyTyped.doubleValue)"
        case "−":
            currentlyTyped = "\(lastTyped.doubleValue - currentlyTyped.doubleValue)"
        case "x":
            currentlyTyped = "\(lastTyped.doubleValue * currentlyTyped.doubleValue)"
        case "÷":
            //can't divide by zero!
            if currentlyTyped.doubleValue != 0 {
            currentlyTyped = "\(lastTyped.doubleValue / currentlyTyped.doubleValue)"
            }
            else {
                currentlyTyped = ""
                triedToDivideByZero = true
            }
        default:
            println("This will never show up in the console...")
        }
        
        plusButton.layer.borderWidth = 0
        minusButton.layer.borderWidth = 0
        multiplyButton.layer.borderWidth = 0
        divideButton.layer.borderWidth = 0
        operatorIsSelected = false

        
        selectedOperator = ""
      
        
    }
    
    func updateTheLabel(){
        if currentlyTyped != "" {
        if currentlyTyped.doubleValue.isInteger && currentlyTyped[(currentlyTyped as NSString).length-1] != "." {
            currentlyTyped = "\((currentlyTyped as NSString).intValue)"
        }
        }
        if triedToDivideByZero! { numberLabel.text = "NaN"; triedToDivideByZero = false }
        else { numberLabel.text = currentlyTyped }
    }
    
    
    @IBAction func fireButtonAxn(sender: AnyObject) {

        plusButton.layer.borderWidth = 0
        minusButton.layer.borderWidth = 0
        multiplyButton.layer.borderWidth = 0
        divideButton.layer.borderWidth = 0

        
        var text = (sender as UIButton).titleLabel?.text
        
        switch text! {
            //handle things that aren't numbers
        case "+":
            selectOperatorAndPrepareForNextNumber(text!)
        case "−":
            selectOperatorAndPrepareForNextNumber(text!)
        case "x":
            selectOperatorAndPrepareForNextNumber(text!)
        case "÷":
            selectOperatorAndPrepareForNextNumber(text!)
        case "=":
            performOperation()
        case "C":
            currentlyTyped = "0"
        case ".":
            //check to see if they already added a decimal, we can't have 2
            if currentlyTyped.rangeOfString(".") == nil {
                currentlyTyped = currentlyTyped + "."
            }
        default:
            //it's a number
            println("operator selected status: \(operatorIsSelected)")
            if operatorIsSelected == true {
                lastTyped = currentlyTyped
                currentlyTyped = text!
                numberLabel.text = currentlyTyped
                
            }
            else {
                currentlyTyped = currentlyTyped + text!
            }
            operatorIsSelected = false

            
        }
        
        updateTheLabel()

        
    }
    
    @IBAction func plusMinusButton(sender: AnyObject) {
        currentlyTyped = "\(currentlyTyped.doubleValue * -1)"
        updateTheLabel()
    }
    
    func animateDown(object : AnyObject){
        let animation = CGAffineTransformMakeScale(0.8, 0.8)
        let button = object as UIButton

        UIView.animateWithDuration(0.1, delay: 0, options: nil, animations: {
            
            button.transform = animation
            
            }, completion: { finished in
                
                if finished {
                
//            self.animateUp(object)
                    
                }

        })
        
    }
    
    func animateUp(object : AnyObject){
        
        let button = object as UIButton
        let unAnimate = CGAffineTransformMakeScale(1, 1)
        UIView.animateWithDuration(0.05, delay: 0, options: nil, animations: {
            
            button.transform = unAnimate
            
            }, completion: { finished in
                
        })
    }
}

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}


extension Double {
    var isInteger:Bool {
        return self == Double(Int(self))
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}