//
//  BreweriesAPI.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/29/16.
//  Copyright © 2016 BG. All rights reserved.
//

import Foundation
import QuadratTouch
import MapKit
import RealmSwift

struct API {
    struct notifications {
        static let venuesUpdated = "venues updated"
    }
}

class BreweriesAPI {
    
    static let sharedInstance = BreweriesAPI()
    var session: Session?
    
    let clientID = valueForAPIKey(keyname: "API_Client_ID")
    let clientSec = valueForAPIKey(keyname: "API_Client_Secret")
    
    init() {
        // Initialize API
        let client = Client(clientID: clientID, clientSecret: clientSec, redirectURL: "")
        
        let configuration = Configuration(client: client)
        Session.setupSharedSessionWithConfiguration(configuration)
        
        self.session = Session.sharedSession()
    }

    func getBreweriesWithLocation(location:CLLocation) {

        if let session = self.session {
            
            var parameters = location.parameters()
            parameters += [Parameter.categoryId: "50327c8591d4c4b30a586d5d"]
          //  parameters += [Parameter.radius: "5000"] // If a radius is not specified, a suggested search radius will be provided optimized based on the density of the venues in the location 
            parameters += [Parameter.limit: "25"]
            
            // Start an async call to Foursquare
            let searchTask = session.venues.search(parameters) {
                
                    (result) -> Void in
                    
                    if let response = result.response {
                        
                        if let venues = response["venues"] as? [[String: AnyObject]] {
                            
                            autoreleasepool {
                                
                                    let realm = try! Realm()
                                    realm.beginWrite()
                                    
                                    for venue:[String: AnyObject] in venues {
                                        
                                        let venueObject:Venue = Venue()
                                        
                                        if let id = venue["id"] as? String {
                                            
                                            venueObject.id = id }
                                        
                                        if let name = venue["name"] as? String {
                                            
                                            venueObject.name = name
                                        }
                                        
                                        if  let location = venue["location"] as? [String: AnyObject] {
                                            
                                            if let longitude = location["lng"] as? Float {
                                                
                                                venueObject.longitude = longitude
                                            }
                                            
                                            if let latitude = location["lat"] as? Float {
                                                
                                                venueObject.latitude = latitude
                                            }
                                            
                                            if let formattedAddress = location["formattedAddress"] as? [String] {
                                                
                                                venueObject.address = formattedAddress.joinWithSeparator(" ")
                                            }
                                        }
                                        
                                        realm.add(venueObject, update: true)
                                    }
                                    
                                    do {
                                        
                                        try realm.commitWrite()
                                        print("Committing write...")
                                    }
                                    catch (let e) {
                                        
                                        print("Realm doesn't like it... \(e)")
                                    }
                            }
                            
                            NSNotificationCenter.defaultCenter().postNotificationName(API.notifications.venuesUpdated, object: nil, userInfo: nil)
                        }
                    }
            }
            
            searchTask.start()
        }
    }
}

extension CLLocation {
    
    func parameters() -> Parameters {
        
        let ll      = "\(self.coordinate.latitude),\(self.coordinate.longitude)"
        let llAcc   = "\(self.horizontalAccuracy)"
        let alt     = "\(self.altitude)"
        let altAcc  = "\(self.verticalAccuracy)"
        let parameters = [
            Parameter.ll:ll,
            Parameter.llAcc:llAcc,
            Parameter.alt:alt,
            Parameter.altAcc:altAcc
        ]
        
        return parameters
    }
}

