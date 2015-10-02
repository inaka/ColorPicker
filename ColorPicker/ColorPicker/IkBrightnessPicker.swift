//
//  IkBrightnessPicker.swift
//  ColorPicker
//
//  Created by Sebastian Cancinos on 10/1/15.
//  Copyright (c) 2015 Inaka. All rights reserved.
//

import UIKit

@IBDesignable class IkBrightnessPicker: UIControl {
    private var picker: IkBrightnessView!;
    @IBInspectable var baseColor:UIColor = UIColor.redColor()
    {
        didSet
        {
            if(self.picker != nil)
            {
                self.picker.baseColor = baseColor;
            }
        }
    }
    
    var brightness: CGFloat
    {
        get
            {
                if(self.picker != nil)
                {
                    return self.picker.brightness;
                }
                else
                {
                    return 0;
                }
        }
    }

    var color:UIColor
        {
        get{
            var hue:CGFloat = 0.0;
            var saturation:CGFloat = 0.0;
            baseColor.getHue(&hue, saturation:&saturation, brightness:nil, alpha:nil);
            
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1);
        }
    }
    
    #if TARGET_INTERFACE_BUILDER
    override func willMoveToSuperview(newSuperview: UIView?) {
    
        self.picker = IkBrightnessView(brightness: brightness, baseColor: self.baseColor, frame:self.bounds)
        self.addSubview(self.picker)
    }
    
    #else
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.picker = IkBrightnessView(brightness: brightness, baseColor: self.baseColor, frame:self.bounds)
        self.picker.userInteractionEnabled = false;
        self.addSubview(self.picker)
        
    }
    #endif
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.picker.frame = self.bounds;
        
    }
    

    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        
        self.picker.selectedX = touch.locationInView(self).x;
        
        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        super.endTrackingWithTouch(touch, withEvent: event)
    }
}