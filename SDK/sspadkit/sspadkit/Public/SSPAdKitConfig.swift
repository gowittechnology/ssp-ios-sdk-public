//
//  SSPAdKitConfig.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import Foundation

public class SSPAdKitConfig {
    
    // not mandatory properties - source: developer
    public var yearOfBirth = ""
    public var gender = ""
    public var latitude = ""
    public var longtitude = ""
    public var customdata = ""
    public var applicationVersion = ""
    public var language = ""
    public var userAgent = ""
    
    // mandatory properties - source: developer
    public var inventoryID = ""
    public var adUnitID = ""
    public var adUnitSize : SSPAdContainerSize?
    
    // mandatory device properties - source: SDK
    private var connectionType = ""
    private var manifacturer = ""
    private var Model = ""
    private var OS = ""
    private var OSVersion = ""
    private var screenWidth = ""
    private var screenHeight = ""
    
    // mandatory SDK properties - source: SDK
    private var sdkVersion = ""
    private var session = ""
    
    convenience public  init(_inventoryID: String, _adUnitID: String) {
        self.init()
        self.inventoryID = _inventoryID
        self.adUnitID = _adUnitID
    }
    
}

public class SSPAdContainerSize {
    
    private var adUnitWidth = ""
    private var adUnitHeight = ""
    
    convenience public init(_adUnitWidth: String, _adUnitHeight: String) {
        self.init()
        self.adUnitWidth = _adUnitWidth
        self.adUnitHeight = _adUnitHeight
    }
}
