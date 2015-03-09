//
//  ViewController.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 28/02/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Battery"
       
        var settingsBtn:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        settingsBtn.frame=CGRectMake(20, 100, 100, 50)
        settingsBtn.addTarget(self, action: Selector("settingsClicked"), forControlEvents: UIControlEvents.TouchDown)
        settingsBtn.backgroundColor=UIColor.redColor();
        self.view.backgroundColor=UIColor.whiteColor()
        self.view.addSubview(settingsBtn);
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func settingsClicked(){
        let settingsViewController:SettingsViewController=SettingsViewController() as SettingsViewController;
        self.navigationController?.pushViewController(settingsViewController, animated: true);
        
    }

}

