//
//  TransactionTableCell.swift
//  Bud
//
//  Created by Ke Ma on 01/09/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import UIKit

class TransactionTableCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.backgroundColor = UIColor.init(red: 248/255, green: 129/255, blue: 129/255, alpha: 1)
        } else {
            self.backgroundColor = .none
        }
    }

}
