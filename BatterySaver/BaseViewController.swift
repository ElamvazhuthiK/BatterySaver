//
//  BaseViewController.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 05/03/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit
import MessageUI


class BaseViewController: UIViewController,MFMessageComposeViewControllerDelegate {
    lazy var appdelegate:AppDelegate=UIApplication.sharedApplication().delegate as AppDelegate

    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        switch (result.value) {
        case MessageComposeResultCancelled.value:
            println("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.value:
            println("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.value:
            println("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }
    
    func showMessageViewController()
    {
        self.sendMessage(self)
    }

}
