//
//  SSPAdKitConfigSamples.swift
//  sspadsdk
//
//  Created by Dogus Yigit Ozcelik on 17.06.2021.
//

import Foundation


class SSPAdKitConfig {
    
    
    /*
     
     Mandotory parameters to configuring SDK
     
     */
    public let inventoryID : String
    public let adUnitID : String
    
    
    /*
     
     Available parameters for customizing ads
     
     */
    public var yearOfBirth : Int?
    public var gender : GenderTypes = .unknown
    public var categories:[String:String] = [:]
    public var latitude : String?
    public var longtitude : String?
    public var customdata:[String:String] = [:]
    public var applicationVersion : String?
    public var language : String?
    
    
    /*
     
     SDK behaviour configurations
     
     */
    public var shouldAskForIDFA = false
    public var addTimeOutInterval : Int?
    
    
    public init(_inventoryID: String, _adUnitID: String) {}
}
