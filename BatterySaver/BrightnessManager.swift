//
//  File.swift
//  BatterySaver
//
//  Created by suresh ramasamy on 09/03/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class BrightnessManager: UIView
{
    var brightnessSlider:UISlider=UISlider();
    var flashSlider:UISlider=UISlider();
    
    override init(frame:CGRect)
    {
        super.init(frame:frame);
        
        self.createViewComponents();
    }

    func createViewComponents()
    {
        var brightnessLbl=UILabel(frame: CGRectMake(10, 0, 150, 20));
        brightnessLbl.text="Adjust brightness";
        brightnessLbl.font=UIFont(name: "Helvetica", size: 14)
        brightnessLbl.backgroundColor=UIColor.clearColor();
        self.addSubview(brightnessLbl);
        
        brightnessSlider = UISlider(frame:CGRectMake(20, 30, self.frame.size.width-40, 20))
        brightnessSlider.minimumValue = 0
        brightnessSlider.maximumValue = 100
        brightnessSlider.continuous = true
        brightnessSlider.tintColor = UIColor.redColor()
        brightnessSlider.value=Float(UIScreen.mainScreen().brightness*100)
        brightnessSlider.addTarget(self, action: "brightnessSliderValueDidChange:", forControlEvents: .ValueChanged)
        self.addSubview(brightnessSlider)
        
        var flashBrightnessLbl=UILabel(frame: CGRectMake(10, 70, 150, 20));
        flashBrightnessLbl.text="Adjust flash brightness";
        flashBrightnessLbl.font=UIFont(name: "Helvetica", size: 14)
        flashBrightnessLbl.backgroundColor=UIColor.clearColor();
        self.addSubview(flashBrightnessLbl);
        
        flashSlider = UISlider(frame:CGRectMake(20, 100, self.frame.size.width-40, 20))
        flashSlider.minimumValue = 0
        flashSlider.maximumValue = 100
        flashSlider.continuous = true
        flashSlider.tintColor = UIColor.redColor()
        flashSlider.value=Float(UIScreen.mainScreen().brightness*100)
        flashSlider.addTarget(self, action: "flashSliderValueDidChange:", forControlEvents: .ValueChanged)
        self.addSubview(flashSlider)
    }
    
    func resetSliderValue()
    {
        self.brightnessSlider.value=Float(UIScreen.mainScreen().brightness*100);
    }
    
    func getSliderValue()->Float
    {
        return self.brightnessSlider.value;
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func brightnessSliderValueDidChange(sender:UISlider!)
    {
        UIScreen.mainScreen().brightness=CGFloat(brightnessSlider.value/100);
    }
    
    func switchOfFlashLight()
    {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch)
        {
            device.lockForConfiguration(nil)
            if (device.torchMode == AVCaptureTorchMode.On)
            {
                device.torchMode = AVCaptureTorchMode.Off
            }
            device.unlockForConfiguration()
        }
    }
    
    func flashSliderValueDidChange(sender:UISlider!)
    {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
//        if (device.hasTorch)
//        {
        device.lockForConfiguration(nil)
        
        if(flashSlider.value==0.0)
        {
            device.setTorchModeOnWithLevel(0.1, error: nil)
        }
        else
        {
            device.setTorchModeOnWithLevel((flashSlider.value/100), error: nil)
        }
        device.unlockForConfiguration()
//        }
    }
}