//
//  RadialGradientLayer.swift
//  Pods
//
//  Created by Huan Jiang on 5/20/16.
//
//

import UIKit

public class RadialGradientLayer: CALayer {
    
    override init(){
        
        super.init()
        
        needsDisplayOnBoundsChange = true
    }
    
    init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
        
        self.center = center
        self.radius = radius
        self.colors = colors
        
        super.init()
        needsDisplayOnBoundsChange = true

    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    var center:CGPoint = CGPointMake(50,50)
    var radius:CGFloat = 20
    var colors:[CGColor] = [UIColor(red: 251/255, green: 237/255, blue: 33/255, alpha: 1.0).CGColor , UIColor(red: 251/255, green: 179/255, blue: 108/255, alpha: 1.0).CGColor]
    
    override public func drawInContext(ctx: CGContext!) {
        
        CGContextSaveGState(ctx)
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var locations:[CGFloat] = [0.0, 1.0]
        
        var gradient = CGGradientCreateWithColors(colorSpace, colors, [0.0,1.0])
        
        var startPoint = CGPointMake(0, self.bounds.height)
        var endPoint = CGPointMake(self.bounds.width, self.bounds.height)
    
        CGContextDrawRadialGradient(ctx, gradient, center, 0.0, center, radius, CGGradientDrawingOptions.DrawsAfterEndLocation)
    }
    
}