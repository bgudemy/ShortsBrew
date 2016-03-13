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
    
    var beers: [String] = ["Noble Chaos", "MMMKay", "Ermergerden", "Cats Pajamamas", "Space Rock", "Huma Lupa Licious"]
    
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
        
        // Need to create the cell as UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("beer")! as UITableViewCell
   
        cell.textLabel?.text = self.beers[indexPath.row]
        
        return cell
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
                
                nextView.beerFromSegue = nameOfBeerSelected

                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)

            }
            
        }
        
    }
    
    
    
    
}














