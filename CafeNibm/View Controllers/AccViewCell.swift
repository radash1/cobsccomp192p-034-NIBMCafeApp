//
//  AccViewCell.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 4/29/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit

class AccViewCell: UITableViewCell {
    @IBOutlet weak var namtxt: UILabel!
    @IBOutlet weak var pricetxt: UILabel!
    @IBOutlet weak var datetxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
