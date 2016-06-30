//
//  Result.swift
//  Pods
//
//  Created by Narayan Sainaney on 2016-06-30.
//
//


import Foundation
import ObjectMapper

public class Result {
    public var TotalCount : Int? = nil
    public var Data : NSArray? = nil
    
    public init(data: NSArray?, count :Int? = nil) {
        self.Data = data
        self.TotalCount = count
    }
    
}