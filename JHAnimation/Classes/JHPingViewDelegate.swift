

//
//  JHPingViewDelegate.swift
//  Pods
//
//  Created by Huan Jiang on 5/20/16.
//
//

@objc public protocol JHPingViewDelegate: class {
    optional func onTapped(isRunning:Bool) -> Void;
}
