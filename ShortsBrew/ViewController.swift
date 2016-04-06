//
//  ViewController.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 2/15/16.
//  Copyright © 2016 BG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var tapsBtn: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    // Properties
    var breweryFromSegue: Venue?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moreBtn.layer.cornerRadius = 5.0
        tapsBtn.layer.cornerRadius = 5.0
    
        
        if let breweryName = breweryFromSegue?.name {
            self.addressLabel.text = breweryName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindForSegue(segue: UIStoryboardSegue) {
        
    }
    
}

