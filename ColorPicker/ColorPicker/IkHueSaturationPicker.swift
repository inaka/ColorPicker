//
//  IkHueSaturationPicker.swift
//  ColorPicker
//
//  Created by Sebastian Cancinos on 10/1/15.
//  Copyright (c) 2015 Inaka. All rights reserved.
//


import UIKit

@IBDesignable class IkHueSaturationPicker: UIControl {
    private var picker: IkHueSaturationView!;
    @IBInspectable var color:UIColor = UIColor.redColor()
        {
        didSet
        {
            var saturation: CGFloat = 0;
            var hue: CGFloat = 0;
            
            color.getHue(&hue, saturation: &saturation, brightness:nil, alpha:nil);
            if(self.picker != nil)
            {
                let point = CGPoint(x: hue*self.picker.frame.size.width,
                    y: saturation*self.picker.frame.size.height);
                
                self.picker.selectedPoint = point;
            }
        }
    }
    
    #if TARGET_INTERFACE_BUILDER
    override func willMoveToSuperview(newSuperview: UIView?) {
    
        self.picker = IkHueSaturationView(color:self.color, frame: self.bounds);
        self.addSubview(self.picker)
    }
    
    #else
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.picker = IkHueSaturationView(color:self.color, frame: self.bounds)
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
        
        self.picker.selectedPoint = touch.locationInView(self);
        self.color = self.picker.color;
        
        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        super.endTrackingWithTouch(touch, withEvent: event)
    }
}