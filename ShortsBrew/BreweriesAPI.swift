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
}

extension CLLocation {
    
    func parameters() -> Parameters
    {
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

