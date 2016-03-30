//
//  ApiKeys.swift
//  ShortsBrew
//
//  Created by Brian J Glowe on 3/29/16.
//  Copyright © 2016 BG. All rights reserved.
//

import Foundation

func valueForAPIKey(keyname keyname: String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)
    
    let value: String = plist?.objectForKey(keyname) as! String
    return value
}