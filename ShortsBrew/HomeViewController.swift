//
//  HomeViewController.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/29/16.
//  Copyright © 2016 BG. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let mapView = self.mapView {
            
            mapView.delegate = self
        }

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
