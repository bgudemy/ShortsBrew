//
//  BeerDetailViewController.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/12/16.
//  Copyright © 2016 BG. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    @IBOutlet weak var beerLabel: UILabel!
    
    @IBOutlet weak var beerImage: UIImageView!
    
    var beerFromSegue: String?
    var beerImageFromSegue: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.beerLabel.text = self.beerFromSegue
        self.beerImage.image = self.beerImageFromSegue
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func donePressed(sender: AnyObject) {
//        
//        dismissViewControllerAnimated(true, completion: nil)
//    }    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
