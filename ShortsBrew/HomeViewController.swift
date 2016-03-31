//
//  HomeViewController.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/29/16.
//  Copyright © 2016 BG. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //Outlets
    @IBOutlet var mapView: MKMapView?

    
//Properties
    var locationManager: CLLocationManager?
    var distanceSpan: Double = 500
    
    var lastLocation: CLLocation?
    var venues: [Venue]?
    
    // testing api
    let clientID = valueForAPIKey(keyname: "API_Client_ID")
    let clientSecret = valueForAPIKey(keyname: "API_Client_Secret")

//
    override func viewDidLoad() {
        super.viewDidLoad()

        if let mapView = self.mapView {
            
            mapView.delegate = self
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("onVenuesUpdated:"), name: API.notifications.venuesUpdated, object: nil)
        
    }

//
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        if let mapView = self.mapView {
            
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, distanceSpan, distanceSpan)
            mapView.setRegion(region, animated: true)
            
            refreshVenues(newLocation, getDataFromFoursquare: true)
        }
    }
    
    func refreshVenues(location: CLLocation?, getDataFromFoursquare:Bool = false) {
        if location != nil {
            
            lastLocation = location
        }
        
        if let location = lastLocation {
            if getDataFromFoursquare == true {
                
                BreweriesAPI.sharedInstance.getBreweriesWithLocation(location)
            }
            
            let realm = try! Realm()
            
            venues = realm.objects(Venue)
            
            for venue in venues! {
                
                let annotation = BreweryAnnotation(title: venue.name, subtitle: venue.address, coordinate: CLLocationCoordinate2D(latitude: Double(venue.latitude), longitude: Double(venue.longitude)))
                
                mapView?.addAnnotation(annotation)
            }
        }
    }
    
    func onVenuesUpdated(notification:NSNotification) {
        
        refreshVenues(nil)
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

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        if annotation.isKindOfClass(MKUserLocation)
        {
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("annotationIdentifier")
        
        if view == nil
        {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationIdentifier")
        }
        
        view?.canShowCallout = true
        
        return view
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
