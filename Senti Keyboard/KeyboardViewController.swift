//
//  KeyboardViewController.swift
//  Senti Keyboard
//
//  Created by Jasleen Singh on 8/25/16.
//  Copyright © 2016 Sentient Electronics. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    //Mark - IBOOutlet
    @IBOutlet weak var NumberSet: UIStackView!
    @IBOutlet weak var charSet: UIStackView!
    
    @IBOutlet weak var row1: UIStackView!
    @IBOutlet weak var row2: UIStackView!
    @IBOutlet weak var row3: UIStackView!
    @IBOutlet weak var row4: UIStackView!
    
    
    @IBOutlet weak var shiftButton: UIButton!
    var shiftStatus: Int! //0 - off, 1 - on, 2 - caps lock
    
    
    private var proxy:UITextDocumentProxy{
        return textDocumentProxy
    }

    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Perform custom UI setup here
        charSet.hidden = true
        shiftStatus = 1
        
        
    }

    @IBAction func nextKeyboard(sender: UIButton) {
        advanceToNextInputMode()
    }
    
    @IBAction func shiftPressed(sender: UIButton) {
        shiftStatus = shiftStatus > 0 ? 0 : 1
        shiftChange(row1)
        shiftChange(row2)
        shiftChange(row3)
    }
    
    @IBAction func keyPressed(sender: UIButton){
        let string = sender.titleLabel!.text
        proxy.insertText("\(string!)")
        
        
        
        if shiftStatus == 1 {
            shiftPressed(self.shiftButton)
        }
        
        UIView.animateWithDuration(0.2, animations: {() -> Void in
            sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)}){
                (_) -> Void in
                sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
        }
        
    }
    
    @IBAction func charSetPressed(sender: UIButton){
        if sender.titleLabel!.text == "#+="{
            NumberSet.hidden = true
            charSet.hidden = false
            sender.setTitle("123", forState: UIControlState.Normal)
        }
        else{
            NumberSet.hidden = false
            charSet.hidden = true
            sender.setTitle("#+=", forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func backSpacePressed(sender: UIButton) {
        proxy.deleteBackward()
    }
    
    @IBAction func returnPressed(sender: UIButton) {
        proxy.insertText("\n")
    }
    
    @IBAction func spacePressed(sender: UIButton) {
        proxy.insertText(" ")
    }
    
    @IBAction func shiftTripleTap(sender: UITapGestureRecognizer) {
        shiftStatus = 0
        shiftPressed(self.shiftButton)
    }
    @IBAction func shiftDoupleTap(sender: UITapGestureRecognizer) {
        shiftStatus = 2
        shiftChange(row1)
        shiftChange(row2)
        shiftChange(row3)

    }
    
    
    func shiftChange(containerView: UIStackView){
        for view in containerView.subviews{
            if let button = view as? UIButton{
                let buttonTitle = button.titleLabel!.text
                if shiftStatus == 0 {
                    let text = buttonTitle!.lowercaseString
                    button.setTitle("\(text)", forState: UIControlState.Normal)
                }
                else{
                    let text = buttonTitle!.uppercaseString
                    button.setTitle("\(text)", forState: UIControlState.Normal)
                }
            }
        }
    }

    
    
    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.

        
    }

}
