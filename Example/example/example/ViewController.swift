//
//  ViewController.swift
//  example
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import UIKit
import sspadkit

class ViewController: UIViewController, BannerAdDelegate, PopUpAdDelegate {
    
    

    @IBOutlet weak var bannerContainerView: UIView!
    @IBOutlet weak var bannerContainerView2: UIView!
    @IBOutlet weak var popUpContainerView: UIView!
    @IBOutlet weak var popUpBackgroundView: UIView!
    
    var adManager: SSPAdKit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = SSPAdKitConfig(_inventoryID: "XXXXXXXXX", _adUnitID: "XXXXXXXXX")
        adManager = SSPAdKit.init(_config: config)
        adManager?.bannerDelegate = self
        adManager?.popUpDelegate = self
    }

    @IBAction func showBanner(_ sender: Any) {
        if let manager = adManager {
            let result = manager.requestBanner(for: SSPBannerSizes.banner, _identifier: 0)
            print(result.enumDetails)
        }
        
    }
    
    @IBAction func showBanner2(_ sender: Any) {
        if let manager = adManager {
            let result = manager.requestBanner(for: SSPBannerSizes.largeBanner, _identifier: 1)
            print(result.enumDetails)
        }
        
    }
    
    @IBAction func showPopUp(_ sender: Any) {
        if let manager = adManager {
            let result = manager.requestPopup(for: SSPPopUpSizes.medium)
            print(result.enumDetails)
        }
        
    }
    
    
    // MARK: Banner Add Methods
    
    func addReceived(forBanner adItem: SSPBannerAd) {
        if adItem.addId == 0 {
            adItem.show(in: bannerContainerView)
            return
        }
        adItem.show(in: bannerContainerView2)
    }
    
    func failedToLoadAdd(forBanner adItem: SSPBannerAd, reason: SSPResult) {
        print(reason.enumDetails)
    }
    
    
    
    
    // MARK: PopUp Add Methods
    func addReceived(forPopUp adItem: SSPPopUpAd) {
        adItem.show(in: popUpContainerView)
    }
    
    func failedToLoadAdd(forPopUp adItem: SSPPopUpAd, reason: SSPResult) {
        print(reason.enumDetails)
    }
    
    func addWillAppear(forPopUp adItem: SSPPopUpAd){
        popUpBackgroundView.isHidden = false
    }
    
    func closePopUp(forPopUp adItem: SSPPopUpAd){
        popUpBackgroundView.isHidden = true
    }
    
}

