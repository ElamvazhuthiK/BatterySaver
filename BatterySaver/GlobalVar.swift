//
//  Macros.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 04/03/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import Foundation
import UIKit
import AddressBook

let BIG_BOLD_FONT:UIFont=UIFont(name: "HelveticaNeue-Bold", size: 16)!
let BIG_FONT:UIFont=UIFont(name: "HelveticaNeue", size: 16)!
let NORMAL_FONT:UIFont=UIFont(name: "HelveticaNeue", size: 15)!
let NORMAL_BOLD_FONT:UIFont=UIFont(name: "HelveticaNeue-Bold", size: 15)!
let SMALL_FONT:UIFont=UIFont(name: "HelveticaNeue", size: 14)!
let SMALL_BOLD_FONT:UIFont=UIFont(name: "HelveticaNeue-Bold", size: 14)!
let defaultMessage:NSString="My(Your Name) Phone is out of battery. About to switch off. Will be back soon."
var fullNotification:Bool=true
let GREENCOLOR=UIColorFromRGB(0x40CF7D)
var lowNotification:Bool=true
var msgEnabled:Bool=true
var userDefaults:NSUserDefaults=NSUserDefaults.standardUserDefaults()
var messagePreference:String="Automatic"

var selectedPhNumbers:NSMutableArray=NSMutableArray()

func UIColorFromRGB(rgbValue:Int)->UIColor
{
    let blueV=(rgbValue & 0xFF)
    let redV=((rgbValue & 0xFF0000) >> 16)
    let greenV=((rgbValue & 0xFF00) >> 8)
    return UIColor(red:CGFloat(redV)/255.0,green:CGFloat(greenV)/255.0,blue:CGFloat(blueV)/255.0,alpha:1.0)
}

func getPurpleColor()->UIColor
{
   return UIColorFromRGB(0xf84640)
}

func deleteContact(contact:ABRecordRef)
{
  selectedPhNumbers.removeObject(getPhoneNumberForContact(contact))
}


func addContactsToPhNumbers(contacts:Array<ABRecordRef>)
{
    for (record:ABRecordRef) in contacts
    {
        selectedPhNumbers.addObject(getPhoneNumberForContact(record))
    }
}

func addContactToPhNumber(contact:ABRecordRef)
{
   selectedPhNumbers.addObject(getPhoneNumberForContact(contact))
}
func getPhoneNumberForContact(record:ABRecordRef)->String
{
    let phoneProperty=ABRecordCopyValue(record, kABPersonPhoneProperty)
    var phoneString:String?
    if let ab = phoneProperty {
        let phonePropertyValue:ABMultiValueRef=Unmanaged.fromOpaque(phoneProperty.toOpaque()).takeUnretainedValue() as ABMultiValueRef
        if ABMultiValueGetCount(phonePropertyValue)>0
        {
            
            let ABphone:CFTypeRef = (ABMultiValueCopyValueAtIndex(phonePropertyValue, 0)).takeRetainedValue()
            return ABphone as String
            
        }
        else
        {
                      return phoneString!
        }
    }
    else
    {
       
         return phoneString!
    }
 
}

func extractABEmailAddress (abEmailAddress: Unmanaged<AnyObject>!) -> String? {
    if let ab = abEmailAddress {
        return Unmanaged.fromOpaque(abEmailAddress.toOpaque()).takeUnretainedValue() as CFStringRef
    }
    return nil
}

func getMessageBody()->NSString
{
    if ((userDefaults.valueForKey("message") as? String) != nil)
    {
        let message=(userDefaults.valueForKey("message") as? String)!
        return message
    }
    else
    {
        return defaultMessage
    }
    
}

func unLoadSettings()
{
   
    if let lnotif: Bool=userDefaults.valueForKey("lownotification") as? Bool
    {
        lowNotification=lnotif
    }
    if let fNotif: Bool=userDefaults.valueForKey("fullnotification") as? Bool
    {
        lowNotification=fNotif
    }
    if let msgVal: Bool=userDefaults.valueForKey("msgNotify") as? Bool
    {
        msgEnabled=msgVal
    }
    if  let preference: NSString=(NSUserDefaults.standardUserDefaults().valueForKey("preference") as? NSString)
    {
        messagePreference=preference
    }
    
}


func setTitleColorForButton(btn:UIButton)
{
    btn.setTitleColor(getPurpleColor(), forState: UIControlState.Normal)
    btn.setTitleColor(getPurpleColor(), forState: UIControlState.Selected)
    btn.setTitleColor(getPurpleColor(), forState: UIControlState.Application)
}


func loadSettings()
{
    
    userDefaults.setBool(lowNotification, forKey: "lownotification")
    userDefaults.setBool(fullNotification, forKey: "fullnotification")
    userDefaults.setBool(msgEnabled, forKey: "msgNotify")
    userDefaults.setObject(messagePreference, forKey: "preference")

}


