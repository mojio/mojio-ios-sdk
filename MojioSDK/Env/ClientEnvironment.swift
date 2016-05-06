//
//  ClientEnvironment.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-21.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit

public class MojioRegion : NSObject {
    public static let Production : String = ""
    public static let NAProduction : String = "na-production-"
    public static let EUProduction : String = "eu-production-"
    public static let Staging : String = "staging-"
    public static let NAStaging : String = "na-staging-"
    public static let EUStaging : String = "eu-staging-"
    public static let Trial : String = "trial-"
    public static let Develop : String = "develop-"

    static func getDefaultRegion() -> String {
        return Production
    }
}

public class ClientEnvironment : NSObject {
    
    private static let ApiEndpointFormat : String = "https://%@api.moj.io/v2/"
    private static let PushEndpointFormat : String = "https://%@push.moj.io/v2/"
    private static let MyMojioEndpointFormat : String = "https://%@my.moj.io/"
    private static let AccountsEndpointFormat : String = "https://%@accounts.moj.io/"
    
    public static let SharedInstance = ClientEnvironment()
    
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
    
    public func getRegion() -> String {
        if self.region != nil {
            return self.region!
        }

        return MojioRegion.getDefaultRegion()
    }
    
    /**
        Letting an app developer ovveride the default environment. This should be used only for development purposes to test the functionality of the app in different continents
     */
    public func setRegion (region : String) {
        self.region = region
        self.apiEndpoint = String.init(format: ClientEnvironment.ApiEndpointFormat, arguments: [region])
        self.pushEndpoint = String.init(format: ClientEnvironment.PushEndpointFormat, arguments: [region])
        self.myMojioEndpoint = String.init(format: ClientEnvironment.MyMojioEndpointFormat, arguments: [region])
        self.accountsEndpoint = String.init(format: ClientEnvironment.AccountsEndpointFormat, arguments: [region])
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
