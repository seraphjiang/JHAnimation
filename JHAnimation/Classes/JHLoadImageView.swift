//
//  JHLoadImageView.swift
//  Pods
//
//  Created by Huan Jiang on 5/21/16.
//
//

import UIKit

public class JHLoadImageView: UIImageView {
    
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
        
    }
    
    public func load(url: String) {
        
    }
    
    func addCircle() {
        let path = UIBezierPath(ovalInRect: bounds)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.CGPath
        layer.mask = maskLayer
        
    }
}
