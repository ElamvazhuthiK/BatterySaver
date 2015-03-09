//
//  PreferenceViewController.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 06/03/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit

class PreferenceViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate
{
    let preferenceValues:NSArray=["Automatic","Cellular Only","Wifi Only"]
    override func loadView() {
        
       var frame=UIScreen.mainScreen().bounds
       var preferenceView:PreferenceView=PreferenceView(frame: frame);
        preferenceView.controllerDelegate=self;
        self.view=preferenceView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title="Preference"
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        (self.view as PreferenceView).loadView()
        (self.view as PreferenceView).preferenceValueChanged(preferenceValues.indexOfObject(messagePreference))
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.preferenceValues.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 35
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier="contactstable"
        var tableviewCell:UITableViewCell?=tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        
        if !(tableviewCell == nil)
        {
            tableviewCell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            tableviewCell?.selectionStyle=UITableViewCellSelectionStyle.None
            tableviewCell?.accessoryView?.tintColor=getPurpleColor()
        }
        tableviewCell?.textLabel.text=self.preferenceValues[indexPath.row] as? String
        tableviewCell?.textLabel.font=NORMAL_FONT
        tableviewCell?.textLabel.textColor=UIColor.blackColor()
         tableviewCell?.accessoryType=UITableViewCellAccessoryType.None
        if(messagePreference==preferenceValues[indexPath.row] as NSString)
        {
            tableviewCell?.accessoryType=UITableViewCellAccessoryType.Checkmark
        }
        return tableviewCell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let row :Int = preferenceValues.indexOfObject(messagePreference)
        let previousIndexPath:NSIndexPath=NSIndexPath(forRow: row, inSection: 0)
        tableView.cellForRowAtIndexPath(previousIndexPath)?.accessoryType=UITableViewCellAccessoryType.None
        messagePreference=preferenceValues[indexPath.row] as String
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType=UITableViewCellAccessoryType.Checkmark
        (self.view as PreferenceView).preferenceValueChanged(indexPath.row)
        
    }
    

    
}
