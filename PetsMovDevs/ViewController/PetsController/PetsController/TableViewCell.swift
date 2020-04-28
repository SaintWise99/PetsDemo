//
//  TableViewCell.swift
//  PetsMovDevs
//
//  Created by Jose David Bustos H on 25-04-20.
//  Copyright © 2020 Jose David Bustos H. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var LabelNamePet: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
