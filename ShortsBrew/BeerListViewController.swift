//
//  BeerListViewController.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/11/16.
//  Copyright © 2016 BG. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet var tableView: UITableView!
    
    var beers: [String] = ["Alien Einstein", "MMMKAY", "Ermagerdness", "Superfluid", "Locals", "Bim-Bam-Boom"]
    
    var abv: [String] = ["5.6%","6.7%","4.7%","7.7%","3.5%","5.2%" ]
    
    var beerStyle = ["India Pale Ale", "Special Alien Technology", "Stout", "Porter", "American Lager", "Chocolate Stout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return beers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Need to create the cell as UITableViewCell or custom TableViewCell
        if let cell = tableView.dequeueReusableCellWithIdentifier("BeerListCell") as? BeerListCell {
            
            var img: UIImage!
            
            if let beerImg = UIImage(named: "\(beers[indexPath.row])") {
            
                img = beerImg
            } else {
                
                img = UIImage(named: "Placeholder")
            }
            
            cell.configureCell(img, beerName: "\(beers[indexPath.row])", abv: "\(abv[indexPath.row])", beerStyle: beerStyle[indexPath.row])
            
            return cell
        } else {
         
            return BeerListCell()
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("showBeerDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     //   print("\(self.tableView.indexPathForSelectedRow!) was selected ")
        
        if (segue.identifier == "showBeerDetailSegue") {
            
            var nextView: BeerDetailViewController = segue.destinationViewController as! BeerDetailViewController
    
            if let indexPath = self.tableView.indexPathForSelectedRow {
            
                let nameOfBeerSelected = self.beers[indexPath.row]
                let beerImageSelected = UIImage(named: "\(beers[indexPath.row])")
                
                nextView.beerFromSegue = nameOfBeerSelected
                nextView.beerImageFromSegue = beerImageSelected

                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)

            }
        }
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindForSegue(segue: UIStoryboardSegue) {
    }
    
    
}














