//
//  SSPAdKitConfig.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import Foundation
import UIKit
import WebKit
import SystemConfiguration
import AppTrackingTransparency
import AdSupport

public enum GenderTypes : String {
    case unknown =  ""
    case male = "M"
    case female = "F"
}


public class SSPAdContainerSize {
    
    public var adUnitWidth : Int
    public var adUnitHeight : Int
    
    public init(_adUnitWidth: Int, _adUnitHeight: Int) {
        self.adUnitWidth = _adUnitWidth
        self.adUnitHeight = _adUnitHeight
    }
}

protocol SSPAdKitConfigProtocol  {
    func setDevicePropertiesDefault()
    func getParams() -> [String:Any]
}

//extension SSPAdKitConfigProtocol  {
//    func setDevicePropertiesDefault() {}
//    func getParams() -> [String:Any] { return [:] }
//}

public class SSPAdKitConfig : SSPAdKitConfigProtocol{
    
    // not mandatory properties - source: developer
    public var yearOfBirth : Int?
    public var gender : GenderTypes = .unknown
    public var categories:[String:String] = [:]
    public var latitude : String?
    public var longtitude : String?
    public var customdata:[String:String] = [:]
    public var applicationVersion : String?
    public var language : String?
    public var shouldAskForIDFA = false
    
    
    // mandatory properties - source: developer
    public var inventoryID : String
    public var adUnitID : String
    public var adUnitSize : SSPAdContainerSize?
    
    public var interstitial = 0

    
    public init(_inventoryID: String, _adUnitID: String) {
        self.inventoryID = _inventoryID
        self.adUnitID = _adUnitID
        self.setDevicePropertiesDefault()
    }
    
    public func getBannerParams() -> [String:Any] {
        self.interstitial = 0
        return self.getParams()
    }
    
    public func getPopUpParams() -> [String:Any] {
        self.interstitial = 1
        return self.getParams()
    }
    
    
}




