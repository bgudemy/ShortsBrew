//
//  HomeViewController.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/29/16.
//  Copyright © 2016 BG. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //Outlets
    @IBOutlet var mapView: MKMapView?

    
    //Properties
    var locationManager: CLLocationManager?
    var distanceSpan: Double = 500
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let mapView = self.mapView {
            
            mapView.delegate = self
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        if let mapView = self.mapView {
            
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, distanceSpan, distanceSpan)
            mapView.setRegion(region, animated: true)
        }
    }
        
    
    override func viewDidAppear(animated: Bool) {
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager!.requestAlwaysAuthorization()
            locationManager!.distanceFilter = 50 // doesn't send location updates until this distance has been reached
            locationManager!.startUpdatingLocation()
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
