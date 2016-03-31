//
//  BreweriesAnnotation.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/30/16.
//  Copyright © 2016 BG. All rights reserved.
//

import Foundation
import MapKit

class BreweryAnnotation: NSObject, MKAnnotation {
    
    let title:String?
    let subtitle:String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle:String?, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}