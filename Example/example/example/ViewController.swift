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
    var selection = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = SSPAdKitConfig(_inventoryID: "inventID", _adUnitID: "adId")
        adManager = SSPAdKit.init(_config: config)
        adManager?.bannerDelegate = self
        adManager?.popUpDelegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func showBanner(_ sender: Any) {
        selection = 0
        let container = SSPAdContainerSize(_adUnitWidth: "", _adUnitHeight: "")
        _ = adManager?.requestBanner(for: container)
    }
    
    @IBAction func showBanner2(_ sender: Any) {
        selection = 1
        let container = SSPAdContainerSize(_adUnitWidth: "", _adUnitHeight: "")
        _ = adManager?.requestBanner(for: container)
    }
    
    @IBAction func showPopUp(_ sender: Any) {
        let container = SSPAdContainerSize(_adUnitWidth: "", _adUnitHeight: "")
        _ = adManager?.requestPopup(for: container)
    }
    
    func adReceived(forBanner adItem: SSPBannerAd) {
        if selection == 0 {
            adItem.show(in: bannerContainerView)
            return
        }
        adItem.show(in: bannerContainerView2)
    }
    
    func adReceived(forPopUp adItem: SSPPopUpAd) {
        popUpBackgroundView.isHidden = false
        adItem.show(in: popUpContainerView)
    }
    @IBAction func closePopUp(_ sender: Any) {
        popUpBackgroundView.isHidden = true
    }
}

