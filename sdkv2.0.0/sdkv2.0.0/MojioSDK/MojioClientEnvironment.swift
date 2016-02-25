//
//  MojioClientEnvironment.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-21.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit

class MojioClientEnvironment {
    
    // making the SDK environment a singleton
    static let clientEnvironment = MojioClientEnvironment()
    
    private let ENDPOINT_PRODUCTION : String = "https://api.moj.io/v2/"
    private let ENDPOINT_PRODUCTION_EU : String = "https://cz-api.moj.io/v2/"
    private let ENDPOINT_STAGING : String = "https://staging-api.moj.io/v2/"
    private let ENDPOINT_DEVELOP : String = "http://develop-api.moj.io/v2/"
    
    // Endpoints for the push server
    private let ENDPOINT_PUSH_STAGING : String = "https://staging-push.moj.io/v2/"
    private let ENDPOINT_PUSH : String = "https://push.moj.io/v2/"

    private func isUserInEU () -> Bool {
        
        let euCountrySet : NSSet = NSSet(array: ["AL", "AD", "AM", "AT", "BY", "BE", "BA", "BG", "CH", "CY", "CZ", "DE",
            "DK", "EE", "ES", "FO", "FI", "FR", "GB", "GE", "GI", "GR", "HU", "HR",
            "IE", "IS", "IT", "LT", "LU", "LV", "MC", "MK", "MT", "NO", "NL", "PL",
            "PT", "RO", "RU", "SE", "SI", "SK", "SM", "TR", "UA", "VA"])
        
        let currentLocale : NSLocale = NSLocale.currentLocale()
        let countryCode = currentLocale.objectForKey(NSLocaleCountryCode) as! String
        
        if euCountrySet.containsObject(countryCode) {
            return true
        }
    
        return false
    }
    
    func apiEndpoint () -> String {
//        if self.isUserInEU() {
//            return self.ENDPOINT_PRODUCTION_EU
//        }
//        else {
//            return self.ENDPOINT_PRODUCTION
//        }
        return self.ENDPOINT_STAGING
    }
    
    func pushEndpoint () -> String {
        return self.ENDPOINT_PUSH_STAGING
    }
}
