//
//  ViewController.swift
//  ColorPicker
//
//  Created by Sebastian Cancinos on 7/15/15.
//  Copyright (c) 2015 Inaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ColorPicker {

    private var customInputView: UIView?;
    @IBOutlet var textInput: UITextView?;
    var colorPickerButton: UIButton?;
    
    private var colorPicker: IKColorPicker?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.colorPicker = IKColorPicker(frame: CGRectZero, color: self.textInput!.textColor);
        self.colorPicker!.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func colorSelectedChanged(color: UIColor) {
        self.textInput?.textColor = color;
        
        let colorImage = self.colorPicker!.createFullColorImage(self.textInput!.textColor);
        self.colorPickerButton!.setImage(colorImage, forState:UIControlState.Normal);

    }

    override var inputAccessoryView: UIView?
    {
        get{
            
        if (self.customInputView == nil)
        {
            let screenSize: CGRect = UIScreen.mainScreen().bounds

            // lazy creation
            let accessFrame = CGRectMake(0, 0, screenSize.width, 50);
            self.customInputView = UIView(frame: accessFrame);
            
            // create a semi-transparent banner
            var iavBackgroundView = UIView(frame: accessFrame);
            iavBackgroundView.backgroundColor = UIColor.darkGrayColor();
            iavBackgroundView.alpha = 0.5;
            self.customInputView!.addSubview(iavBackgroundView);
            
            // create a button for system keyboard
            let image = UIImage(named: "btn-keyboard");
            var kbButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton;
            kbButton.frame = CGRectMake(10, 5, 40, 40);
            kbButton.setImage(image, forState: UIControlState.Normal);
            kbButton.addTarget(self, action:Selector("kbButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside);
            self.customInputView!.addSubview(kbButton);
            
            // create a button for our font & size keyboard
            let colorImage = self.colorPicker!.createFullColorImage(self.textInput!.textColor);
            var colorButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton;
            colorButton.frame = CGRectMake(60, 5, 40, 40);
            colorButton.setImage(colorImage, forState:UIControlState.Normal);
            colorButton.addTarget(self, action:Selector("colorButtonPressed:"),
            forControlEvents:UIControlEvents.TouchUpInside);
            self.customInputView!.addSubview(colorButton);
            
            self.colorPickerButton = colorButton;
        }
        return customInputView;
        }
    }
    
    func kbButtonPressed(sender: AnyObject)
    {
        self.textInput!.inputView = nil;
        self.textInput!.reloadInputViews();
    }
    
    func colorButtonPressed(sender: AnyObject)
    {
        self.textInput!.inputView = self.colorPicker;
        self.colorPicker!.selectedColor = self.textInput!.textColor;
        
        let colorImage = self.colorPicker!.createFullColorImage(self.textInput!.textColor);
        self.colorPickerButton!.setImage(colorImage, forState:UIControlState.Normal);
        
        self.textInput!.reloadInputViews();
    }
}

