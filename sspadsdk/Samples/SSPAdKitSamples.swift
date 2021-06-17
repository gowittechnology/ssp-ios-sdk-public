//
//  SSPAdSdk.swift
//  sspadsdk
//
//  Created by Dogus Yigit Ozcelik on 17.06.2021.
//

import Foundation


protocol BannerAdDelegate: NSObjectProtocol {
    
    func addReceived(forBanner adItem: SSPBannerAd)
    func failedToLoadAdd(forBanner adItem: SSPBannerAd, reason: SSPResult)
    
    @objc optional func addWillAppear(forBanner adItem: SSPBannerAd)
}

protocol PopUpAdDelegate: NSObjectProtocol {
    
    func addReceived(forPopUp adItem: SSPPopUpAd)
    func failedToLoadAdd(forPopUp adItem: SSPPopUpAd, reason: SSPResult)
    func closePopUp(forPopUp adItem: SSPPopUpAd)
    
    @objc optional func addWillAppear(forPopUp adItem: SSPPopUpAd)
}


class SSPAdKit {
    
    public var bannerDelegate: BannerAdDelegate?
    public var popUpDelegate: PopUpAdDelegate?
    
    public init(_config: SSPAdKitConfig) {}
    
    public func requestBanner(for _size:SSPBannerSizes, _identifier : Int? = nil) -> SSPRequestResponse {}
    
    public func requestPopup(for _size:SSPPopUpSizes, _identifier : Int? = nil) -> SSPRequestResponse {}
    
}
