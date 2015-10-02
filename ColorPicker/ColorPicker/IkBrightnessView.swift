//
//  IkBrightnessView.swift
//  ColorPicker
//
//  Created by Sebastian Cancinos on 10/1/15.
//  Copyright (c) 2015 Inaka. All rights reserved.
//

import Foundation
import UIKit

class IkBrightnessView : UIView {
    
    var brightnessImage: UIImage!
    var selectedX: CGFloat = 0
    {
        didSet
        {
            self.setNeedsDisplay();
        }
    }
    var baseColor: UIColor = UIColor.redColor()
    {
        didSet
        {
            self.brightnessImage = nil;
            self.setNeedsDisplay();
        }
    }
    
    var brightness: CGFloat
    {
        get
        {
            return (self.frame.width-selectedX)/self.frame.width
        }
    }
    
    convenience init(brightness: CGFloat, baseColor: UIColor, frame:CGRect){
        self.init(frame: frame)

        self.baseColor = baseColor;
        self.selectedX = brightness ;
    }
    
    // Default initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.opaque = true;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBrightnessImage(rect: CGRect) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
        let context: CGContextRef = UIGraphicsGetCurrentContext();
        let recSize = CGSize(width:ceil(rect.size.width/256),
            height:rect.size.height);
        
        var hue:CGFloat = 0.0;
        var saturation:CGFloat = 0.0;
        baseColor.getHue(&hue, saturation:&saturation, brightness:nil, alpha:nil);
        
        for(var x: CGFloat = 0; x < rect.size.width; x += rect.size.width/256)
        {
            let rec = CGRect(x: x, y: 0, width: recSize.width , height: recSize.height);
            let brightness = (rect.size.width-x)/rect.size.width
            let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1);
            
            CGContextSetFillColorWithColor(context, color.CGColor);
            CGContextFillRect(context,rec);
        }
        
        let Image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return Image;
    }
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        
        if(self.brightnessImage == nil)
        {
            self.brightnessImage = self.createBrightnessImage(rect);
        }
        
        let context: CGContextRef = UIGraphicsGetCurrentContext();
        
        self.brightnessImage.drawAtPoint(CGPointZero);
        
        let selectionRect = CGRect(x: selectedX-2, y: 0,
            width:5, height:rect.size.height);
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor);
        CGContextStrokeRect(context, selectionRect);
        
        UIGraphicsEndImageContext();
    }
}