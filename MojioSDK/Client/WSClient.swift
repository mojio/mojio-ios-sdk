//
//  WSClient.swift
//  Pods
//
//  Created by Narayan Sainaney on 2016-06-03.
//
//

import Foundation
import SwiftWebSocket
import SwiftyJSON


public class WSClient : RestClient {
    
    public func watch(completion: ((AnyObject) -> Void), failure: (NSError) -> Void) -> WebSocket {
        
        let request = NSMutableURLRequest(URL: NSURL(string:super.pushUrl!)!)
        if let accessToken : String = super.accessToken() {
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")

        }
        
        let ws = WebSocket(request: request)
        
        ws.event.close = { code, reason, clean in
            print("close")
        }
        ws.event.error = { error in
            print("error \(error)")
        }
        
        ws.event.open = {
            print("OPENED")
        }
        ws.event.message = { message in
            if let text = message as? String {
                do {
                    if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
                        if let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? NSDictionary {
                            if let obj = super.parseDict(dict) {
                                completion(obj)
                            }
                        }
                    }
                }
                catch let error as NSError {
                    failure(error)
                }
            }
        }
        ws.open()
        
        /*
         return AnonymousDisposable {
         request.cancel()
         }
         */
        
        return ws
    }
}