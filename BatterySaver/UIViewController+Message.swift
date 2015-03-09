//
//  UIViewController+Message.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 05/03/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

extension UIViewController
{
    func sendMessage(messageDelegate:protocol<MFMessageComposeViewControllerDelegate>) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            
        var messageVC = MFMessageComposeViewController()
        messageVC.body=self.getMessageBody()
        messageVC.recipients=self.getContactsList()
        messageVC.messageComposeDelegate = messageDelegate;
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
             self.presentViewController(messageVC, animated: true, completion: nil)
            })
       })
    }
    
    func getContactsList()->NSArray
    {
        return selectedPhNumbers
    }
    
    func getMessageBody()->NSString
    {
        if ((NSUserDefaults.standardUserDefaults().valueForKey("message") as? String) != nil)
        {
            let message=(NSUserDefaults.standardUserDefaults().valueForKey("message") as? String)!
            return message
        }
        else
        {
            return "My Phone is out of battery. About to switch off. Will be back soon."
        }
    }
}