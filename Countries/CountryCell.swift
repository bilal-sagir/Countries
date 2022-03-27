//
//  CountryCell.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import UIKit

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var FavButton: UIButton!
    var buttonPressed : (() -> ()) = {}

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favButonTapped(_ sender: UIButton) {
        buttonPressed()
    }
}
