//
//  Result.swift
//  Pods
//
//  Created by Narayan Sainaney on 2016-06-30.
//
//


import Foundation
import ObjectMapper

open class Result {
    open var TotalCount : Int? = nil
    open var Data : NSArray? = nil
    
    public init(data: NSArray?, count :Int? = nil) {
        self.Data = data
        self.TotalCount = count
    }
    
}
