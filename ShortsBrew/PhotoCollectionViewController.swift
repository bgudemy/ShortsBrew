//
//  PhotoCollectionViewController.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/20/16.
//  Copyright © 2016 BG. All rights reserved.
//

import UIKit
import Social

private let reuseIdentifier = "PhotoCollectionCell"

class PhotoCollectionViewController: UICollectionViewController {
    
    var photos = ["Shorts-Brewing-3", "Shorts-Brewing-2", "shorts-10-yr", "pub", "taps", "Shorts-Brewing"]
    
    // Sharing feature properties
    var shareEnabled = false
    var selectedToShare: [String] = []

    @IBOutlet var shareBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
  //May need to remove this line
  //      self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "showPhoto" {
            if shareEnabled {
                return false
            }
        }
        
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showPhoto" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems() {
                let destinationViewController = segue.destinationViewController as! UINavigationController
                let photoVC = destinationViewController.viewControllers[0] as! PhotosViewController
                photoVC.imageFromCollection = photos[indexPaths[0].row]
                
                print("\(photoVC.imageFromCollection)")
                print("just before segue")
                
                collectionView?.deselectItemAtIndexPath(indexPaths[0], animated: false)
            }
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
    
        // Configure the cell
        cell.photoImageView.image = UIImage(named: photos[indexPath.row])
      //  cell.selectedBackgroundView = UIColor.blueColor()
        
        return cell
    }
    
    @IBAction func unwindForSegue(segue: UIStoryboardSegue) {
    }
    
    @IBAction func shareBtnPressed(sender: AnyObject) {
        
        if shareEnabled {
            
            // Post selected photos to Facebook
            if selectedToShare.count > 0 {
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                    let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    facebookComposer.setInitialText("Check out this brewery")
                    
                    for photo in selectedToShare {
                        facebookComposer.addImage(UIImage(named: photo))
                    }
                    
                    presentViewController(facebookComposer, animated: true, completion: nil)
                    
                }
            }
            
            // Deselect all selected items
            for indexPath in (collectionView?.indexPathsForSelectedItems())! as [NSIndexPath] {
                collectionView?.deselectItemAtIndexPath(indexPath, animated: false)
            }
            
            // remove all items from selectedToShare array
            selectedToShare.removeAll(keepCapacity: true)
            
            // Change the sharing mode to NO
            shareEnabled = false
            collectionView?.allowsMultipleSelection = false
            shareBtn.title = "Share"
            shareBtn.style = UIBarButtonItemStyle.Plain
            
        } else {
            
            // change shareEnabled to YES and change the button text to upload
            shareEnabled = true
            collectionView?.allowsMultipleSelection = true
            shareBtn.title = "Upload"
            shareBtn.style = UIBarButtonItemStyle.Done
            
        }
        
    }
    
    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // check if the sharing mode is enabled, otherwise, just leave this method
        guard shareEnabled else {
            return
        }
        
        //Determine the selected items by using the indexPath
        let selectedPhotos = photos[indexPath.row]
        
        //Add the selected photos into the array
        selectedToShare.append(selectedPhotos)
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        // Check to see if sharing mode is enabled, if not, leave the method
        guard shareEnabled else {
            return
        }
        
        let deSelectedPhoto = photos[indexPath.row]
        if let index = photos.indexOf(deSelectedPhoto) {
            photos.removeAtIndex(index)
        }
    }
    
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
