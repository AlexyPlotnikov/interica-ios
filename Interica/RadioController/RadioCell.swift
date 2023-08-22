//
//  RadioCell.swift
//  Interica
//
//  Created by RX Group on 24.10.2022.
//

import UIKit

class RadioCell: UITableViewCell {

    @IBOutlet weak var radioImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
