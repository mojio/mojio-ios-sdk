//
//  Error.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-14.
//
//

public struct MojioError : Error {
    public var dictionary : NSDictionary?
    public var message : String?
    public var code : String?
    
    public init(code : String?, message : String? = nil, dictionary : NSDictionary? = nil) {
        debugPrint("ERROR :", code ?? "" , " " , message ?? "")
        self.message = message
        self.code = code
        self.dictionary = dictionary
    }
}

public struct AuthDisplayError : Error {
    public var message1 : String?
    public var message2 : String?
    public var message3 : String?

    public init(message1 : String?, message2 : String? = nil, message3 : String? = nil) {
        self.message1 = message1
        self.message2 = message2
        self.message3 = message3
    }
}
