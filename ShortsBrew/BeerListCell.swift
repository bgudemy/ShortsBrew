//
//  BeerListCell.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/14/16.
//  Copyright © 2016 BG. All rights reserved.
//

import UIKit

class BeerListCell: UITableViewCell {

    @IBOutlet weak var beerImg: UIImageView!
    
    @IBOutlet weak var beerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(image: UIImage, beerName: String) {
        
        beerImg.image = image
        beerLbl.text = beerName
    }
    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    
    
}
