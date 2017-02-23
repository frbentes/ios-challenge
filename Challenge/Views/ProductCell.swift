//
//  ProductCell.swift
//  Challenge
//
//  Created by Fredyson Costa Marques Bentes on 21/07/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet var imgPhoto: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
