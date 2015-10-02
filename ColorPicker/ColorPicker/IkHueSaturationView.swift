//
//  IkHueSaturationView.swift
//  ColorPicker
//
//  Created by Sebastian Cancinos on 10/1/15.
//  Copyright (c) 2015 Inaka. All rights reserved.
//

import Foundation
import UIKit

class IkHueSaturationView : UIView {
    
    var hueSaturationImage: UIImage!
    var selectedPoint: CGPoint = CGPointZero
    {
        didSet
        {
            self.setNeedsDisplay();
        }
    }
    var color: UIColor{
        get
        {
            return self.colorFor(selectedPoint.x, y: selectedPoint.y);
        }
    }
    var brightness: CGFloat = 1;
    
    convenience init(color:UIColor, frame:CGRect){
        self.init(frame: frame)
        var saturation: CGFloat = 0;
        var hue: CGFloat = 0;

        color.getHue(&hue, saturation: &saturation, brightness:&self.brightness, alpha:nil);
        
        self.selectedPoint = CGPoint(x: hue / self.frame.size.width,
                                     y: saturation / self.frame.size.height);
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
    
    private func colorFor( x: CGFloat, y: CGFloat) -> UIColor
    {
        return UIColor(hue: (x/self.frame.size.width), saturation: y/CGFloat(self.frame.size.height), brightness:self.brightness, alpha: 1);
    }

    func createHueSatImage(rect: CGRect) -> UIImage
    {
        UIGraphicsBeginImageContext(rect.size);
        let context: CGContextRef = UIGraphicsGetCurrentContext();
        
        let recSize = CGSize(width:ceil(self.self.frame.size.width/256),
            height:ceil(self.frame.size.height/256));
        
        for(var y: CGFloat = 0; y < self.frame.size.height; y += self.frame.size.height/256)
        {
            for(var x: CGFloat = 0; x < self.frame.size.width; x += self.frame.size.width/256)
            {
                let rec = CGRect(x: x, y: y, width: recSize.width , height: recSize.height);
                let color = self.colorFor(x, y: y);
                
                CGContextSetFillColorWithColor(context, color.CGColor);
                CGContextFillRect(context,rec);
            }
        }
        let Image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return Image;
    }
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)

        if(self.hueSaturationImage == nil)
        {
            self.hueSaturationImage = self.createHueSatImage(rect);
        }
        
        let context: CGContextRef = UIGraphicsGetCurrentContext();
        
        self.hueSaturationImage.drawAtPoint(CGPointZero);
        
        let selectionRect = CGRect(x: selectedPoint.x-2, y: selectedPoint.y-2,
            width:4, height:4);
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor);
        CGContextStrokeRect(context, selectionRect);
        
        UIGraphicsEndImageContext();
    }
}