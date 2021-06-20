//
//  SSPAdKitEnumSamples.swift
//  sspadsdk
//
//  Created by Dogus Yigit Ozcelik on 17.06.2021.
//

import Foundation

public enum SSPBannerSizes : Int {
    case banner =  0
    case largeBanner
    case mediumRect
    case largeRect
    case fullSize
    case leaderBoard
    
    var description: String {
        switch self {
        case .banner: return "iPhone + iPad"
        case .largeBanner: return "iPhone + iPad"
        case .mediumRect: return "iPhone + iPad"
        case .largeRect: return "iPhone + iPad"
        case .fullSize: return "iPad"
        case .leaderBoard: return "iPad"
        }
    }
    
    var width: Int {
        switch self {
        case .banner: return  320
        case .largeBanner: return  320
        case .mediumRect: return  300
        case .largeRect: return  336
        case .fullSize: return  468
        case .leaderBoard: return  728
        }
    }
    
    var height: Int {
        switch self {
        case .banner: return 50
        case .largeBanner: return 100
        case .mediumRect: return 250
        case .largeRect: return 280
        case .fullSize: return 60
        case .leaderBoard: return 90
        }
    }
}

public enum SSPPopUpSizes : Int {
    case small =  0
    case medium
    case big
    
    var description: String {
        switch self {
        case .small: return "iPhone"
        case .medium: return "iPhone"
        case .big: return "iPad"
        }
    }
    
    var width: Int {
        switch self {
        case .small: return  320
        case .medium: return  640
        case .big: return  800
        }
    }
    
    var height: Int {
        switch self {
        case .small: return 480
        case .medium: return 960
        case .big: return 600
        }
    }
}

public enum SSPRequestResponse : Int {
    case succes =  0
    case delegateNotImplemented
    case sizeNotAvailableForDevice
    case inventoryIDNotValid
    case addUnitIDNotValid
    
    public var enumDetails: String {
        switch self {
        case .succes: return "Succes: Add request created "
        case .delegateNotImplemented: return "Failed: Please set delegation parameters first"
        case .sizeNotAvailableForDevice: return "Failed: Selected Add size is not available for this device."
        case .inventoryIDNotValid: return "Failed: Please check your inventory ID"
        case .addUnitIDNotValid: return "Failed: Please check your add unit ID"
        }
    }
}

@objc public enum SSPResult : Int {
    case succes =  0
    case networkErrorJson
    case networkRequestFailed
    case networkResponseIsEmpty
    case didntReceiveAnyAdds
    case addViewConstructorError
    case addContainerSizeIsNotCorrect
    
    public var enumDetails: String {
        switch self {
        case .succes: return "Succes: Add request created "
        case .networkErrorJson: return "Couldn't parse response JSON "
        case .networkRequestFailed: return "Network request failed please check logs for more details"
        case .networkResponseIsEmpty: return "Network request failed please check logs for more details"
        case .didntReceiveAnyAdds: return "Didn't receive any add from server"
        case .addViewConstructorError: return "Couldn't create webview to show adds."
        case .addContainerSizeIsNotCorrect: return "Add container view size is not suitable for selected add size."
        }
    }
}

public enum GenderTypes : String {
    case unknown =  ""
    case male = "M"
    case female = "F"
}
