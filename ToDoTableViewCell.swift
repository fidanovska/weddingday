//
//  ToDoTableViewCell.swift
//  My Wedding Day
//
//  Created by Ivana Fidanovska on 12/23/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet var checkedImageView: UIImageView!
    @IBOutlet var taskLabel: UILabel!
    
    var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
