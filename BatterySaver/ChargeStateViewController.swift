//
//  ChargeStateViewController.swift
//  ChargeStatus
//
//  Created by Elamvazhuthi Kannan on 04/03/15.
//  Copyright (c) 2015 Elamvazhuthi Kannan. All rights reserved.
//

import UIKit

class ChargeStateViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource
{
    
    let lblInitTime: UILabel = UILabel()
    let lblTotalTime: UILabel = UILabel()
    let lblUsageTime: UILabel = UILabel()
    
    let slider: UISlider = UISlider()
    
    let tableViewStatus:UITableView=UITableView(frame:CGRectZero, style: UITableViewStyle.Grouped);
    
    var batteryLife:BatteryLife = BatteryLife()
    
    var usageGroups:UsageGroups = UsageGroups()
    
    var batterLvlIndicator:UIView = UIView();
    
    var displayBatPer:UILabel = UILabel();
    
    var infoView:UIView = UIView();
    
    var backgroundView:UIView = UIView();
    
    var brightnessView:BrightnessManager = BrightnessManager(frame: CGRectMake(0, 20, 20, 100))
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title="Battery"
        
        self.createView();
        
        usageGroups = batteryLife.getUsages()
        
        tableViewStatus.reloadData();
        setValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //User defined methods
    func createView()
    {
        self.view.backgroundColor=UIColor.whiteColor();
        
        let scrollView = UIScrollView(frame: CGRectMake(50, 160, self.view.bounds.size.width-100, 50))
        scrollView.backgroundColor=UIColor.clearColor()
        
        var imageView = UIImageView(frame: CGRectMake(5, 0, scrollView.frame.size.width-10, 50));
        var image = UIImage(named: "Button_Holder");
        imageView.image = image;
        scrollView.addSubview(imageView);

        var offset:Float=Float(scrollView.frame.size.width);
        
        var border:SettingFieldView=SettingFieldView(frame: CGRectMake(0, 0, self.view.frame.size.width, 40))
        border.fieldValue.hidden=true
        scrollView.addSubview(border)
        
        
        var brightnessBtn:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        brightnessBtn.frame=CGRectMake(15, 8, 35, 35)
        brightnessBtn.addTarget(self, action: Selector("brightnessBtnClicked"), forControlEvents: UIControlEvents.TouchDown)
      
        brightnessBtn.setTitle("🔦", forState: UIControlState.Selected)
        brightnessBtn.setTitle("🔦", forState: UIControlState.Application)
        brightnessBtn.setTitle("🔦", forState: UIControlState.Normal)
        setTitleColorForButton(brightnessBtn)
        brightnessBtn.titleLabel?.font=UIFont(name: "HelveticaNeue-Bold", size: 20)
        scrollView.addSubview(brightnessBtn);
        
//        var infoBtn:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        infoBtn.frame=CGRectMake(CGFloat(offset/2)-17, 8, 35, 35)
//        infoBtn.addTarget(self, action: Selector("brightnessBtnClicked"), forControlEvents: UIControlEvents.TouchDown)
//        infoBtn.setImage(UIImage(named: "configure"), forState: UIControlState.Selected)
//        infoBtn.setImage(UIImage(named: "configure"), forState: UIControlState.Application)
//        infoBtn.setImage(UIImage(named: "configure"), forState: UIControlState.Normal)
//        scrollView.addSubview(infoBtn);

        var settingsBtn:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        settingsBtn.frame=CGRectMake(CGFloat(offset-50), 8, 35, 35)
        settingsBtn.addTarget(self, action: Selector("settingsClicked"), forControlEvents: UIControlEvents.TouchDown)
        settingsBtn.setImage(UIImage(named: "configure"), forState: UIControlState.Selected)
        settingsBtn.setImage(UIImage(named: "configure"), forState: UIControlState.Application)
        settingsBtn.setImage(UIImage(named: "configure"), forState: UIControlState.Normal)
        scrollView.addSubview(settingsBtn);

        lblInitTime.frame = CGRectMake(10, 240, (self.view.bounds.size.width - 20)/2, 25)
        lblInitTime.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        lblInitTime.text = "0"
        
        lblTotalTime.frame = CGRectMake(10 + (self.view.bounds.size.width - 10)/2, 240, (self.view.bounds.size.width - 20)/2, 25)
        lblTotalTime.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        lblTotalTime.textAlignment = NSTextAlignment.Right

        slider.frame = CGRectMake(10, 250, self.view.bounds.size.width - 20, 40)
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.value = 25.0
        slider.userInteractionEnabled = false;
        slider.backgroundColor=UIColor.whiteColor()
        let leftTrackImage = UIImage(named: "slider_blue_track")
        slider.setMinimumTrackImage(leftTrackImage, forState: .Normal)
        
        let rightTrackImage = UIImage(named: "slider_green_track")
        slider.setMaximumTrackImage(rightTrackImage, forState: .Normal)
        
        let thumbImage = UIImage(named: "slider_thumb")
        slider.setThumbImage(thumbImage, forState: .Normal)
        
        lblUsageTime.frame = CGRectMake(10, 220, (self.view.bounds.size.width - 20), 25)
        lblUsageTime.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        lblUsageTime.textColor=UIColor.blackColor()
        
        tableViewStatus.frame = CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height-250)
        tableViewStatus.dataSource = self
        tableViewStatus.delegate = self
        tableViewStatus.rowHeight = 40
        tableViewStatus.backgroundColor=UIColor.whiteColor()
        tableViewStatus.registerClass(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        
        self.view.addSubview(tableViewStatus)
        self.view.addSubview(slider)
        self.view.addSubview(lblInitTime)
        self.view.addSubview(lblTotalTime)
        self.view.addSubview(lblUsageTime)
        self.view.addSubview(scrollView)
        
        self.createBattry();
        self.createInfoView();
    }
    
    func createBattry()
    {
        batterLvlIndicator=UIView(frame: CGRectMake(25, 80, 0, 70));
        batterLvlIndicator.backgroundColor=GREENCOLOR
        batterLvlIndicator.layer.cornerRadius=5;
        self.view.addSubview(batterLvlIndicator);
        
        var maskLblUp=UILabel(frame: CGRectMake(185, 80, 20, 20));
        maskLblUp.backgroundColor=UIColor.whiteColor();
        self.view.addSubview(maskLblUp);
        
        var maskLbldown=UILabel(frame: CGRectMake(185, 130, 20, 20));
        maskLbldown.backgroundColor=UIColor.whiteColor();
        self.view.addSubview(maskLbldown);
        
        var batteryImage=UIImageView(frame: CGRectMake(10, 40, 200, 150));
        self.view.addSubview(batteryImage);

        displayBatPer=UILabel(frame: CGRectMake(self.view.frame.size.width-110, 80, 100, 70))
        displayBatPer.backgroundColor=UIColor.clearColor();
        displayBatPer.textAlignment=NSTextAlignment.Center;
        displayBatPer.font = UIFont (name: "HelveticaNeue-UltraLight", size: 40);
        self.view.addSubview(displayBatPer);
        
        var image=UIImage(named: "Battery_Normal");
        
        if(UIDevice.currentDevice().batteryState==UIDeviceBatteryState.Charging)
        {
            image=UIImage(named: "Battery_Charge");
        }

        batteryImage.image=image;

        UIDevice.currentDevice().batteryMonitoringEnabled = true;

        var batteryWidth:Float=(170/100.0)*(UIDevice.currentDevice().batteryLevel*100);
        
        self.setBatteryProgress(batteryWidth);
    }
    
    func createInfoView()
    {
        backgroundView=UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height));
        backgroundView.alpha=0;
        backgroundView.backgroundColor=UIColor.blackColor();
        self.view.addSubview(backgroundView);
        
        infoView=UIView(frame: CGRectMake(20, self.view.frame.size.height, self.view.frame.size.width-40,200));
        
        infoView.backgroundColor=UIColor.whiteColor();
        infoView.layer.cornerRadius=5;
        infoView.layer.shadowColor=UIColor.blackColor().CGColor;
        infoView.layer.shadowOffset=CGSize(width: 3, height: 3);
        infoView.layer.shadowOpacity=0.7;
        infoView.layer.shadowRadius = 6;
        self.view.addSubview(infoView);
        
        self.createBrightnessControlView();
        
        let closeBtn:UIButton = UIButton(frame: CGRectMake(infoView.frame.size.width-30, 0, 30, 30))
        closeBtn.backgroundColor = getPurpleColor()
        closeBtn.setTitle("✘", forState: UIControlState.Normal)
        closeBtn.titleLabel?.textAlignment=NSTextAlignment.Center;
        closeBtn.titleLabel?.font=UIFont(name: "Helvetical-Bold", size: 20);
        closeBtn.addTarget(self, action: "closeBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        infoView.addSubview(closeBtn);
    }
    
    func createBrightnessControlView()
    {
        brightnessView=BrightnessManager(frame: CGRectMake(0, 20, infoView.frame.size.width, 200));
        brightnessView.backgroundColor=UIColor.clearColor();
        infoView.addSubview(brightnessView);
    }
    
    func setBatteryProgress(progress:Float)
    {
        UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
            
            var batteryFrame = self.batterLvlIndicator.frame;
            
            batteryFrame.size.width = CGFloat(progress);
            
            self.batterLvlIndicator.frame = batteryFrame;
            
            self.displayBatPer.text=NSString(format:"%i%%",Int(UIDevice.currentDevice().batteryLevel*100));
            
            }, completion: {finished in
                println("Success!!")
        });
    }
    
    func setValues()
    {
        slider.maximumValue =  usageGroups.totalUsageMinuts()
        slider.value = usageGroups.usageMinutsPerBatteryLevel()
        lblTotalTime.text = "\(Int(slider.maximumValue)/60)h:\(Int(slider.maximumValue)%60)m"
        lblUsageTime.text = "Available Time \(Int(slider.value)/60)h:\(Int(slider.value)%60)m"
    }
//    table datasource methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return usageGroups.groups.count;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let usageGroup:UsageGroup = usageGroups.groups[section] as UsageGroup
        return usageGroup.usages.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let usageGroup:UsageGroup = usageGroups.groups[section] as UsageGroup
        return usageGroup.name;
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 20.0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView
    {
        var sectionView:UIView = UIView.init(frame:CGRectMake(0, 0, tableView.frame.size.width, 20))
        var lblTitle:UILabel = UILabel.init(frame:CGRectMake(5, 0, sectionView.bounds.size.width/2, sectionView.bounds.size.height))
        var btnUse:SectionButton = SectionButton.init(frame: CGRectMake(sectionView.bounds.size.width - 40, 0, 40, sectionView.bounds.size.height))
        btnUse.addTarget(self, action: Selector("sectionButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside);
        lblTitle.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        let usageGroup:UsageGroup = usageGroups.groups[section] as UsageGroup
        lblTitle.text = usageGroup.name
        btnUse.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnUse.setTitleColor(UIColor.blackColor(), forState: UIControlState.Selected)
        btnUse.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        btnUse.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        btnUse.titleLabel?.textAlignment = NSTextAlignment.Right
        btnUse.sectionIndex = section;
        btnUse.tableView = tableView;
        if usageGroup.useGroup == 0 {
            btnUse.setTitle("✘", forState: UIControlState.Normal)
            btnUse.setTitle("✘", forState: UIControlState.Highlighted)
            btnUse.setTitle("✘", forState: UIControlState.Selected)
        }else if usageGroup.useGroup == 1 {
            btnUse.setTitle("✔︎", forState: UIControlState.Normal)
            btnUse.setTitle("✔︎", forState: UIControlState.Highlighted)
            btnUse.setTitle("✔︎", forState: UIControlState.Selected)
        }else if usageGroup.useGroup == 2 {
            btnUse.setTitle("", forState: UIControlState.Normal)
            btnUse.setTitle("", forState: UIControlState.Highlighted)
            btnUse.setTitle("", forState: UIControlState.Selected)
        }
        sectionView.addSubview(lblTitle)
        sectionView.addSubview(btnUse)
        return sectionView
    }
    //    Target functions
    @objc func sectionButtonPressed(button:SectionButton!) {
        
        for index in 0...(usageGroups.groups.count - 1)
        {
            let usageGroup:UsageGroup = usageGroups.groups[index] as UsageGroup
            if usageGroup.useGroup == 1 {
                usageGroup.useGroup = 0
                button.tableView.reloadSections(NSIndexSet(index:index), withRowAnimation: UITableViewRowAnimation.Automatic);
            }
            usageGroup.useGroup = 0
        }
        
        let usageGroup:UsageGroup = usageGroups.groups[button.sectionIndex] as UsageGroup
        usageGroup.useGroup = 1;
        button.tableView.reloadSections(NSIndexSet(index:button.sectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic);
        setValues()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdendifier: String = "CustomCell"
        var cell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as CustomCell
        cell != CustomCell(style: .Default, reuseIdentifier: cellIdendifier)
        let usageGroup:UsageGroup = usageGroups.groups[indexPath.section] as UsageGroup
        let usage:Usage = usageGroup.usages[indexPath.row] as Usage
        cell.lblTitle.text = usage.name
        cell.lblTime.text = usage.timePerBatteryLevel() as NSString
        if usageGroup.useGroup == 0 {
            cell.userInteractionEnabled = false
            cell.lblUse.text = "◎"
        } else if usageGroup.useGroup == 1 {
            cell.userInteractionEnabled = true
            if usageGroup.use == indexPath.row
            {
                cell.lblUse.text = "◉"
            }else {
                cell.lblUse.text = "◎"
            }
        } else {
            cell.userInteractionEnabled = false
            cell.lblUse.text = ""
        }
        return cell
    }
//    table delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let usageGroup:UsageGroup = usageGroups.groups[indexPath.section] as UsageGroup
        usageGroup.use = indexPath.row
        tableView.reloadSections(NSIndexSet(index:indexPath.section), withRowAnimation: UITableViewRowAnimation.Automatic);
        setValues()
    }
    func settingsClicked(){
        let settingsViewController:SettingsViewController=SettingsViewController() as SettingsViewController;
        self.navigationController?.pushViewController(settingsViewController, animated: true);
        
    }
    
    func brightnessBtnClicked()
    {
        self.infoViewAnimation(1);
    }
    
    func closeBtnClicked()
    {
        self.infoViewAnimation(0);
    }
    
    func infoViewAnimation(mode:Int)
    {
        UIView.animateWithDuration(0.7, delay: 0, options: .CurveEaseOut, animations: {
            
            var infoFrame = self.infoView.frame;
            
            if(mode==0)
            {
                infoFrame.origin.y = self.view.frame.size.height
                self.backgroundView.alpha=0;
                self.brightnessView.switchOfFlashLight();
            }
            else
            {
                infoFrame.origin.y=self.view.frame.size.height/2-70
                self.backgroundView.alpha=0.3;
            }
            
            self.brightnessView.resetSliderValue();
            
            self.infoView.frame = infoFrame;
            
            }, completion: {finished in
                
                println("Success!!")
        });
    }

}

class CustomCell: UITableViewCell
{
    var lblTitle: UILabel = UILabel()
    var lblTime: UILabel = UILabel()
    var lblUse: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        lblTitle.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        lblTime.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        lblTime.textAlignment = NSTextAlignment.Right
        lblUse.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        lblUse.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(lblTitle)
        self.contentView.addSubview(lblTime)
        self.contentView.addSubview(lblUse)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        lblTitle.frame = CGRectMake(10, 0, 70, self.frame.size.height)
        lblTime.frame = CGRectMake(10 + 80, 0, 70, self.frame.size.height)
        lblUse.frame = CGRectMake(170, 0, self.frame.size.width - 180, self.frame.size.height)
    }
}

class SectionButton: UIButton {
    var sectionIndex:Int = 0
    var tableView:UITableView = UITableView()
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
}
