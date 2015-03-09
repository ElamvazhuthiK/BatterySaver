//
//  SettingsView.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 28/02/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit
import AddressBook

class SettingsView: UIView, UITextViewDelegate {

    let defaultMessage:NSString="My(Your Name) Phone is out of battery. About to switch off. Will be back soon."
    let scrollView:UIScrollView=UIScrollView()
    let messageLbl:UILabel=UILabel()
    let messageText:UITextView=UITextView();
    let contactsTable:UITableView=UITableView();
    let addButton:UIButton=UIButton();
    let saveBtn:UIButton=UIButton();
    let contactsLbl:UILabel=UILabel()
    var messsageTextValue:String=String()
    let messagePreferenceContainer:UIView=UIView()
    let msgPreferenceLabel:UILabel=UILabel()
    let msgPreferenceValue:UILabel=UILabel()
    let batteryFullNotifcationCont=SettingFieldView()
    let batteryLowNotificationCont=SettingFieldView()
    let messageOnLowBattery=SettingFieldView()
    let messageSeparator=UILabel()
    
    var controllerDelegate:SettingsViewDelegate?
    let addressBook: ABAddressBook=ABAddressBookCreateWithOptions(nil,nil).takeRetainedValue()
     lazy var appdelegate:AppDelegate=UIApplication.sharedApplication().delegate as AppDelegate
    
   
    override init(frame:CGRect)
    {
        super.init(frame:frame);
        // Set Layout
        
        self.backgroundColor=UIColor.whiteColor()
        scrollView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
      //  scrollView.backgroundColor=UIColor.orangeColor()
        self.addSubview(scrollView)
        scrollView.addSubview(messageLbl)
        scrollView.addSubview(messageText);
        scrollView.addSubview(contactsTable);
        scrollView.addSubview(addButton);
        scrollView.addSubview(self.contactsLbl)
        scrollView.addSubview(self.saveBtn)
        scrollView.addSubview(self.messageSeparator)
        scrollView.addSubview(self.messagePreferenceContainer)
        scrollView.addSubview(self.batteryFullNotifcationCont)
        scrollView.addSubview(self.batteryLowNotificationCont)
        scrollView.addSubview(self.messageOnLowBattery)
        self.configureViews();
        self.messagePreferenceContainer.addSubview(self.msgPreferenceLabel)
        self.messagePreferenceContainer.addSubview(self.msgPreferenceValue)
        let tapGesture:UITapGestureRecognizer=UITapGestureRecognizer(target:self, action: Selector("preferenceSelected"))
       self.messagePreferenceContainer.addGestureRecognizer(tapGesture)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    func preferenceSelected()
    {
        self.controllerDelegate?.showPreferences()
    }
    func configureViews()
    {
        
        self.batteryFullNotifcationCont.fieldLabel.text="Battery-Full Notification"
        self.batteryFullNotifcationCont.fieldValue.addTarget(self, action: Selector("fullNotificationValueChanged"), forControlEvents: UIControlEvents.ValueChanged)
        
        
        self.batteryLowNotificationCont.fieldLabel.text="Battery-Low Notification"
        self.batteryLowNotificationCont.fieldValue.addTarget(self, action: Selector("lowNotificationValueChanged"), forControlEvents: UIControlEvents.ValueChanged)
        
        
        self.messageOnLowBattery.fieldLabel.text="Message on low Battery"
        self.messageOnLowBattery.fieldValue.addTarget(self, action: Selector("msgNotificationValueChanged"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.messageOnLowBattery.fieldSeparator.hidden=true
    
        self.messageLbl.backgroundColor=UIColor.clearColor()
        self.messageLbl.textColor=UIColor.grayColor()
        self.messageLbl.text="Message"
        self.messageLbl.font=NORMAL_FONT
        //self.messageLbl.textColor=UIColor.lightGrayColor()
        
        self.messageText.delegate=self;
        self.messageText.text=defaultMessage
        self.messageText.textColor=UIColor.darkTextColor()
        self.messageText.font=NORMAL_FONT
        
        self.messageSeparator.backgroundColor=UIColorFromRGB(0xdddddd)
        self.messagePreferenceContainer.backgroundColor=UIColor.clearColor()
        self.messagePreferenceContainer.layer.borderWidth=1;
        self.messagePreferenceContainer.layer.borderColor=UIColorFromRGB(0xdddddd).CGColor
        
        
        self.msgPreferenceLabel.text="Message Preference"
        self.msgPreferenceLabel.textColor=UIColor.grayColor()
        self.msgPreferenceLabel.font=NORMAL_FONT
        
        self.msgPreferenceValue.text="Automatic"
        self.msgPreferenceValue.textAlignment=NSTextAlignment.Right
        self.msgPreferenceValue.font=NORMAL_FONT
        self.msgPreferenceValue.textColor=getPurpleColor()
       
        
        self.contactsLbl.text="Contacts"
        self.contactsLbl.font=NORMAL_FONT
        self.contactsLbl.textColor=UIColor.grayColor()
        
        self.contactsTable.dataSource=self.controllerDelegate?
        self.contactsTable.delegate=self.controllerDelegate?
        self.contactsTable.scrollEnabled=false
        self.contactsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "contactstable")
        
        self.addButton.setTitle("⊕", forState: UIControlState.Normal)
        self.addButton.setTitle("⊕", forState: UIControlState.Selected)
        self.addButton.setTitle("⊕", forState: UIControlState.Application)
        self.addButton.addTarget(self, action:Selector("addContacts"), forControlEvents: UIControlEvents.TouchUpInside)
        setTitleColorForButton(self.addButton)
        
        self.saveBtn.setTitle("✓", forState: UIControlState.Normal)
        self.saveBtn.setTitle("✓", forState: UIControlState.Selected)
        self.saveBtn.setTitle("✓", forState: UIControlState.Application)
        self.saveBtn.addTarget(self, action:Selector("saveMessage"), forControlEvents: UIControlEvents.TouchUpInside)
        self.setLayoutForViews()
        setTitleColorForButton(self.saveBtn)
        
    }
    

    func setLayouts()
    {
        let viewsDictionary = ["messageText":self.messageText,"contactsTable":self.contactsTable,"addButton":self.addButton,"messageLbl":self.messageLbl]
      
        let view1_constraint_H: Array =  NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-50-[messageLbl]-[messageText]-30-[contactsTable]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let view1_constraint_V: Array =  NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-50-[messageLbl]-[messageText]-30-[contactsTable]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(view1_constraint_V)
    }
    
    func loadData()
    {
        self.messageText.text=getMessageBody()
        self.saveBtn.hidden=true
        self.contactsTable.delegate=self.controllerDelegate?
        self.contactsTable.dataSource=self.controllerDelegate?
        self.contactsTable.reloadData()
        var height:CGFloat=self.frame.size.height-(self.contactsLbl.frame.size.height+self.contactsLbl.frame.origin.y+10)
        var tableHeight:CGFloat=CGFloat(((self.appdelegate).contactsArr.count)*35)
        if height>tableHeight
        {
            height=tableHeight
        }
        self.contactsTable.frame=CGRectMake(8, self.contactsLbl.frame.size.height+self.contactsLbl.frame.origin.y+10,self.messageText.frame.size.width,height )
        height=self.contactsTable.frame.origin.y+self.contactsTable.frame.size.height
        if(self.frame.size.height>(self.contactsTable.frame.origin.y+self.contactsTable.frame.size.height))
        {
            height=self.frame.size.height
            
        }
        scrollView.contentSize=CGSizeMake(self.frame.size.width,height)
        loadViewAsPerSettings()
    }
    
    func loadViewAsPerSettings()
    {
        self.batteryFullNotifcationCont.fieldValue.on=fullNotification
        self.batteryLowNotificationCont.fieldValue.on=lowNotification
        self.messageOnLowBattery.fieldValue.on=msgEnabled
        lowNotificationValueChanged()
        msgPreferenceValue.text=messagePreference
        
    }
    func fullNotificationValueChanged()
    {
        fullNotification=batteryFullNotifcationCont.fieldValue.on
    }
    
    func lowNotificationValueChanged()
    {
        lowNotification=batteryLowNotificationCont.fieldValue.on
        messageOnLowBattery.hidden = !lowNotification
        messageSettingsDisplay()
    }
    
    func msgNotificationValueChanged()
    {
        msgEnabled=messageOnLowBattery.fieldValue.on
        messageSettingsDisplay()
    }
    
    func messageSettingsDisplay()
    {
        let hide:Bool = !(msgEnabled && lowNotification)
        messageLbl.hidden=hide
        messagePreferenceContainer.hidden=hide
        messageSeparator.hidden=hide
        messageText.hidden=hide
        contactsLbl.hidden=hide
        contactsTable.hidden=hide
    }
    
    func setLayoutForViews()
    {
        var marginX:CGFloat=15
        var rightMargin:CGFloat=8
        var marginY:CGFloat=0
        var widthMinusMargin:CGFloat=self.frame.size.width-(marginX+rightMargin)
        
        
        self.batteryFullNotifcationCont.frame=CGRectMake(0, marginY, self.frame.size.width, 60)
        self.batteryLowNotificationCont.frame=CGRectMake(0, self.batteryFullNotifcationCont.frame.size.height+self.batteryFullNotifcationCont.frame.origin.y, self.frame.size.width, 60)
        self.messageOnLowBattery.frame=CGRectMake(0, self.batteryLowNotificationCont.frame.size.height+self.batteryLowNotificationCont.frame.origin.y, self.frame.size.width, 60)
        self.messagePreferenceContainer.frame=CGRectMake(0, self.messageOnLowBattery.frame.size.height+self.messageOnLowBattery.frame.origin.y, self.frame.size.width, 60)
        self.msgPreferenceLabel.frame=CGRectMake(marginX,0,widthMinusMargin,self.messagePreferenceContainer.frame.size.height)
        self.msgPreferenceValue.frame=CGRectMake(((widthMinusMargin)*3/4)+marginX,0,(widthMinusMargin)/4,self.messagePreferenceContainer.frame.size.height)
        
        self.messageLbl.frame=CGRectMake(marginX, self.messagePreferenceContainer.frame.size.height+self.messagePreferenceContainer.frame.origin.y+10,widthMinusMargin ,20 )
        self.saveBtn.frame=CGRectMake(marginX+widthMinusMargin-35, self.messageLbl.frame.origin.y,40 ,40 )
        self.messageText.frame=CGRectMake(marginX-5, self.messageLbl.frame.origin.y+self.messageLbl.frame.size.height+10, widthMinusMargin+10, 80)
        self.messageSeparator.frame=CGRectMake(0, self.messageText.frame.origin.y+self.messageText.frame.size.height, self.frame.size.width, 1)
        
        self.contactsLbl.frame=CGRectMake(marginX, self.messageText.frame.size.height+self.messageText.frame.origin.y+10,self.messageText.frame.size.width,20)
       
        self.contactsTable.frame=CGRectMake(8, self.contactsLbl.frame.size.height+self.contactsLbl.frame.origin.y+10,self.messageText.frame.size.width,self.frame.size.height-(self.messageText.frame.size.height+self.messageText.frame.origin.y+40) )
        
        self.addButton.frame=CGRectMake(marginX+widthMinusMargin-35, self.contactsLbl.frame.origin.y,40, 40)
        
        
    }
    
    
    func getContacts()
    {
        self.controllerDelegate?.showContacts()
    }
    
    func addContacts()
    {
       if ABAddressBookGetAuthorizationStatus()==ABAuthorizationStatus.NotDetermined
       {
                ABAddressBookRequestAccessWithCompletion(self.addressBook, { (granted, error) -> Void in
                    if granted
                    {
                        self.getContacts()
                    }
                })
        }
        else
        {
            self.getContacts()
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
      self.saveBtn.hidden=false
      scrollView.setContentOffset(CGPointMake(0, 100), animated: true)
    }
    
    func saveMessage()
    {
        self.messageText.resignFirstResponder()
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        if let msg=self.messageText.text
        {
            NSUserDefaults.standardUserDefaults().setValue(msg, forKey: "message")
        }
        else
        {
            NSUserDefaults.standardUserDefaults().setValue("My Phone is out of battery. About to switch off. Will be back soon.", forKey: "message")
        }
        self.saveBtn.hidden=true
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
