//
//  Transport.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-22.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit

// In the current version of the SDK, Apple push and SignalR are the only transport types that have been implemented
enum TransportType : String {
    case Apple = "Apple"
    case SignalR = "SignalR"
}

class Transport {
    
    var Type : TransportType

    // Required for Apple push notifications
    var DeviceToken : String = ""
    var AppId : String = "" // is this the bundle id ??
    var AlertBody : String?
    var AlertSound : String?
    var AlertCategory : String?
    var Badge : NSInteger?
    
    // required for SignalR
    var ClientId : String = ""
    var HubName : String = ""
    var Callback : String?
    
    // Apple Push
    init (appId : String, deviceToken : String, alertBody : String?, alertSound : String?, alertCategory : String?, badge : NSInteger?) {
        self.Type = TransportType.Apple
        self.AppId = appId
        self.DeviceToken = deviceToken
    }
    
    init (clientId : String, hubName : String, callback : String?) {
        self.Type = TransportType.SignalR
        self.ClientId = clientId
        self.HubName = hubName
        self.Callback = callback
        
        self.AlertBody = ""
        self.AlertCategory = ""
        self.AlertSound = ""
        self.Badge = 0
        self.Callback = ""
    }
    
    func toString () -> String {
        var string : String = "{"
        string = string + "\"TransportType\":\"" + "SignalR" + "\""
//        string = string + ", DeviceToken:\"" + DeviceToken + "\""
//        string = string + ", AppId:\"" + AppId + "\""
//        string = string + ", AlertBody:\"" + AlertBody! + "\""
//        string = string + ", AlertSound:\"" + AlertSound! + "\""
//        string = string + ", AlertCategory:\"" + AlertCategory! + "\""
//        string = string + ", Badge=\"" + String(Badge) + "\""
        string = string + ", \"ClientId\":\"" + ClientId + "\""
        string = string + ", \"HubName\":\"" + HubName + "\""
//        string = string + ", Callback=\"" + Callback! + "\""
        string = string + "}"
        return string
    }
}
