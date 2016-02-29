//
//  Observer.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-22.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit

class Observer {
    
    var Key : String = ""
    var CreatedOn : String = ""
    var LastModified : String = ""
    var ExpiryDate : String = ""
    var Name : String = ""
    var Type : String = ""
    var Subject : String?
    var Fields : [String]? // the fields we want returned if the observer is triggered. Passing in null will return the entire entity
    var Transports : Transport?
    var Conditions : [Condition] = []
    
    func toString () -> String {
        
        var str : String = "{"
        str = str + "\"Key\":\"" + Key + "\""
//        str = str + ", CreatedOn:\"" + CreatedOn + "\""
//        str = str + ", LastModified:\"" + LastModified + "\""
//        str = str + ", ExpiryDate:\"" + ExpiryDate + "\""
        str = str + ", \"Name\":\"" + Name + "\""
//        str = str + ", Type:\"" + Type + "\""
        str = str + ", \"Transport\":" + (Transports?.toString())!
//        str = str +
        str = str + "}"
        
//        let string : String = "Observer{" +
//                                "Key=" + Key +
//                                ", CreatedOn=\"" + CreatedOn + "\"" +
////                                ", LastModified=\"" + LastModified + "\"" +
////                                ", ExpiryDate=\"" + ExpiryDate + "\"" +
////                                ", Name=\"" + Name + "\"" +
////                                ", Subject=\"" + Subject + "\"" +
////                                ", Type=" + Type +
////                                ", Fields=" + Fields +
////                                ", Transports=" + Transports +
////                                ", Conditions=" + Conditions +
//                            "}"
        return str
    }
    
    
}
