//
//  ClientEnvironment.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-21.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit

open class MojioRegion : NSObject {

    open static let Production : String = ""
    open static let NAProduction : String = "na-production-"
    open static let EUProduction : String = "eu-production-"
    open static let Staging : String = "staging-"
    open static let NAStaging : String = "na-staging-"
    open static let EUStaging : String = "eu-staging-"
    open static let Trial : String = "trial-"
    open static let Develop : String = "develop-"
    open static let Load : String = "load-"

    static func getDefaultRegion() -> String {
        return Production
    }
}

open class ClientEnvironment : NSObject {
    
    fileprivate static let ApiEndpointFormat : String = "https://%@api.moj.io/v2/"
    fileprivate static let ApiV1EndpointFormat : String = "https://%@api.moj.io/v1/"
    fileprivate static let PushApnsEndpointFormat : String = "https://%@push.moj.io/v2/"
    fileprivate static let PushWSEndpointFormat : String = "wss://%@api.moj.io/v2/"
    fileprivate static let MyMojioEndpointFormat : String = "https://%@my.moj.io/"
    fileprivate static let AccountsEndpointFormat : String = "https://%@accounts.moj.io/"
    
    open static let SharedInstance = ClientEnvironment()
    
    fileprivate var region : String?
    
    fileprivate var apiEndpoint : String?
    fileprivate var apiV1Endpoint : String?
    fileprivate var pushApnsEndpoint : String?
    fileprivate var pushWSEndpoint : String?
    fileprivate var myMojioEndpoint : String?
    fileprivate var accountsEndpoint : String?
    
    public override init() {
        super.init()

        if self.region == nil {
            self.setDefaultRegion()
        }
    }
    
    open func getRegion() -> String {
        if self.region != nil {
            return self.region!
        }

        return MojioRegion.getDefaultRegion()
    }
    
    /**
        Letting an app developer ovveride the default environment. This should be used only for development purposes to test the functionality of the app in different continents
     */
    open func setRegion (_ region : String) {
        self.region = region
        self.apiEndpoint = String.init(format: ClientEnvironment.ApiEndpointFormat, arguments: [region])
        self.apiV1Endpoint = String.init(format: ClientEnvironment.ApiV1EndpointFormat, arguments: [region])
        self.pushApnsEndpoint = String.init(format: ClientEnvironment.PushApnsEndpointFormat, arguments: [region])
        self.pushWSEndpoint = String.init(format: ClientEnvironment.PushWSEndpointFormat, arguments: [region])
        self.myMojioEndpoint = String.init(format: ClientEnvironment.MyMojioEndpointFormat, arguments: [region])
        self.accountsEndpoint = String.init(format: ClientEnvironment.AccountsEndpointFormat, arguments: [region])
    }
    
    open func setDefaultRegion () {
        self.setRegion(MojioRegion.getDefaultRegion())
    }
    
    open func getApiEndpoint () -> String {
        return apiEndpoint!
    }
    
    open func getV1ApiEndpoint () -> String {
        return apiV1Endpoint!
    }
    
    open func getPushApnsEndpoint () -> String {
        return pushApnsEndpoint!
    }
    
    open func getPushWSEndpoint () -> String {
        return pushWSEndpoint!
    }
    
    open func getMyMojioEndpoint () -> String {
        return myMojioEndpoint!
    }
    
    open func getAccountsEndpoint () -> String {
        return accountsEndpoint!
    }
}
