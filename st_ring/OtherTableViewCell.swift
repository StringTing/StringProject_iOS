//
//  OtherTableViewCell.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 10. 16..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class OtherTableViewCell: UITableViewCell {
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var messageImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
