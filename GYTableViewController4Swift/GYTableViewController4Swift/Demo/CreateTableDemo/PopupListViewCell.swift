//
//  PopupListViewCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/7.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class PopupListViewCell: GYTableViewCell {

    override func showSubviews() {
        let cellData:String? = self.getData() as? String
        self.textLabel?.font = UIFont.systemFont(ofSize: 15)
        self.textLabel?.text = cellData
        self.textLabel?.sizeToFit()
        self.textLabel?.x = 15
        self.textLabel?.centerY = self.contentView.height / 2.0
        self.textLabel?.textColor = self.tableView.tintColor
    }
    
    override func showSelectionStyle() -> Bool {
        return true
    }

}
