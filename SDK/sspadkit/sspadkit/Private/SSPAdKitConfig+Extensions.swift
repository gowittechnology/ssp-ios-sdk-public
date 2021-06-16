//
//  SSPAdKitConfig+Extensions.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 16.06.2021.
//

import Foundation


import UIKit
import WebKit
import SystemConfiguration
import AppTrackingTransparency
import AdSupport



extension SSPAdKitConfig {
    
    private var keyyearOfBirth : String { get { return "yob" } }
    private var keygender : String { get { return "g" } }
    private var keycategories : String { get { return "cat" } }
    private var keylatitude : String { get { return "lt" } }
    private var keylongtitude : String { get { return "ln" } }
    private var keycustomdata : String { get { return "data" } }
    private var keyapplicationVersion : String { get { return "app_v" } }
    private var keylanguage : String { get { return "l" } }
    private var keyinventoryID : String { get { return "i_id" } }
    private var keyadUnitID : String { get { return "ad_id" } }
    private var keyadUnitSizeWidth : String { get { return "ad_w" } }
    private var keyadUnitSizeHeight : String { get { return "ad_h" } }
    private var keyuserAgent : String { get { return "ua" } }
    private var keyconnectionType : String { get { return "ct" } }
    private var keymanifacturer : String { get { return "ma" } }
    private var keymodel : String { get { return "mo" } }
    private var keyOS : String { get { return "o" } }
    private var keyOSVersion : String { get { return "o_v" } }
    private var keyscreenWidth : String { get { return "s_w" } }
    private var keyscreenHeight : String { get { return "s_h" } }
    private var keysdkVersion : String { get { return "sdk_v" } }
    private var keysession : String { get { return "s" } }
    private var keyidfa : String { get { return "idfa" } }
    private var keyusedID : String { get { return "u_id" } }
    private var keymobile : String { get { return "mbl" } }
    private var keybundleID : String { get { return "bundle" } }
    private var keyinterstitial : String { get { return "i_s" } }
    
    private static var userAgent :String = ""
    private static var connectionType = 3
    private static var manifacturer = "Apple"
    private static var model = ""
    private static var OS = "iOS"
    private static var OSVersion = ""
    private static var screenWidth = 0
    private static var screenHeight = 0


    // mandatory SDK properties - source: SDK
    private static var sdkVersion = 1
    private static var session = ""
    private static var idfa = ""
    private static var usedID = ""
    private static var mobile = 1
    private static var bundleID = ""
    
    
    
    enum ReachabilityStatus:Int {
        case unknown = 3
        case notReachable = 0
        case reachableViaWWAN = 6
        case reachableViaWiFi = 2
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
    func getParams() -> [String:Any] {
        
        var params : [String:Any] = [:]
        
        if let yearOfBirth = yearOfBirth {
            params[keyyearOfBirth] = yearOfBirth
        }
        
        params[keygender] = gender.rawValue
        
        if categories.count > 0 {
            params[keycategories] = categories
        }
        
        if let latitude = latitude {
            params[keylatitude] = latitude
        }
        
        if let longtitude = longtitude {
            params[keylongtitude] = longtitude
        }
        
        if customdata.count > 0 {
            params[keycustomdata] = customdata
        }
        
        if let applicationVersion = applicationVersion {
            params[keyapplicationVersion] = applicationVersion
        }
        
        if let language = language {
            params[keylanguage] = language
        }
        
        params[keyinventoryID] = inventoryID
        params[keyadUnitID] = adUnitID
        params[keyadUnitSizeWidth] = adUnitSize?.adUnitWidth ?? 0
        params[keyadUnitSizeHeight] = adUnitSize?.adUnitHeight ?? 0
        
        params[keyuserAgent] = SSPAdKitConfig.userAgent
        params[keyconnectionType] = SSPAdKitConfig.connectionType
        params[keymanifacturer] = SSPAdKitConfig.manifacturer
        params[keymodel] = SSPAdKitConfig.model
        params[keyOS] = SSPAdKitConfig.OS
        params[keyOSVersion] = SSPAdKitConfig.OSVersion
        params[keyscreenWidth] = SSPAdKitConfig.screenWidth
        params[keyscreenHeight] = SSPAdKitConfig.screenHeight
        
        params[keysdkVersion] = SSPAdKitConfig.sdkVersion
        params[keysession] = SSPAdKitConfig.session
        params[keyidfa] = SSPAdKitConfig.idfa
        params[keyusedID] = SSPAdKitConfig.usedID
        params[keymobile] = SSPAdKitConfig.mobile
        params[keybundleID] = SSPAdKitConfig.bundleID
        params[keyinterstitial] = self.interstitial
        
        return params
        
    }
    func setDevicePropertiesDefault() {
        
        

        self.setUserAgent()
        SSPAdKitConfig.connectionType = self.currentReachabilityStatus.rawValue
        SSPAdKitConfig.model = UIDevice.current.model
        SSPAdKitConfig.OSVersion = UIDevice.current.systemVersion
        
        let screenRect = UIScreen.main.bounds
        SSPAdKitConfig.screenWidth = Int(screenRect.size.width)
        SSPAdKitConfig.screenHeight = Int(screenRect.size.height)
        
        SSPAdKitConfig.session = UUID().uuidString
        
        self.setIDFA()
        
        SSPAdKitConfig.usedID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        
        SSPAdKitConfig.bundleID = Bundle.main.bundleIdentifier ?? ""
    }
    
    private func setDevicePropertiesForRequest() {

        SSPAdKitConfig.connectionType = self.currentReachabilityStatus.rawValue
        
        self.setIDFA()
        
        let screenRect = UIScreen.main.bounds
        SSPAdKitConfig.screenWidth = Int(screenRect.size.width)
        SSPAdKitConfig.screenHeight = Int(screenRect.size.height)
    }
    
    func setUserAgent() {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.evaluateJavaScript("navigator.userAgent", completionHandler: { (result, error) in
                  debugPrint(result as Any)
                  debugPrint(error as Any)

                  if let unwrappedUserAgent = result as? String {
                    SSPAdKitConfig.userAgent = unwrappedUserAgent
                  } else {
                    SSPAdKitConfig.userAgent = "failed to get the user agent"
                  }
              })
    }
    
    func setIDFA() {
        if shouldAskForIDFA {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                            switch status {
                            case .authorized:
                                SSPAdKitConfig.idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                            case .denied:
                                SSPAdKitConfig.idfa = ""
                            case .notDetermined:
                                SSPAdKitConfig.idfa = ""
                            case .restricted:
                                SSPAdKitConfig.idfa = ""
                            @unknown default:
                                SSPAdKitConfig.idfa = ""
                            }
                }
                return
            } else {
                if ASIdentifierManager.shared().isAdvertisingTrackingEnabled == false {
                    SSPAdKitConfig.idfa = ""
                    return
                }
            }

            SSPAdKitConfig.idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            return
        } else {
            if #available(iOS 14, *) {
                if ATTrackingManager.trackingAuthorizationStatus != ATTrackingManager.AuthorizationStatus.authorized  {
                    SSPAdKitConfig.idfa = ""
                    return
                }
            } else {
                if ASIdentifierManager.shared().isAdvertisingTrackingEnabled == false {
                    SSPAdKitConfig.idfa = ""
                    return
                }
            }

            SSPAdKitConfig.idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            return
        }
        
    }
}
