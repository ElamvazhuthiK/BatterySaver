//
//  SettingFieldView.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 07/03/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit

class SettingFieldView: UIView {

    let percent:CGFloat=0.8
    let fieldLabel:UILabel=UILabel()
    let fieldValue:UISwitch=UISwitch()
    let fieldSeparator:UILabel=UILabel()
    let fieldValueSize:CGSize=CGSizeZero

   
    override convenience init()
    {
        self.init(frame: CGRectZero)
    }
    
    
    override init(frame:CGRect)
    {
        super.init(frame:frame);
        
        self.fieldLabel.text=""
        self.fieldLabel.textColor=UIColor.grayColor()
        self.fieldLabel.font=NORMAL_FONT
        self.addSubview(self.fieldLabel)
        
        self.fieldValue.tintColor=getPurpleColor()
        self.fieldValue.onTintColor=getPurpleColor()
        
        self.addSubview(self.fieldValue)
        
        fieldValueSize=self.fieldValue.frame.size
        self.fieldValue.transform=CGAffineTransformMakeScale(percent, percent)
        fieldValueSize.height*=percent
        fieldValueSize.width*=percent
        
        self.fieldSeparator.backgroundColor=UIColorFromRGB(0xeeeeee)
        self.addSubview(self.fieldSeparator)
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

    override func layoutSubviews() {
        
        super.layoutSubviews()
        var marginX:CGFloat=15
        var rightMargin:CGFloat=8
        var marginY:CGFloat=0
        var widthMinusMargin:CGFloat=self.frame.size.width-(marginX+rightMargin)
        fieldLabel.frame=CGRectMake(marginX, 0, widthMinusMargin*(3/4), self.frame.size.height-1)
        fieldValue.frame=CGRectMake(self.frame.size.width-(fieldValueSize.width+rightMargin),(self.frame.size.height-(fieldValueSize.height))/2, fieldValueSize.width, fieldValueSize.height)
        fieldSeparator.frame=CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)
        

        
    }
    

}
