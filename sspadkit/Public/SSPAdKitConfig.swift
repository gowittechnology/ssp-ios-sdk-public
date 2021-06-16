//
//  SSPAdKitConfig.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import Foundation
import UIKit


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
    
    
    // mandatory properties - source: developer
    public let inventoryID : String
    public let adUnitID : String
    public var adUnitSize : SSPAdContainerSize?
    
    public var shouldAskForIDFA = false
    public var addTimeOutInterval : Int?
    
    public var interstitial = 0

    public init(_inventoryID: String, _adUnitID: String) {
        self.inventoryID = _inventoryID
        self.adUnitID = _adUnitID
        self.setDevicePropertiesDefault()
    }
    
    public var isInventoryIDValid : Bool {
        if (inventoryID == "") { return false } else { return true}
    }
    
    public var isAdUnitIDValid : Bool {
        if (inventoryID == "") { return false } else { return true}
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




