//
//  ViewController.swift
//  Calculator
//
//  Created by MR ROBOT on 11/20/17.
//  Copyright © 2017 MR ROBOT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var expressionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    func lastCharIsOperator(_ str : String) -> Bool {
        let arifOperators: [Character] = ["/", "*", "+", "-"]
        let lastChar = str.last //expressionLabel.text?.last
        /*if lastChar == nil {
            return false
        }*/
        return arifOperators.contains( lastChar! )
    }
    
    @IBAction func onResetResult(_ sender: UIButton) {
        expressionLabel.text = "0"
        resultLabel.text = "0"
    }
    
    @IBAction func onDelSymbol(_ sender: UIButton) {
        if expressionLabel.text == "0" || expressionLabel.text == nil {
            return
        }
        
        if expressionLabel.text?.count ?? 0 == 1 {
            expressionLabel.text = "0"
            return
        }
        expressionLabel.text?.removeLast()
        if expressionLabel.text?.last == " " {
            expressionLabel.text?.removeLast()
            
        }
    }
    
    @IBAction func onNewSymbolAction(_ sender: UIButton) {
        if lastCharIsOperator(expressionLabel.text!) {
            expressionLabel.text = String(expressionLabel.text!.dropLast(2))   + " " + sender.currentTitle!
        }
        else{
            expressionLabel.text = expressionLabel.text! + " " + sender.currentTitle!
        }
    }
    
    
    @IBAction func onGetResult(_ sender: UIButton) {
        if lastCharIsOperator( expressionLabel.text! ) {
                    expressionLabel.text!.removeLast()
        }
        
        var resultModify : String = ""

        // Problem with Double  : 1 + 3 ==> 1.0 + 3.0
        expressionLabel.text!
            .split(separator: " ")
            .map{ $0.contains(".") || ["/", "*", "+", "-"].contains($0) ? $0 : (String($0) + ".0")}
            .forEach{
                resultModify.append( contentsOf: $0)
                if $0.last == "." {
                        resultModify.append("0")
                }
            }
       
        let result = NSExpression(format : resultModify)
            .expressionValue(with: nil, context: nil) as? Double
        
        if result != nil {
            resultLabel.text  = String( result! )
            expressionLabel.text = result == Double.infinity ? "0" : "\(result!)"
        } else {
            expressionLabel.text  = "0"
            resultLabel.text = "Err"
        }
    }
    
    @IBAction func onEditResult(_ sender: UIButton) {
        
        let lastSubstring = expressionLabel.text?.split(separator: " ").last
        
        switch sender.currentTitle! {
        case ",":
            if !(lastSubstring?.contains(".") ?? true) {
                expressionLabel.text!.append(".")
            }
            else {
                expressionLabel.text?.append("0.")
            }
        default:
            if lastSubstring == "0" {
                expressionLabel.text = String(expressionLabel.text!.dropLast(1)) + sender.currentTitle!
                break
            }
            expressionLabel.text?.append(
                (lastCharIsOperator( expressionLabel.text! ) ? " " : "") + sender.currentTitle!
            )
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

