//
//  WebsiteCell.swift
//  KeyUnlock
//
//  Created by Refo Yudhanto on 5/2/20.
//  Copyright © 2020 Refo Yudhanto. All rights reserved.
//

import UIKit

class WebsiteCell: UITableViewCell {

    @IBOutlet weak var webPic: UIImageView!
    @IBOutlet weak var webName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
