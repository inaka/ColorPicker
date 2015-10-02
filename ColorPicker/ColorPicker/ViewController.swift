//
//  ViewController.swift
//  ColorPicker
//
//  Created by Sebastian Cancinos on 7/15/15.
//  Copyright (c) 2015 Inaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textInput: UITextView?;
    @IBOutlet var huePicker: IkHueSaturationPicker?;
    @IBOutlet var brightnessPicker: IkBrightnessPicker?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func colorSelectedChanged(color: UIColor) {
        self.textInput?.textColor = color;
    }
    
    @IBAction func hueChanged(sender: IkHueSaturationPicker)
    {
        self.brightnessPicker?.baseColor = sender.color;
        self.textInput?.textColor = self.brightnessPicker?.color;
    }
    
    @IBAction func brightnessChanged(sender: IkBrightnessPicker)
    {
        self.textInput?.textColor = self.brightnessPicker?.color;
    }
}

