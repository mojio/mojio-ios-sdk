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

public protocol MojioRegionPrefix {
    var regionPrefix: String {get}
}

open class MojioRegion: MojioRegionPrefix {
    
    public enum RegionType: String {
        case production = "production-"
        case fut = "fut-"
        case staging = "staging-"
        case load = "load-"
        case develop = "develop-"
        case ci = "ci-"
        case custom = "custom-"
    }
    
    open var defaultRegionType: RegionType {
        return .production
    }
    
    open var regionPrefix: String {
        return ""
    }
    
    open var description: String {
        return self.regionPrefix + self.regionType.rawValue
    }
    
    open private(set) var regionType: RegionType = .production
    
    public init() {
        self.regionType = self.defaultRegionType
    }
    
    public init(_ regionType: RegionType) {
        self.regionType = regionType
    }
}

public enum MojioEndpoint {
    case api
    case push
    case wsPush
    case myMojio
    case identity
    case tracker
    case image
    case services
}

open class ClientEnvironment {
    
    public typealias CustomEndpoints = (
        apiEndpoint: String?,
        pushApnsEndpoint: String?,
        pushWSEndpoint: String?,
        myMojioEndpoint: String?,
        identityEndpoint: String?,
        trackerEndpoint: String?,
        imageEndpoint: String?,
        servicesEndpoint: String?
    )
    public static var customEndpoints: CustomEndpoints?
    
    private static let endpointDomainFormats: [MojioEndpoint: String] = [
        .api: "%@api.moj.io",
        .push: "%@push.moj.io",
        .wsPush: "%@api.moj.io",
        .myMojio: "%@my.moj.io",
        .identity: "%@identity.moj.io",
        .tracker: "%@trackerapi.moj.io",
        .image: "%@image.moj.io",
        .services: "%@services.moj.io"
    ]
    
    open func domainFromMojioEndpoint(_ endpoint: MojioEndpoint) -> String {
        if let endpointFormat = ClientEnvironment.endpointDomainFormats[endpoint] {
            return String(
                format: endpointFormat,
                arguments: [self.region.description])
        }
        
        return ""
    }
    
    private enum EndPointFormat: String {
        case apiEndpoint = "https://%@api.moj.io/"
        case pushApnsEndpoint = "https://%@push.moj.io/"
        case pushWSEndpoint = "wss://%@api.moj.io/"
        case myMojioEndpoint = "https://%@my.moj.io/"
        case identityEndpoint = "https://%@identity.moj.io/"
        case trackerEndpoint = "https://%@trackerapi.moj.io/"
        case imageEndpoint = "https://%@image.moj.io/"
        case servicesEndpoint = "https://%@services.moj.io/"
    }
    
    fileprivate var region: MojioRegion = MojioRegion()
    
    fileprivate var apiEndpoint: String?
    fileprivate var pushApnsEndpoint: String?
    fileprivate var pushWSEndpoint: String?
    fileprivate var myMojioEndpoint: String?
    fileprivate var identityEndpoint: String?
    fileprivate var trackerEndpoint: String?
    fileprivate var imageEndpoint: String?
    fileprivate var servicesEndpoint: String?
    
    public init() {
        self.updateEndPoints()
    }
    
    open func getRegion() -> MojioRegion {
        return self.region
    }
    
    /**
     Letting an app developer ovveride the default environment. This should be used only for development purposes to test the functionality of the app in different continents
     */
    open func setRegion (_ region: MojioRegion) {
        self.region = region
        self.updateEndPoints()
    }
    
    private func updateEndPoints() {
        if case .custom = self.region.regionType {
            ClientEnvironment.customEndpoints.map { customEndpoints in
                self.apiEndpoint = customEndpoints.apiEndpoint
                self.pushApnsEndpoint = customEndpoints.pushApnsEndpoint
                self.pushWSEndpoint = customEndpoints.pushWSEndpoint
                self.myMojioEndpoint = customEndpoints.myMojioEndpoint
                self.identityEndpoint = customEndpoints.identityEndpoint
                self.trackerEndpoint = customEndpoints.trackerEndpoint
                self.imageEndpoint = customEndpoints.trackerEndpoint
                self.servicesEndpoint = customEndpoints.servicesEndpoint
            }
            return
        }
        
        self.apiEndpoint = String(
            format: ClientEnvironment.EndPointFormat.apiEndpoint.rawValue,
            arguments: [self.region.description])
        
        self.pushApnsEndpoint = String(
            format: ClientEnvironment.EndPointFormat.pushApnsEndpoint.rawValue,
            arguments: [self.region.description])
        
        self.pushWSEndpoint = String(
            format: ClientEnvironment.EndPointFormat.pushWSEndpoint.rawValue,
            arguments: [self.region.description])
        
        self.myMojioEndpoint = String(
            format: ClientEnvironment.EndPointFormat.myMojioEndpoint.rawValue,
            arguments: [self.region.description])
        
        self.identityEndpoint = String(
            format: ClientEnvironment.EndPointFormat.identityEndpoint.rawValue,
            arguments: [self.region.description])
        
        self.trackerEndpoint = String(
            format: ClientEnvironment.EndPointFormat.trackerEndpoint.rawValue,
            arguments: [self.region.description])
        
        self.imageEndpoint = String(
            format: ClientEnvironment.EndPointFormat.imageEndpoint.rawValue,
            arguments: [self.region.description])
        
        self.servicesEndpoint = String(
            format: ClientEnvironment.EndPointFormat.servicesEndpoint.rawValue,
            arguments: [self.region.description])
    }
    
    open func setDefaultRegion () {
        self.setRegion(MojioRegion())
    }
    
    open func getApiEndpoint () -> String {
        return self.apiEndpoint!
    }
    
    open func getPushApnsEndpoint () -> String {
        return self.pushApnsEndpoint!
    }
    
    open func getPushWSEndpoint () -> String {
        return self.pushWSEndpoint!
    }
    
    open func getMyMojioEndpoint () -> String {
        return self.myMojioEndpoint!
    }
    
    open func getIdentityEndpoint () -> String {
        return self.identityEndpoint!
    }
    
    open func getTrackerEndpoint () -> String {
        return self.trackerEndpoint!
    }
    
    open func getImageEndpoint () -> String {
        return self.imageEndpoint!
    }
    
    open func getServicesEndpoint () -> String {
        return self.servicesEndpoint!
    }
}
