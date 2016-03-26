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
    
    @IBOutlet weak var abvLbl: UILabel!
    
    @IBOutlet weak var beerStyleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(image: UIImage, beerName: String, abv: String, beerStyle: String) {
        
        beerImg.image = image
        beerLbl.text = beerName
        abvLbl.text = abv
        beerStyleLbl.text = beerStyle
        
    }
    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    
    
}
