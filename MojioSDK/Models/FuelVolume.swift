//
//  FuelVolume.swift
//  MojioSDK
//
//  Created by Oleksii Lubianyi on 9/30/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper


// Units in FuelVolumeUnits
open class FuelVolume: DeviceMeasurement {

    public required convenience init?(map: Map) {
        self.init()
    }
}
