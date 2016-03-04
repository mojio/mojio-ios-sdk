//
//  MojioClientEnvironment.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-21.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit

enum Environment {
    case AMERICA_PRODUCTION
    case AMERICA_STAGING
    case AMERICA_DEVELOP
    case EU_PRODUCTION
}

class MojioClientEnvironment {
    
    static let clientEnvironment = MojioClientEnvironment()
    
    private var environment : Environment?
    
    private let ENDPOINT_PRODUCTION : String = "https://api.moj.io/v2/"
    private let ENDPOINT_PRODUCTION_EU : String = "https://cz-api.moj.io/v2/"
    private let ENDPOINT_STAGING : String = "https://staging-api.moj.io/v2/"
    private let ENDPOINT_DEVELOP : String = "http://develop-api.moj.io/v2/"
    
    // Endpoints for the push server
    private let ENDPOINT_PUSH_STAGING : String = "https://staging-push.moj.io/v2/"
    private let ENDPOINT_PUSH : String = "https://push.moj.io/v2/"
    
    // Endpoints for My Mojio
    private let MY_MOJIO_STAGING : String = "https://staging-my.moj.io/"
    private let MY_MOJIO_PRODUCTION : String = "https://my.moj.io/"
    
    //Endpoints for the push server
    private let PUSH_PRODUCTION : String = "https://push.moj.io"
    private let PUSH_STAGING : String = "https://staging-push.moj.io"
    
    // Endpoints for accounts
    private let ACCOUNTS_PRODUCTION : String = ""
    private let ACCOUNTS_STAGING : String = ""
    private let ACCOUNTS_PRODUCTION_EU : String = ""
    
    
    private var apiEndpoint : String = ""
    private var pushEndpoint : String = ""
    private var myMojioEndpoint : String = ""
    private var accountsEndpoint : String = ""
    
    init () {
        if self.environment == nil {
            self.setDefaultEnvironment()
        }
    }

    /*
        The user is deemed to be in Europe if the locale of the device is set to one of the countries in the EU. Otherwise, the app will connect to the North American endpoint
    */
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
    
    func getEnvironment () -> Environment {
        if self.environment != nil {
            return self.environment!
        }
        return self.getDefaultEnvironment()
    }
    
    /**
        Letting an app developer ovveride the default environment. This should be used only for development purposes to test the functionality of the app in different continents
     */
    func setEnvironment (environment : Environment) {
        self.environment = environment
        
        switch environment {
            
        case Environment.AMERICA_PRODUCTION:
            self.apiEndpoint = self.ENDPOINT_PRODUCTION
            self.pushEndpoint = self.PUSH_PRODUCTION
            self.myMojioEndpoint = self.MY_MOJIO_PRODUCTION
            
        case Environment.AMERICA_STAGING:
            self.apiEndpoint = self.ENDPOINT_STAGING
            self.pushEndpoint = self.PUSH_STAGING
            self.myMojioEndpoint = self.MY_MOJIO_STAGING
        
        
        case Environment.AMERICA_DEVELOP:
            self.apiEndpoint = self.ENDPOINT_DEVELOP
        
        case Environment.EU_PRODUCTION:
            self.apiEndpoint = self.ENDPOINT_PRODUCTION_EU
        }
    }
    
    func getDefaultEnvironment () -> Environment {
        if self.isUserInEU () {
            return Environment.EU_PRODUCTION
        }
        else {
            return Environment.AMERICA_PRODUCTION
        }
    }
    
    func setDefaultEnvironment () {
        if self.isUserInEU() {
            self.setEnvironment(Environment.EU_PRODUCTION)
        }
        else {
            self.setEnvironment(Environment.AMERICA_PRODUCTION)
        }
    }
    
    func getApiEndpoint () -> String {
        let currentEnvironment : Environment = self.getEnvironment()
        switch currentEnvironment {
            
        case Environment.AMERICA_PRODUCTION:
            return self.ENDPOINT_PRODUCTION
        
        case Environment.AMERICA_STAGING:
            return self.ENDPOINT_STAGING
            
        case Environment.AMERICA_DEVELOP:
            return self.ENDPOINT_DEVELOP
            
        case Environment.EU_PRODUCTION:
            return ENDPOINT_PRODUCTION_EU
        }
    }
}