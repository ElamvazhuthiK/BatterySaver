//
//  PreferenceView.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 06/03/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit

class PreferenceView: UIView {

    let preferenceTable:UITableView=UITableView()
    let lblDetail:UILabel=UILabel()
    var controllerDelegate:protocol<UITableViewDelegate,UITableViewDataSource>?
    let detailArray:Array<String>=["Quick Action in Battery Low Notification works based on internet availability. Message Via SMS (default messaging service) will work when internet is not available and vice versa.","Quick Action (send Message) Battery Low Notification on selection sends SMS via internet in the background ","Quick Action (send SMS) in Battery Low Notification on selection just asks for the approval to send SMS via messaging service"]

    override init(frame:CGRect)
    {
        super.init(frame:frame);
        self.preferenceTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "contactstable")
        self.lblDetail.textColor=UIColor.grayColor()
        self.lblDetail.font=SMALL_FONT
        self.lblDetail.numberOfLines=0
        self.backgroundColor=UIColor.whiteColor()
        self.addSubview(lblDetail)
        self.addSubview(preferenceTable)
        setLayoutForViews()
    
        

    }
    
    func setLayoutForViews() {
        self.preferenceTable.frame=CGRectMake(0, 85, self.frame.size.width, 35*3)
        self.lblDetail.frame=CGRectMake(10, self.preferenceTable.frame.origin.y, self.frame.size.width-20, self.frame.size.height/2)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func loadView()
    {
        self.preferenceTable.delegate=self.controllerDelegate?
        self.preferenceTable.dataSource=self.controllerDelegate?
        self.preferenceTable.reloadData()
        
    }
    func preferenceValueChanged(selectedPreference:Int )
    {
        lblDetail.text=detailArray[selectedPreference]
    }
    

}
