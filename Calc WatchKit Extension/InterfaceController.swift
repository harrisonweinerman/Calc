//
//  InterfaceController.swift
//  Calc WatchKit Extension
//
//  Created by Harrison Weinerman on 4/15/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var decimal: WKInterfaceButton!
    @IBOutlet weak var zero: WKInterfaceButton!
    @IBOutlet weak var delete: WKInterfaceButton!
    @IBOutlet weak var one: WKInterfaceButton!
    @IBOutlet weak var two: WKInterfaceButton!
    @IBOutlet weak var three: WKInterfaceButton!
    @IBOutlet weak var four: WKInterfaceButton!
    @IBOutlet weak var five: WKInterfaceButton!
    @IBOutlet weak var six: WKInterfaceButton!
    @IBOutlet weak var seven: WKInterfaceButton!
    @IBOutlet weak var eight: WKInterfaceButton!
    @IBOutlet weak var nine: WKInterfaceButton!
    
    var lastTyped : String!
    var currentlyTyped : String!
    var selectedOperator : String!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        currentlyTyped = ""
        // Configure interface objects here.
        if NSUserDefaults.standardUserDefaults().objectForKey("opened") == nil {
            NSUserDefaults.standardUserDefaults().setObject("YES", forKey: "opened")
            self.presentControllerWithName("welcome", context: nil)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func addDecimal() {
        
        if currentlyTyped.rangeOfString(".") == nil {
        currentlyTyped = currentlyTyped + "."
        updateBarAfterInput()

        }

    }
    @IBAction func addZero() {
        currentlyTyped = currentlyTyped + "0"
        updateBarAfterInput()

    }
    @IBAction func deleteAxn() {
        currentlyTyped = ""
        updateBarAfterInput()

    }
    @IBAction func addOne() {
        currentlyTyped = currentlyTyped + "1"
        updateBarAfterInput()

    }
    @IBAction func addTwo() {
        currentlyTyped = currentlyTyped + "2"
        updateBarAfterInput()

    }
    @IBAction func addThree() {
        currentlyTyped = currentlyTyped + "3"
        updateBarAfterInput()

    }
    @IBAction func addFour() {
        currentlyTyped = currentlyTyped + "4"
        updateBarAfterInput()

    }
    @IBAction func addFive() {
        currentlyTyped = currentlyTyped + "5"
        updateBarAfterInput()

    }
    @IBAction func addSix() {
        currentlyTyped = currentlyTyped + "6"
        updateBarAfterInput()

    }
    @IBAction func addSeven() {
        currentlyTyped = currentlyTyped + "7"
        updateBarAfterInput()
    }
    @IBAction func addEight() {
        currentlyTyped = currentlyTyped + "8"
        updateBarAfterInput()
    }
    @IBAction func addNine() {
        currentlyTyped = currentlyTyped + "9"
        updateBarAfterInput()
    }
    
    func updateBarAfterInput(){
        self.setTitle(currentlyTyped)
    }

    @IBAction func add() {
       selectedOperator = "+"
        postOpSelection()
    }
    
    @IBAction func subtract() {
        selectedOperator = "-"
       postOpSelection()
    }
    
    @IBAction func multiply() {
      selectedOperator = "x"
        postOpSelection()
    }
    
    @IBAction func divide() {
      selectedOperator = "/"
        postOpSelection()
    }
    
    func postOpSelection() {
        lastTyped = currentlyTyped
        currentlyTyped = ""
        updateBarAfterInput()
    }
    
    @IBAction func equals() {
        
        if lastTyped != nil {

            switch selectedOperator {
                
            case "+":
                addAxn()
            case "-":
                subtractAxn()
            case "x":
                multiplyAxn()
            case "/":
                divideAxn()
            default:
                lol()
            }
            
        }
        
        if currentlyTyped.floatValue % 1 == 0  {
            currentlyTyped = "\((currentlyTyped as NSString).intValue)"
        }
        
        self.setTitle(currentlyTyped)
        
        
    }
    
    
    
    func addAxn(){
        currentlyTyped = "\(currentlyTyped.floatValue + lastTyped.floatValue)"
    }
    
    func subtractAxn(){
        currentlyTyped = "\(lastTyped.floatValue - currentlyTyped.floatValue)"
        
    }
    
    func multiplyAxn(){
        currentlyTyped = "\(currentlyTyped.floatValue * lastTyped.floatValue)"
    }
    
    func divideAxn(){
        if !(lastTyped.floatValue == 0) {
        currentlyTyped = "\(lastTyped.floatValue / currentlyTyped.floatValue)"
        }
        else {
            self.setTitle("NaN")
            currentlyTyped = "0"
        }
    }

    
    func lol() {
        
    }
   
}


extension String {
    var floatValue: Double {
        return (self as NSString).doubleValue
    }
}