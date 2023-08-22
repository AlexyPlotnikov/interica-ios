//
//  CheckboxCell.swift
//  Interica
//
//  Created by RX Group on 25.10.2022.
//

import UIKit

class CheckboxCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    var select = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
