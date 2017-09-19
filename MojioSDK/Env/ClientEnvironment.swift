/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2017 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import UIKit

public enum MojioRegion: String {

    case production = ""
    case naProduction = "na-production-"
    case euProduction = "eu-production-"
    case staging = "staging-"
    case naStaging = "na-staging-"
    case euStaging = "eu-staging-"
    case trial = "trial-"
    case develop = "develop-"
    case load = "load-"

    static func getDefaultRegion() -> MojioRegion {
        return .production
    }
}

open class ClientEnvironment {
    
    private enum EndPointFormat: String {
        case apiEndpoint = "https://%@eu-api-stagingslot.moj.io/v2/"
        case apiV1Endpoint = "https://%@eu-api-stagingslot.moj.io/v1/"
        case pushApnsEndpoint = "https://%@eu-push-stagingslot.moj.io/v2/"
        case pushWSEndpoint = "wss://%@eu-api-stagingslot.moj.io/v2/"
        case myMojioEndpoint = "https://%@my.moj.io/"
        case accountsEndpoint = "https://%@identity-stagingslot.moj.io/"
    }
    
    open static let SharedInstance = ClientEnvironment()
    
    fileprivate var region: MojioRegion? = nil
    
    fileprivate var apiEndpoint: String?
    fileprivate var apiV1Endpoint: String?
    fileprivate var pushApnsEndpoint: String?
    fileprivate var pushWSEndpoint: String?
    fileprivate var myMojioEndpoint: String?
    fileprivate var accountsEndpoint: String?
    
    public init() {
        guard let _ = self.region else {
            self.setDefaultRegion()
            return
        }
    }
    
    open func getRegion() -> MojioRegion {
        if let region = self.region {
            return region
        }

        return MojioRegion.getDefaultRegion()
    }
    
    /**
        Letting an app developer ovveride the default environment. This should be used only for development purposes to test the functionality of the app in different continents
     */
    open func setRegion (_ region: MojioRegion) {
        self.region = region
        self.apiEndpoint = String.init(
            format: ClientEnvironment.EndPointFormat.apiEndpoint.rawValue,
            arguments: [region.rawValue])

        self.apiV1Endpoint = String.init(
            format: ClientEnvironment.EndPointFormat.apiV1Endpoint.rawValue,
            arguments: [region.rawValue])
        
        self.pushApnsEndpoint = String.init(
            format: ClientEnvironment.EndPointFormat.pushApnsEndpoint.rawValue,
            arguments: [region.rawValue])
        
        self.pushWSEndpoint = String.init(
            format: ClientEnvironment.EndPointFormat.pushWSEndpoint.rawValue,
            arguments: [region.rawValue])
        
        self.myMojioEndpoint = String.init(
            format: ClientEnvironment.EndPointFormat.myMojioEndpoint.rawValue,
            arguments: [region.rawValue])
        
        self.accountsEndpoint = String.init(
            format: ClientEnvironment.EndPointFormat.accountsEndpoint.rawValue,
            arguments: [region.rawValue])
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
