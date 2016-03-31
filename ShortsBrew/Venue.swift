//
//  Venue.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/30/16.
//  Copyright © 2016 BG. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

class Venue: Object {
    
    dynamic var id: String = ""
    dynamic var name: String = ""
    
    dynamic var latitude: Float = 0
    dynamic var longitude: Float = 0
    
    dynamic var address: String = ""
    
    var coordintae: CLLocation {
        
        return CLLocation(latitude: Double(latitude), longitude: Double(longitude))
    }

    override static func primaryKey() -> String {

        return "id"
    }



}
