//
//  ContactsViewController.swift
//  BatterySaver
//
//  Created by Saranya Sivanandham on 02/03/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit
import AddressBook


protocol ContactsViewDelegate:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate
{
    
}

class ContactsViewController: BaseViewController,ContactsViewDelegate {

    let addressBook: ABAddressBook=ABAddressBookCreateWithOptions(nil,nil).takeRetainedValue()
    var allContacts:Array<ABRecordRef>=Array<ABRecordRef>()
    var resultContacts:Array<ABRecordRef>=Array<ABRecordRef>()
//    lazy var appdelegate:AppDelegate=UIApplication.sharedApplication().delegate as AppDelegate
    
    
    override func loadView() {
        
        var frame=UIScreen.mainScreen().bounds
        var settingsView:ContactsView=ContactsView(frame: frame);
        settingsView.contactsDelegate=self;
        self.view=settingsView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Contacts"
        var source:ABRecordRef = ABAddressBookCopyDefaultSource(self.addressBook).takeRetainedValue()
        var allPeople:Array<ABRecordRef>=ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(self.addressBook,source,  ABPersonGetSortOrdering()).takeRetainedValue()
        var nPeople=ABAddressBookGetPersonCount(addressBook)
        allContacts=allPeople
        //resultContacts=allContacts
        self.getContactsWithPhoneNumbers()
        (self.view as ContactsView).loadData()
    }
    
    func getContactsWithPhoneNumbers()
    {
        self.resultContacts.removeAll(keepCapacity: false)
        for record  in self.allContacts
        {
            let phoneProperty=ABRecordCopyValue(record, kABPersonPhoneProperty)
            
            if let ab = phoneProperty {
                let phonePropertyValue:ABMultiValueRef=Unmanaged.fromOpaque(phoneProperty.toOpaque()).takeUnretainedValue() as ABMultiValueRef
                if ABMultiValueGetCount(phonePropertyValue)>0
                {
                    self.resultContacts.append(record)
                    
                }
                else
                {
                  
                }
            }
            else
            {
                
            }
        }
        self.allContacts=self.resultContacts
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return resultContacts.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier="contactstable"
        var tableviewCell:UITableViewCell?=tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? UITableViewCell
        
        if (tableviewCell == nil)
        {
            tableviewCell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
    
        var record:ABRecordRef=self.resultContacts[indexPath.row] as ABRecordRef
        let firstName=extractABEmailAddress(ABRecordCopyValue(record, kABPersonFirstNameProperty))
        tableviewCell?.textLabel.text=firstName
        tableviewCell?.textLabel.textColor=UIColor.blackColor()
        return tableviewCell!
    }
    
    func extractABEmailAddress (abEmailAddress: Unmanaged<AnyObject>!) -> String? {
        if let ab = abEmailAddress {
            return Unmanaged.fromOpaque(abEmailAddress.toOpaque()).takeUnretainedValue() as CFStringRef
        }
        return nil
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.selectedAddressBookContact(self.resultContacts[indexPath.row])
    }
    
    
    
    func selectedAddressBookContact(selectedContact:ABRecordRef)
    {
        if appdelegate.contactsArr.count > 0
        {
           
            let conIndex=(appdelegate.contactsArr).indexOfObject(selectedContact)
            if !(conIndex > (-1) && conIndex < appdelegate.contactsArr.count)
            {
                appdelegate.contactsArr.addObject(selectedContact)
                addContactToPhNumber(selectedContact)
                
            }
        }
        else
        {
            appdelegate.contactsArr.addObject(selectedContact)
            addContactToPhNumber(selectedContact)
        }
    }
    

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.text=""
        self.resultContacts=self.allContacts
        (self.view as ContactsView).contactsTable.reloadData()
        
    }
    
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
      if searchBar.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)>0
      {
          var searchStr:CFStringRef=searchBar.text as CFStringRef
        self.resultContacts=ABAddressBookCopyPeopleWithName(self.addressBook,searchStr).takeRetainedValue()
        (self.view as ContactsView).contactsTable.reloadData()
        }
    }
    
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        if searchBar.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)>0
        {
              var searchStr:CFStringRef=searchBar.text as CFStringRef
        self.resultContacts=ABAddressBookCopyPeopleWithName(self.addressBook, searchStr).takeRetainedValue()
        (self.view as ContactsView).contactsTable.reloadData()
        }
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)>0
        {
            var searchStr:CFStringRef=searchBar.text as CFStringRef
            self.resultContacts=ABAddressBookCopyPeopleWithName(self.addressBook,searchStr ).takeRetainedValue()
            (self.view as ContactsView).contactsTable.reloadData()
            
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
