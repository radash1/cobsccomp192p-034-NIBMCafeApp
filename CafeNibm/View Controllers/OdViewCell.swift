//
//  OdViewCell.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 4/29/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit

class OdViewCell: UITableViewCell {

    @IBOutlet weak var foodtxt: UILabel!
    @IBOutlet weak var namtxt: UILabel!
    @IBOutlet weak var prctxt: UILabel!
    @IBOutlet weak var stattxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
