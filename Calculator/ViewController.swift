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
    
    
    func lastCharIsOperator(str : String) -> Bool {
        let arifOperators: [Character] = ["/", "*", "+", "-"]
        let lastChar = str.last //expressionLabel.text?.last
        /*if lastChar == nil {
            return false
        }*/
        return arifOperators.contains( lastChar! )
    }
    
    @IBAction func onResetResult(_ sender: UIButton) {
        if expressionLabel.text?.count ?? 0 > 1 {
            
        }
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
    }
    
    @IBAction func onNewSymbolAction(_ sender: UIButton) {
        if lastCharIsOperator(str: expressionLabel.text!) {
            expressionLabel.text = String(expressionLabel.text!.dropLast(2))   + " " + sender.currentTitle!
        }
        else{
            expressionLabel.text = expressionLabel.text! + " " + sender.currentTitle!
        }
    }
    
    
    @IBAction func onGetResult(_ sender: UIButton) {
    }
    
    @IBAction func onEditResult(_ sender: UIButton) {
        
        let lastSubstring = expressionLabel.text?.split(separator: " ").last
        
        switch sender.currentTitle! {
        case ",":
            if !(lastSubstring?.contains(",") ?? true) {
                expressionLabel.text!.append(",")
            }
            else {
                expressionLabel.text?.append("0,")
            }
        default:
            if lastSubstring == "0" {
                expressionLabel.text = String(expressionLabel.text!.dropLast(1)) + sender.currentTitle!
                break
            }
            expressionLabel.text?.append(sender.currentTitle!)
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

