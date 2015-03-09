//
//  BatteryLife.swift
//  ChargeStatus
//
//  Created by Elamvazhuthi Kannan on 05/03/15.
//  Copyright (c) 2015 Elamvazhuthi Kannan. All rights reserved.
//

import UIKit
private let DeviceList = [
    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
    /* iPhone 4 */        "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
    /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
    /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
    /* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
    /* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
    /* iPhone 6 */        "iPhone7,2": "iPhone 6",
    /* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
    /* iPad 2 */          "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
    /* iPad 3 */          "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
    /* iPad 4 */          "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
    /* iPad Air */        "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
    /* iPad Air 2 */      "iPad5,1": "iPad Air 2", "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
    /* iPad Mini */       "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
    /* iPad Mini 2 */     "iPad4,4": "iPad Mini", "iPad4,5": "iPad Mini", "iPad4,6": "iPad Mini",
    /* iPad Mini 3 */     "iPad4,7": "iPad Mini", "iPad4,8": "iPad Mini", "iPad4,9": "iPad Mini",
    /* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
]

public extension UIDevice {
    
    var modelName: String {
        //        let systemInfo:utsname = UnsafeMutablePointer<utsname>.alloc(1)
        //,release:(0, 0, 0, ..., 0),version:(0, 0, 0, ..., 0),machine:(0, 0, 0, ..., 0)
        var systemInfo = utsname(sysname: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), nodename: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), release: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), version: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),machine:(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        let mirror = reflect(machine)
        var identifier = ""
        
        for i in 0..<mirror.count
        {
            
            if let value=mirror[i].1.value as? Int8
            {
                if  value != 0
                {
                    identifier.append(UnicodeScalar(UInt8(value)))
                }
            }
        }
        
        return DeviceList[identifier] ?? identifier
    }
    
}

class Usage:NSObject {
    var name:NSString = NSString()
    var hours:Float = Float()
    var batteryLevel:Float = UIDevice.currentDevice().batteryLevel
    init(name:NSString, hours:Float)
    {
        super.init()
        self.name = name
        self.hours = hours
//        batteryLevel = 0.3;
    }
    //    helping methods
    func hours(h:Float, p:Float) -> Int
    {
        return Int(h * 60.0 * p)/60
    }
    func minuts(h:Float, p:Float) -> Int
    {
        return Int(h * 60.0 * p)%60
    }
    func timePerBatteryLevel()->NSString
    {
        return "\(hours(hours,p:batteryLevel))h: \(minuts(hours,p:batteryLevel))m"
    }
}

class UsageGroup {
    var name:NSString = NSString()
    var useGroup:Int = Int(1)
    var use:Int = Int(0)
    var usages:NSMutableArray = NSMutableArray()
}

class UsageGroups {
    var groups:NSMutableArray = NSMutableArray()
    func totalUsageMinuts() -> Float
    {
        var minutes:Float = Float(0)
        for index in 0...(groups.count - 1)
        {
            let usageGroup:UsageGroup = groups[index] as UsageGroup
            let usage:Usage = usageGroup.usages[usageGroup.use] as Usage
            if usageGroup.useGroup == 1 {
                minutes=(usage.hours*60)+minutes ;
            }
        }
        return minutes;
    }
    func usageMinutsPerBatteryLevel() -> Float
    {
        return totalUsageMinuts() * UIDevice.currentDevice().batteryLevel
//        return totalUsageMinuts() * 0.3
    }
}

class BatteryLife: NSObject {
    func getUsages() -> UsageGroups
    {
        let usageGroups:UsageGroups = UsageGroups()
        let model: NSString = UIDevice.currentDevice().modelName
        let multiMediaGroup:UsageGroup = UsageGroup()
        let talkTimeGroup:UsageGroup = UsageGroup()
        let browsingGroup:UsageGroup = UsageGroup()
        let othersGroup:UsageGroup = UsageGroup()
        
        var audio:Usage = Usage(name:"Audio", hours:24)
        var video:Usage = Usage(name:"Video", hours:7)
        var talk2G:Usage = Usage(name:"2G", hours:8)
        var talk3G:Usage = Usage(name:"3G", hours:8)
        var browsing3G:Usage = Usage(name:"3G", hours:12)
        var browsingWIFI:Usage = Usage(name:"WIFI", hours:12)
        var browsingLET:Usage = Usage(name:"LET", hours:12)
        var standby:Usage = Usage(name:"Standby", hours:384)
    
        switch model {
        case "iPod Touch 5":
            audio = Usage(name:"Audio", hours:24)
            video = Usage(name:"Video", hours:7)
            talk2G = Usage(name:"2G", hours:24)
            talk3G = Usage(name:"3G", hours:7)
            browsing3G = Usage(name:"3G", hours:24)
            browsingGroup.usages.addObject(browsing3G);
            standby = Usage(name:"Standby", hours:300)
        case "iPhone 4":
            audio = Usage(name:"Audio", hours:24)
            video = Usage(name:"Video", hours:7)
            talk2G = Usage(name:"2G", hours:8)
            talk3G = Usage(name:"3G", hours:8)
            browsing3G = Usage(name:"3G", hours:6)
            browsingWIFI = Usage(name:"WIFI", hours:9)
            browsingGroup.usages.addObject(browsing3G);
            browsingGroup.usages.addObject(browsingWIFI);
            standby = Usage(name:"Standby", hours:300)
        case "iPhone 4S":
            audio = Usage(name:"Audio", hours:30)
            video = Usage(name:"Video", hours:7)
            talk2G = Usage(name:"2G", hours:8)
            talk3G = Usage(name:"3G", hours:8)
            browsing3G = Usage(name:"3G", hours:6)
            browsingWIFI = Usage(name:"WIFI", hours:9)
            browsingLET = Usage(name:"LET", hours:9)
            browsingGroup.usages.addObject(browsing3G);
            browsingGroup.usages.addObject(browsingWIFI);
            browsingGroup.usages.addObject(browsingLET);
            standby = Usage(name:"Standby", hours:300)
        case "iPhone 5":
            audio = Usage(name:"Audio", hours:30)
            video = Usage(name:"Video", hours:7)
            talk2G = Usage(name:"2G", hours:8)
            talk3G = Usage(name:"3G", hours:8)
            browsing3G = Usage(name:"3G", hours:6)
            browsingWIFI = Usage(name:"WIFI", hours:9)
            browsingLET = Usage(name:"LET", hours:9)
            browsingGroup.usages.addObject(browsing3G);
            browsingGroup.usages.addObject(browsingWIFI);
            browsingGroup.usages.addObject(browsingLET);
            standby = Usage(name:"Standby", hours:300)
        case "iPhone 5C":
            audio = Usage(name:"Audio", hours:40)
            video = Usage(name:"Video", hours:7)
            talk2G = Usage(name:"2G", hours:8)
            talk3G = Usage(name:"3G", hours:8)
            browsing3G = Usage(name:"3G", hours:6)
            browsingWIFI = Usage(name:"WIFI", hours:9)
            browsingLET = Usage(name:"LET", hours:9)
            browsingGroup.usages.addObject(browsing3G);
            browsingGroup.usages.addObject(browsingWIFI);
            browsingGroup.usages.addObject(browsingLET);
            standby = Usage(name:"Standby", hours:225)
        case "iPhone 5S":
            audio = Usage(name:"Audio", hours:40)
            video = Usage(name:"Video", hours:7)
            talk2G = Usage(name:"2G", hours:8)
            talk3G = Usage(name:"3G", hours:8)
            browsing3G = Usage(name:"3G", hours:6)
            browsingWIFI = Usage(name:"WIFI", hours:9)
            browsingLET = Usage(name:"LET", hours:9)
            standby = Usage(name:"Standby", hours:250)
        case "iPhone 6":
            audio = Usage(name:"Audio", hours:24)
            video = Usage(name:"Video", hours:7)
            talk2G = Usage(name:"2G", hours:8)
            talk3G = Usage(name:"3G", hours:8)
            browsing3G = Usage(name:"3G", hours:6)
            browsingWIFI = Usage(name:"WIFI", hours:9)
            browsingLET = Usage(name:"LET", hours:9)
            browsingGroup.usages.addObject(browsing3G);
            browsingGroup.usages.addObject(browsingWIFI);
            browsingGroup.usages.addObject(browsingLET);
            
            standby = Usage(name:"Standby", hours:250)
        case "iPhone 6 Plus":
            audio = Usage(name:"Audio", hours:24)
            video = Usage(name:"Video", hours:7)
            talk2G = Usage(name:"2G", hours:8)
            talk3G = Usage(name:"3G", hours:8)
            browsing3G = Usage(name:"3G", hours:12)
            browsingWIFI = Usage(name:"WIFI", hours:12)
            browsingLET = Usage(name:"LET", hours:12)
            browsingGroup.usages.addObject(browsing3G);
            browsingGroup.usages.addObject(browsingWIFI);
            browsingGroup.usages.addObject(browsingLET);
            standby = Usage(name:"Standby", hours:384)
//        case "iPad 2": audio = 24;video=7;talkOver2G=8;browsing3G=6;standby=250
//        case "iPad 3": audio = 24;video=7;talkOver2G=8;browsing3G=6;standby=250
//        case "iPad 4": audio = 24;video=7;talkOver2G=8;browsing3G=6;standby=250
//        case "iPad Air": audio = 24;video=7;talkOver2G=8;browsing3G=6;standby=250
//        case "iPad Air 2": audio = 24;video=7;talkOver2G=8;browsing3G=6;standby=250
//        case "iPad Mini 2": audio = 24;video=7;talkOver2G=8;browsing3G=6;standby=250
//        case "iPad Mini 3": audio = 24;video=7;talkOver2G=8;browsing3G=6;standby=250
//        case "Simulator": audio = 24;video=7;talkOver2G=8;talkOver3G=8;browsing3G=12;browsingWIFI=12;browsingLTE=12;standby=384
        case "Simulator":
            audio = Usage(name:"Audio", hours:24)
            video = Usage(name:"Video", hours:7)
            talk2G = Usage(name:"2G", hours:8)
            talk3G = Usage(name:"3G", hours:8)
            browsing3G = Usage(name:"3G", hours:12)
            browsingWIFI = Usage(name:"WIFI", hours:12)
            browsingLET = Usage(name:"LET", hours:12)
            browsingGroup.usages.addObject(browsing3G);
            browsingGroup.usages.addObject(browsingWIFI);
            browsingGroup.usages.addObject(browsingLET);
            standby = Usage(name:"Standby", hours:384)
        default: println("Error !!!")
        }
        multiMediaGroup.name = "Multimedia"
        multiMediaGroup.usages.addObject(audio)
        multiMediaGroup.usages.addObject(video)
        
        talkTimeGroup.name = "Talk Time"
        talkTimeGroup.usages.addObject(talk2G)
        talkTimeGroup.usages.addObject(talk3G)
        talkTimeGroup.useGroup=0
        
        browsingGroup.name = "Browsing"
        browsingGroup.useGroup=0
        othersGroup.name = "Others"
        othersGroup.useGroup = 0;
        othersGroup.usages.addObject(standby);
        
        usageGroups.groups.addObject(multiMediaGroup)
        usageGroups.groups.addObject(talkTimeGroup)
        usageGroups.groups.addObject(browsingGroup)
        usageGroups.groups.addObject(othersGroup)
        return usageGroups
    }
}
