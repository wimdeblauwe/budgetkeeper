//
//  BudgetItemTableViewCell.swift
//  BudgetKeeper
//
//  Created by Wim Deblauwe on 02/05/16.
//  Copyright © 2016 Wim Deblauwe. All rights reserved.
//

import UIKit

class BudgetItemTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
