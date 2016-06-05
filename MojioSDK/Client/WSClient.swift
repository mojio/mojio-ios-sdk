//
//  WSClient.swift
//  Pods
//
//  Created by Narayan Sainaney on 2016-06-03.
//
//

import Foundation
import SwiftWebSocket

public class WSClient : RestClient {
    
    public func watch(callback: (AnyObject) -> Void ) -> WebSocket {
        
        let request = NSMutableURLRequest(URL: NSURL(string:super.requestUrl!)!)
        if let accessToken : String = super.accessToken() {
            request.addValue("Authorization", forHTTPHeaderField: "Bearer " + accessToken)

        }
        
        let ws = WebSocket(request: request)
        
        ws.event.close = { code, reason, clean in
            print("close")
        }
        ws.event.error = { error in
            print("error \(error)")
        }
        ws.event.message = { message in
            if let text = message as? String {
                print("recv: \(text)")
                callback(text)
            }
        }
        
        return ws
    }
}