//
//  Condition.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-22.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit

enum ConditionType {
    case PropertyChanged
    case Threshold
    case Debounce
    case Throttle
}

enum ThresholdPosition {
    case Above
    case Below
    case Between
}

class Condition {
    
    let PROPERTY : String = "Property"
    let POSITION : String = "Position"
    let MAX : String = "Max"
    let MIN : String = "Min"
    let TIME_PROPERTY : String = "TimeProperty"
    let DELAY : String = "Delay"
    let MIN_DATA_POINTS : String = "MinDataPoints"
    let WINDOW : String = "Window"
    
    private var PropertyChanged : String?
    private var Property : String?
    
    
    // Threshold
    private var Max : NSInteger?
    private var Min : NSInteger?
    private var Position : ThresholdPosition?
    
    // Debounce and Throttle
    private var TimeProperty : String?
    private var DataPoints : NSInteger?
    private var Delay : String?
    private var Window : String?
    
    private var type : ConditionType?
    
    init (type : ConditionType) {
        self.type = type
    }
    
    func getDelay () -> String? {
        return self.Delay
    }
    
    func setDelay (delay : String) {
        self.Delay = delay
    }
    
    func getMax () -> NSInteger? {
        return self.Max
    }
    
    func setMax (max : NSInteger) {
        self.Max = max
    }
    
    func getMin () -> NSInteger? {
        return self.Min
    }
    
    func setMin (min : NSInteger) {
        self.Min = min
    }
    
    func getDataPoints () -> NSInteger? {
        return self.DataPoints
    }
    
    func setDataPoints (dataPoints : NSInteger) {
        self.DataPoints = dataPoints
    }
    
    func getPosition () -> ThresholdPosition? {
        return self.Position
    }
    
    func setPosition (position : ThresholdPosition) {
        self.Position = position
    }
    
    func getProperty () -> String? {
        return self.Property
    }
    
    func setProperty (property : String) {
        self.Property = property
    }
    
    func getTimeProperty () -> String?{
        return self.TimeProperty
    }
    
    func setTimeProperty (timeProperty : String) {
        self.TimeProperty = timeProperty
    }
    
    func getWindow () -> String? {
        return self.Window
    }
    
    func setWindow (window : String) {
        self.Window = window
    }
    
    
    // Debounce
    init (minDataPoints : NSInteger, delay : String) {
        self.type = ConditionType.Debounce
        self.setDataPoints(minDataPoints)
        self.setDelay(delay)
    }
    
    init (minDataPoints : NSInteger) {
        self.type = ConditionType.Debounce
        self.DataPoints = minDataPoints
    }
    
    // PropertyChanged
    init (property : String) {
        self.type = ConditionType.PropertyChanged
        self.Property = property
    }
    
    // Threshold
    init (property : String, max : NSInteger, min : NSInteger, position : ThresholdPosition) {
        self.type = ConditionType.Threshold
        self.Property = property
        self.Max = max
        self.Min = min
        self.Position = position
    }
    
    // Throttle
    init (timeProperty : String, window : String) {
        
    }
    

}
