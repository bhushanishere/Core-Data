//
//  EmployeeViewCell.swift
//  AlamofireDemo
//
//  Created by Bhushan  Borse on 04/01/20.
//  Copyright © 2020 Bhushan  Borse. All rights reserved.
//

import UIKit

class EmployeeViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel    : UILabel!
    @IBOutlet weak var idLabel      : UILabel!
    @IBOutlet weak var ageLable     : UILabel!
    @IBOutlet weak var salaryLable  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
