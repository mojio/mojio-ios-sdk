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
    
    public init(code : String?, message : String? = nil) {        
        print("ERROR :", code , " " , message)
        self.message = message
        self.code = code
    }
}