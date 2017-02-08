//
//  Error.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-14.
//
//

public struct MojioError : ErrorType {
    public var dictionary : NSDictionary?
    public var message : String?
    public var code : String?
    
    public init(code : String?, message : String? = nil, dictionary : NSDictionary? = nil) {
        self.message = message
        self.code = code
        self.dictionary = dictionary
    }
}
