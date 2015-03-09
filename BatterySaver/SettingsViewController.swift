//
//  SettingsViewController.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 28/02/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit
import AddressBook


protocol SettingsViewDelegate:UITableViewDelegate,UITableViewDataSource
{
    func showContacts()
    func showPreferences()
}


class SettingsViewController: BaseViewController,SettingsViewDelegate {
    
   
    
    override func loadView() {
        
        var frame=UIScreen.mainScreen().bounds
       // frame.origin.y+=60
        //frame.size.height-=60
        var settingsView:SettingsView=SettingsView(frame: frame);
        settingsView.controllerDelegate=self;
        self.view=settingsView
    }

    override func viewDidLoad() {
      
        super.viewDidLoad()
        self.navigationItem.title="Settings"
        (self.view as SettingsView).loadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
       
        super.viewWillAppear(animated)
       (self.view as SettingsView).loadData()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return appdelegate.contactsArr.count;
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier="contactstable"
        var tableviewCell:UITableViewCell?=tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        
        if !(tableviewCell == nil)
        {
            tableviewCell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
       
        var record:ABRecordRef=appdelegate.contactsArr[indexPath.row]
       
        
        tableviewCell?.textLabel.text=ABRecordCopyValue(record, kABPersonFirstNameProperty).takeRetainedValue() as? String
        tableviewCell?.textLabel.font=NORMAL_FONT
        tableviewCell?.textLabel.textColor=UIColor.blackColor()
        tableviewCell?.editing=true
        return tableviewCell!

    }
    
     func showContacts() {
    
        let viewControllerToPresent:ContactsViewController=ContactsViewController(nibName: nil, bundle: nil)
              //  viewControllerToPresent.modalTransitionStyle=UIModalTransitionStyle.CoverVertical
        self.navigationController?.pushViewController(viewControllerToPresent, animated: true)
    
        
    }
     func showPreferences()  {
        
        let viewControllerToPresent:PreferenceViewController=PreferenceViewController()
        //  viewControllerToPresent.modalTransitionStyle=UIModalTransitionStyle.CoverVertical
        self.navigationController?.pushViewController(viewControllerToPresent, animated: true)
        
        
    }

    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            deleteContact(appdelegate.contactsArr[indexPath.row])
            appdelegate.contactsArr.removeObjectAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
