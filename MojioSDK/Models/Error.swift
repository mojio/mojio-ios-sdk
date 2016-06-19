//
//  Error.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-14.
//
//

public struct MojioError : ErrorType {
    public var message : String?
    public var code : String?
    
    public init(message : String?, code : String? = nil) {
        self.message = message
        self.code = code
    }
}