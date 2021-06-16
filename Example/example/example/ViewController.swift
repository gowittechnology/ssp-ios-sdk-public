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
        
        let config = SSPAdKitConfig(_inventoryID: "XXXXXXXXX", _adUnitID: "XXXXXXXXX")
        adManager = SSPAdKit.init(_config: config)
        adManager?.bannerDelegate = self
        adManager?.popUpDelegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func showBanner(_ sender: Any) {
        selection = 0
        let container = SSPAdContainerSize(_adUnitWidth: 100, _adUnitHeight: 100)
        _ = adManager?.requestBanner(for: container)
    }
    
    @IBAction func showBanner2(_ sender: Any) {
        selection = 1
        let container = SSPAdContainerSize(_adUnitWidth: 100, _adUnitHeight: 100)
        _ = adManager?.requestBanner(for: container)
    }
    
    @IBAction func showPopUp(_ sender: Any) {
        let container = SSPAdContainerSize(_adUnitWidth: 100, _adUnitHeight: 100)
        _ = adManager?.requestPopup(for: container)
    }
    
    func addReceived(forBanner adItem: SSPBannerAd) {
        if selection == 0 {
            adItem.show(in: bannerContainerView)
            return
        }
        adItem.show(in: bannerContainerView2)
    }
    
    func addWillAppear(forBanner adItem: SSPBannerAd) {
        
    }
    
    func addReceived(forPopUp adItem: SSPPopUpAd) {
        popUpBackgroundView.isHidden = false
        adItem.show(in: popUpContainerView)
    }
    
    func addWillAppear(forPopUp adItem: SSPPopUpAd){}
    func closePopUp(forPopUp adItem: SSPPopUpAd){
        popUpBackgroundView.isHidden = true
    }
    
}

