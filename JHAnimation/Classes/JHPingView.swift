//
//  JHPingView.swift
//  Pods
//
//  Created by Huan Jiang on 5/20/16.
//
//

import UIKit
import QuartzCore

public class JHPingView: UIView, JHPingViewDelegate {
    public var isAnimating : Bool = false
    public var delegate: JHPingViewDelegate?
    
    public override func drawRect(rect: CGRect) {
//        self.drawGradientLayer()
    }
    
    /**
     init for view created from storyboard
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    /**
     init with frame
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        self.applyGesture()
//        self.addGradientLayer()
//        self.addRadialGradientLayerMask()
        self.addCircleLayer()
    }
    
    func applyGesture(){
        self.userInteractionEnabled = true
        let tappedRecognizer = UITapGestureRecognizer(target:self, action:"handleTap:")
        self.addGestureRecognizer(tappedRecognizer)
    }

    func handleTap(recognizer:UITapGestureRecognizer) {        
        if self.delegate != nil {
            self.delegate?.onTapped?(self.isAnimating)
        }
        
        if (isAnimating) {
            self.resetAnimation()
        }
        else {
            self.startAnimation()
        }

        isAnimating = !isAnimating
    }
    
    public func resetAnimation() {
        self.layer.sublayers = nil
//        self.addRadialGradientLayerMask()
        self.addCircleLayer()
    }
    
    public func startAnimation() {
        self.layer.sublayers = nil
        self.animation_mask_repeat()
        self.animation_mask_repeat1()
        self.animation_mask_repeat2()
    }
    
    func drawGradientLayer() {
        let context: CGContextRef = UIGraphicsGetCurrentContext()!;
        
        let gradLocationsNum: size_t = 2;
        let gradLocations: [CGFloat] = [ 1.0, 0.0 ];
        let gradColors: [CGFloat] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5];
        let colorSpace:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!;
        let gradient:CGGradientRef = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum)!;
        
        let gradCenter: CGPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        let gradRadius: CGFloat = min(self.bounds.size.width , self.bounds.size.height) ;
        
        CGContextDrawRadialGradient (context, gradient, gradCenter, 0, gradCenter, gradRadius, CGGradientDrawingOptions.DrawsAfterEndLocation);
    }
    
    func addGradientLayer()  -> CALayer {

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.whiteColor().CGColor, UIColor.redColor().CGColor]
        layer.insertSublayer(gradient, atIndex: 0)
        return gradient
    }
    
    func addRadialGradientLayer()  -> CALayer {
        
        let gradCenter: CGPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        let gradRadius: CGFloat = min(self.bounds.size.width , self.bounds.size.height) ;
        let colors:[CGColor] = [UIColor.redColor().CGColor , UIColor.whiteColor().CGColor]
        let gradient = RadialGradientLayer(center: gradCenter, radius: gradRadius, colors: colors)
        
        gradient.frame = self.bounds
        layer.insertSublayer(gradient, atIndex: 0)
        return gradient
    }
    
    func addCircleLayer() -> CALayer {
        let lay = CAShapeLayer()
        lay.path = UIBezierPath(ovalInRect: CGRectInset(bounds, bounds.size.width * 0.2 , bounds.size.height * 0.2)).CGPath
        lay.fillColor = UIColor.redColor().CGColor
        lay.shadowOpacity = 0.8
        lay.shadowOffset = CGSizeMake(2, 2)
        layer.addSublayer(lay)
        return lay
    }
    
    func addRadialGradientLayerMask() -> CALayer {
        let bgLayer = addRadialGradientLayer(UIColor.redColor())
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalInRect: CGRectInset(bounds, bounds.size.width * 0.2 , bounds.size.height * 0.2)).CGPath

        bgLayer.mask = maskLayer
        return bgLayer
    }
    
    func addRadialGradientLayer( color: UIColor)  -> CALayer {
        
        let gradCenter: CGPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        let gradRadius: CGFloat = min(self.bounds.size.width , self.bounds.size.height) ;
        let colors:[CGColor] = [color.CGColor , UIColor.whiteColor().CGColor]
        let gradient = RadialGradientLayer(center: gradCenter, radius: gradRadius, colors: colors)
        
        gradient.frame = self.bounds
        layer.insertSublayer(gradient, atIndex: 0)
        return gradient
    }

    
    func addBackGroundLayer() -> CALayer {
        let bgLayer = CALayer()
        bgLayer.frame = bounds
        bgLayer.backgroundColor = UIColor.redColor().CGColor
        self.layer.addSublayer(bgLayer)
        return bgLayer
    }
    
    
    func animation_mask_repeat() {
        let bgLayer = self.addRadialGradientLayer()
        
        let w = bounds.width / 2
        let h = bounds.height / 2
        let startBounds = CGRectInset(bounds, w * 0.8, h * 0.8)
        let endBounds = CGRectInset(bounds, w * 0.6, h * 0.6)
        
        let oldPath = UIBezierPath(ovalInRect: startBounds)
        let newPath = UIBezierPath(ovalInRect: endBounds)
        
        let layer1 = CAShapeLayer()
        layer1.path = oldPath.CGPath
        
        bgLayer.mask = layer1
        
        let ani1 = CABasicAnimation(keyPath: "path")
        ani1.fromValue = oldPath.CGPath
        ani1.toValue = newPath.CGPath
        ani1.beginTime = 0
        ani1.duration = 0.3
        
        let ani2 = CABasicAnimation(keyPath: "path")
        ani2.fromValue = newPath.CGPath
        ani2.toValue = oldPath.CGPath
        ani2.beginTime = ani1.duration
        ani2.duration = 0.3
        
        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [ani1, ani2];
        animationGroup.repeatCount = 10000
        animationGroup.duration = ani1.duration + ani2.duration
        
        layer1.addAnimation(animationGroup, forKey: "path")
    }
    
    func animation_mask_repeat1() {
        let bgLayer = self.addRadialGradientLayer( UIColor.redColor().colorWithAlphaComponent(0.75))
        
        let w = bounds.width / 2
        let h = bounds.height / 2
        let startBounds = CGRectInset(bounds, w * 0.6, h * 0.6)
        let endBounds = CGRectInset(bounds, w * 0.4, h * 0.4)
        
        let oldPath = UIBezierPath(ovalInRect: startBounds)
        let newPath = UIBezierPath(ovalInRect: endBounds)
        
        let layer1 = CAShapeLayer()
        layer1.path = oldPath.CGPath
        
        bgLayer.mask = layer1
        
        let ani1 = CABasicAnimation(keyPath: "path")
        ani1.fromValue = oldPath.CGPath
        ani1.toValue = newPath.CGPath
        ani1.beginTime = 0
        ani1.duration = 0.3
        
        let ani2 = CABasicAnimation(keyPath: "path")
        ani2.fromValue = newPath.CGPath
        ani2.toValue = oldPath.CGPath
        ani2.beginTime = ani1.duration
        ani2.duration = 0.3
        
        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [ani1, ani2];
        animationGroup.repeatCount = 10000
        animationGroup.duration = ani1.duration + ani2.duration
        
        layer1.addAnimation(animationGroup, forKey: "path")
    }
    
    
    func animation_mask_repeat2() {
        let bgLayer = self.addRadialGradientLayer( UIColor.redColor().colorWithAlphaComponent(0.5) )
        
        let w = bounds.width / 2
        let h = bounds.height / 2
        let startBounds = CGRectInset(bounds, w * 0.4, h * 0.4)
        let endBounds = CGRectInset(bounds, w * 0.2, h * 0.2)

        let oldPath = UIBezierPath(ovalInRect: startBounds)
        let newPath = UIBezierPath(ovalInRect: endBounds)
        
        let layer1 = CAShapeLayer()
        layer1.path = oldPath.CGPath
        
        bgLayer.mask = layer1

        let ani1 = CABasicAnimation(keyPath: "path")
        ani1.fromValue = oldPath.CGPath
        ani1.toValue = newPath.CGPath
        ani1.beginTime = 0
        ani1.duration = 0.3
        
        let ani2 = CABasicAnimation(keyPath: "path")
        ani2.fromValue = newPath.CGPath
        ani2.toValue = oldPath.CGPath
        ani2.beginTime = ani1.duration
        ani2.duration = 0.3

        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [ani1, ani2];
        animationGroup.repeatCount = 10000
        animationGroup.duration = ani1.duration + ani2.duration
        
        layer1.addAnimation(animationGroup, forKey: "path")
    }
}
