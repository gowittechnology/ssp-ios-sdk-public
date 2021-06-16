//
//  SSPAdContainerSize.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 16.06.2021.
//

import Foundation
import UIKit

public class SSPAdContainerSize {
    
    public var isForBanner: Bool?
    public var popUpSize: SSPPopUpSizes?
    public var bannerSize: SSPBannerSizes?
    public var adUnitWidth : Int
    public var adUnitHeight : Int
    
    public init(_popUpSize: SSPPopUpSizes) {
        self.popUpSize = _popUpSize
        self.isForBanner = false
        self.adUnitWidth = _popUpSize.width
        self.adUnitHeight = _popUpSize.height
    }
    
    public init(_bannerSize: SSPBannerSizes) {
        self.bannerSize = _bannerSize
        self.isForBanner = true
        self.adUnitWidth = _bannerSize.width
        self.adUnitHeight = _bannerSize.height
    }
    
    var isValid : Bool {
        debugPrint("iPhone Banner Sizes: banner,largeBanner,mediumRect,largeRect")
        debugPrint("iPad Banner Sizes: banner,largeBanner,mediumRect,largeRect,fullSize,leaderBoard")

        debugPrint("iPhone PopUp Sizes: small,medium")
        debugPrint("iPhone Banner Sizes: big")
        
        if UIDevice().userInterfaceIdiom == .phone {
            return isForBanner! ? !([SSPBannerSizes.leaderBoard, SSPBannerSizes.fullSize].contains(where: { $0.rawValue == self.bannerSize!.rawValue }))
                : self.popUpSize?.rawValue != SSPPopUpSizes.big.rawValue
        } else if UIDevice().userInterfaceIdiom == .pad {
            return isForBanner! ? ([SSPBannerSizes.leaderBoard, SSPBannerSizes.fullSize].contains(where: { $0.rawValue == self.bannerSize!.rawValue }))
                : self.popUpSize?.rawValue == SSPPopUpSizes.big.rawValue
        }
        return false
    }
}
