//
//  MojioClientEnvironment.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-21.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit

public enum MojioRegion : String {
    case Production = ""
    case NAProduction = "na-production-"
    case EUProduction = "eu-production-"
    case Staging = "staging-"
    case NAStaging = "na-staging-"
    case EUStaging = "eu-staging-"
    case Trial = "trial-"

    static func getDefaultRegion() -> MojioRegion {
        return Production
    }
}

public class MojioClientEnvironment : NSObject {
    
    private static let ApiEndpointFormat : String = "https://%@api.moj.io/v2/"
    private static let PushEndpointFormat : String = "https://%@push.moj.io/v2/"
    private static let MyMojioEndpointFormat : String = "https://%@my.moj.io/"
    private static let AccountsEndpointFormat : String = "https://%@accounts.moj.io/"
    
    public static let sharedInstance = MojioClientEnvironment()
    
    private var region : String?
    
    private var apiEndpoint : String?
    private var pushEndpoint : String?
    private var myMojioEndpoint : String?
    private var accountsEndpoint : String?
    
    public override init() {
        super.init()

        if self.region == nil {
            self.setDefaultRegion()
        }
    }
    
    public func getRegion() -> MojioRegion {
        if self.region != nil {
            return MojioRegion.init(rawValue: self.region!)!
        }

        return MojioRegion.getDefaultRegion()
    }
    
    /**
        Letting an app developer ovveride the default environment. This should be used only for development purposes to test the functionality of the app in different continents
     */
    public func setRegion (region : MojioRegion) {
        self.region = region.rawValue
        self.apiEndpoint = String.init(format: MojioClientEnvironment.ApiEndpointFormat, arguments: [region.rawValue])
        self.pushEndpoint = String.init(format: MojioClientEnvironment.PushEndpointFormat, arguments: [region.rawValue])
        self.myMojioEndpoint = String.init(format: MojioClientEnvironment.MyMojioEndpointFormat, arguments: [region.rawValue])
        self.accountsEndpoint = String.init(format: MojioClientEnvironment.AccountsEndpointFormat, arguments: [region.rawValue])
    }
    
    public func setDefaultRegion () {
        self.setRegion(MojioRegion.getDefaultRegion())
    }
    
    public func getApiEndpoint () -> String {
        return apiEndpoint!
    }
    
    public func getPushEndpoint () -> String {
        return pushEndpoint!
    }
    
    public func getMyMojioEndpoint () -> String {
        return myMojioEndpoint!
    }
    
    public func getAccountsEndpoint () -> String {
        return accountsEndpoint!
    }
}
