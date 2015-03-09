//
//  ChargeCell.swift
//  ChargeStatus
//
//  Created by Elamvazhuthi Kannan on 04/03/15.
//  Copyright (c) 2015 Elamvazhuthi Kannan. All rights reserved.
//

import UIKit

class ChargeCell: UITableViewCell {
    
    var usageName: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        usageName = UILabel()
        usageName.backgroundColor = UIColor.greenColor()
        self.contentView.addSubview(usageName)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        usageName = UILabel(frame: CGRectMake(20, 10, self.bounds.size.width - 40, 25))
    }
}
