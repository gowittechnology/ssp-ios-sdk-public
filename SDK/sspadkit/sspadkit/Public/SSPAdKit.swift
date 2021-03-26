//
//  SSPAdKit.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import Foundation
import UIKit

public protocol BannerAdDelegate: NSObjectProtocol {
    func adReceived(forBanner adItem: SSPBannerAd)
}

public protocol PopUpAdDelegate: NSObjectProtocol {
    func adReceived(forPopUp adItem: SSPPopUpAd)
}

public enum SSPRequestResponse : Int {
    case succes =  0
    case internalError
    case delegateNotImplemented
    case containerNotSuitable
}

public class SSPAdKit {
    
    public var config: SSPAdKitConfig?
    public var bannerDelegate: BannerAdDelegate?
    public var popUpDelegate: PopUpAdDelegate?

    convenience public init(_config: SSPAdKitConfig) {
        debugPrint("VfkFrameworkDemo initialized.")
        self.init()
        self.config = _config
    }

    
    public func requestBanner(for size:SSPAdContainerSize) -> SSPRequestResponse {
        if let bannerDelegate = bannerDelegate {
            let bannerReq = SSPBannerAdRequest()
            bannerReq.requestAd(handler: { banner in
                bannerDelegate.adReceived(forBanner: banner)
            })
            return .succes
        } else {
            return .delegateNotImplemented
        }
    }
    
    public func requestPopup(for size:SSPAdContainerSize) -> SSPRequestResponse {
        if let popUpDelegate = popUpDelegate {
            let popUpReq = SSPPopUpAdRequest()
            popUpReq.requestAd(handler: { popUp in
                popUpDelegate.adReceived(forPopUp: popUp)
            })
            return .succes
        } else {
            return .delegateNotImplemented
        }
    }
}
