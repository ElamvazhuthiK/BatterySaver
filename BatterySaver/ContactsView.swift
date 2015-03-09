//
//  ContactsView.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 02/03/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit

class ContactsView: UIView {

    var contactsDelegate:ContactsViewDelegate?
    let contactsTable:UITableView=UITableView()
    let searchTextField:UISearchBar=UISearchBar()
    
    
    
    override init(frame:CGRect)
    {
        super.init(frame:frame);
        
        // Set Layout
        self.backgroundColor=UIColor.whiteColor()
        self.addSubview(contactsTable);
        self.addSubview(searchTextField)
        self.configureViews();
        
    
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }


    func configureViews()
    {
        self.contactsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "contactstable")
        self.contactsTable.allowsMultipleSelection=true
        self.setLayoutForViews()
    }

    func setLayoutForViews()
    {
        var marginX:CGFloat=20
        var marginY:CGFloat=64
        var widthMinusMargin:CGFloat=self.frame.size.width-(2*marginX)
        self.searchTextField.frame=CGRectMake(0, marginY, self.frame.size.width, 40)
        self.contactsTable.frame=CGRectMake(0, marginY-10,self.frame.size.width
            ,self.frame.size.height-(marginY) )
        
    }
    
    func loadData()
    {
        searchTextField.delegate=self.contactsDelegate?
        contactsTable.delegate=self.contactsDelegate?
        contactsTable.dataSource=self.contactsDelegate?
        contactsTable.reloadData()
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
