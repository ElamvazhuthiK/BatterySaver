    //
//  AppDelegate.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 28/02/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit
import AddressBook


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var contactsArr:NSMutableArray=NSMutableArray()
    let addressBook: ABAddressBook=ABAddressBookCreateWithOptions(nil,nil).takeRetainedValue()
    var bgTask:UIBackgroundTaskIdentifier=0
    var timer:NSTimer=NSTimer()
    var window: UIWindow=UIWindow(frame: UIScreen.mainScreen().bounds)
    let navController:UINavigationController=UINavigationController(rootViewController: ChargeStateViewController())
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
        initialSetup()
        self.configureAppearance()
        window.rootViewController=navController
        window.makeKeyAndVisible()
        UIDevice.currentDevice().batteryMonitoringEnabled=true;

        return true
    }
    
    func configureAppearance()
    {

        UILabel.appearance().textColor=getPurpleColor()
        UINavigationBar.appearance().tintColor=getPurpleColor()
        
    }
    
    func initialSetup()
    {
        self.createLocalNotification()
        if let contactsVal: AnyObject=NSUserDefaults.standardUserDefaults().valueForKey("contacts")
        {
            getRecordForContacts()
        }
        
        unLoadSettings()

    }
    func getRecordForContacts()
    {
        var recordIDArr:Array<String>=NSUserDefaults.standardUserDefaults().valueForKey("contacts") as Array
        for recordID in recordIDArr
        {
            
            var recordInt:Int32=(recordID as NSString).intValue
            var record:ABRecordID=recordInt as ABRecordID
            var recordRef:ABRecordRef=(ABAddressBookGetPersonWithRecordID(addressBook,record)).takeRetainedValue()
           
            contactsArr.addObject(recordRef)
            addContactToPhNumber(recordRef)
            
        }
        
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        /* Save to userDefaults */
      
        var recordArr:NSMutableArray=NSMutableArray()
        for record in self.contactsArr
        {
        recordArr.addObject(String.convertFromStringInterpolationSegment(ABRecordGetRecordID(record)))
            
        }
        
        loadSettings()
        userDefaults.setObject(recordArr, forKey: "contacts")
        userDefaults.synchronize()
        
    }
    
    func startBackgroundTask()
    {
        stopBackgroundTask()
        bgTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.bgTask)
            self.bgTask = UIBackgroundTaskInvalid;
            
            
           
        })
         checkBatteryLevel()
         self.timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector:Selector("checkBatteryLevel"), userInfo: nil, repeats: true)
    //in case bg task is killed faster than expected, try to start Location Service
    
    }
    
    func checkBatteryLevel()
    {
        println("Battery")
        if(UIDevice.currentDevice().batteryLevel>=0.96 && UIDevice.currentDevice().batteryState==UIDeviceBatteryState.Charging && fullNotification)
        {
            println("full Notification")
            sendLocalNotification(false)
            self.timer.invalidate()
        }
        if(UIDevice.currentDevice().batteryLevel>0.1 && UIDevice.currentDevice().batteryState==UIDeviceBatteryState.Unplugged && lowNotification)
        {
            println("low Notification")

            sendLocalNotification(true)
            self.timer.invalidate()
        }
    }
    
    func stopBackgroundTask()
    {
        if !(self.bgTask==UIBackgroundTaskInvalid)
        {
                UIApplication.sharedApplication().endBackgroundTask(self.bgTask);
                self.bgTask = UIBackgroundTaskInvalid;
        }
    }
    
    func createLocalNotification()
    {
        let types:UIUserNotificationType=UIUserNotificationType.Alert|UIUserNotificationType.Sound
     
        let msgAction:UIMutableUserNotificationAction=UIMutableUserNotificationAction()
        msgAction.destructive=false
        msgAction.title="Send Message"
        msgAction.identifier="messageidentifier"
        msgAction.activationMode = UIUserNotificationActivationMode.Background;
        msgAction.authenticationRequired=false;
        
        
        let smsAction:UIMutableUserNotificationAction=UIMutableUserNotificationAction()
        smsAction.destructive=false
        smsAction.title="Send SMS"
        smsAction.identifier="smsidentifier"
        smsAction.activationMode = UIUserNotificationActivationMode.Foreground;
        smsAction.authenticationRequired=false;
        
        let cancelAction:UIMutableUserNotificationAction=UIMutableUserNotificationAction()
        cancelAction.destructive=false;
        cancelAction.title="Cancel";
        cancelAction.activationMode = UIUserNotificationActivationMode.Background;
        cancelAction.authenticationRequired=false;
        
        let msgcategory:UIMutableUserNotificationCategory=UIMutableUserNotificationCategory()
        msgcategory.identifier="BatteryLowMessage";
        msgcategory.setActions(NSArray(object: msgAction), forContext: UIUserNotificationActionContext.Default)
        msgcategory.setActions(NSArray(object: msgAction), forContext: UIUserNotificationActionContext.Minimal)
        
        
        let smscategory:UIMutableUserNotificationCategory=UIMutableUserNotificationCategory()
        smscategory.identifier="BatteryLowSMS";
        smscategory.setActions(NSArray(object: smsAction), forContext: UIUserNotificationActionContext.Default)
        smscategory.setActions(NSArray(object: cancelAction), forContext: UIUserNotificationActionContext.Minimal)

        
        let mySettings:UIUserNotificationSettings=UIUserNotificationSettings(forTypes: types, categories: NSSet(objects:msgcategory,smscategory))
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)

    }
    
    func sendLocalNotification(lowBattery:Bool)
    {
        let localNotification:UILocalNotification=UILocalNotification()
        var reachability:Reachability=Reachability.reachabilityForInternetConnection()

        if(lowBattery &&  msgEnabled)
        {
            if(messagePreference=="Automatic")
            {
                if reachability.isReachable()
                {
                    localNotification.category="BatteryLowMessage";
                }
                else
                {
               
                    localNotification.category="BatteryLowSMS";
                }
            }
            else if(messagePreference=="Wifi Only")
            {
                localNotification.category="BatteryLowMessage";
            }
            else
            {
                localNotification.category="BatteryLowSMS";
            }
            localNotification.alertAction = "Swipe to send SMS";

        }
        localNotification.timeZone = NSTimeZone.defaultTimeZone();
        localNotification.fireDate=NSDate();
        localNotification.hasAction=true;
        //localNotif.
        // Notification details
        if lowBattery
        {
            localNotification.alertBody="Battery will be down in some time";
        }// Set the action button
        else
        {
            localNotification.alertBody="Battery charge is almost full";
        }// Set the action button
    
        
        localNotification.soundName = UILocalNotificationDefaultSoundName
        
        // Specify custom data for the notification
        let userInfoDict:NSDictionary = ["someValue":"someKey"];
        localNotification.userInfo = userInfoDict;
        // Schedule the notification
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification);

    }
    func sendSMSViaInternet()
    {
        var contacts:NSArray=selectedPhNumbers
        var contactLocal:NSMutableArray=NSMutableArray()
        var contactStr:NSString=NSString(string:contacts.componentsJoinedByString(";"))
        
        contactStr=((contactStr.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "- "))) as NSArray).componentsJoinedByString("")
        
        contactLocal=NSMutableArray(array:contactStr.componentsSeparatedByString(";"))
        
        for i in 0...contactLocal.count-1
        {
           contactLocal[i]=contactLocal[i].substringFromIndex(contactLocal[i].length()-10) as String
        }
        
        contactStr=contactLocal.componentsJoinedByString(";")
      
       
      

        var urlStr:NSString=NSString(string:"https://site2sms.p.mashape.com/index.php?msg=\(getMessageBody())&phone=\(contactStr)&pwd=saranyasiva&uid=9677267222")
        
        var url:NSURL?=NSURL(string:(urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding))!)
        
    
        var request:NSMutableURLRequest=NSMutableURLRequest(URL:url!)
        request.HTTPMethod="GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("g7bUM4aR6umshjVMBDdqqi2G8XVWp1SNbWQjsngHlb67pbqLto", forHTTPHeaderField: "X-Mashape-Key")
        request.setValue("Accept", forHTTPHeaderField: "application/json")
        let queue:NSOperationQueue=NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response: NSURLResponse!, data: NSData!, error:NSError!) -> Void in
            
            if (error != nil)
            {
                println(error.localizedDescription)
            }
            else
            {
                var error1: NSError?
                let json:NSDictionary=NSJSONSerialization.JSONObjectWithData(data,options: NSJSONReadingOptions.MutableContainers,error: &error1) as NSDictionary
                println(json)
            }
        
        }
    }
    
    func sendSMS()
    {
        (self.navController.topViewController as BaseViewController).showMessageViewController()
    }


     func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        if identifier=="messageidentifier"
        {
             sendSMSViaInternet()
            
        }
        else if identifier=="smsidentifier"{
            sendSMS()
        }
        else
        {
            
        }

        completionHandler()
    }
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
         startBackgroundTask()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
       
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

