//
//  NetworkHelper.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 16.06.2021.
//

import Foundation

public class NetworkHelper {
    
    private let bannerURL = "https://0d61aee2-60b9-49d3-b56f-56408f40c40d.mock.pstmn.io/ads?response=banner"
    private let popUpURL = "https://0d61aee2-60b9-49d3-b56f-56408f40c40d.mock.pstmn.io/ads?response=banner"
    
    func requestBanner(params: [String:Any], handler: @escaping ((AddResponse) -> Void)) {
        
        NetworkService().makeAPICall(url: bannerURL, params: params, success: { (data, response, error) in
            if let responseJSON = try? JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                print(responseJSON)
                let ad : String = responseJSON["ad"] as! String
                let billable : String = responseJSON["billable"] as! String
                let height : Int = responseJSON["height"] as! Int
                let width : Int = responseJSON["width"] as! Int
                let resp = AddResponse(succes: true, error: nil, ad: ad, width: width, height: height, billable: billable)
                handler(resp)
            } else {
                let resp = AddResponse(succes: false, error: error?.localizedDescription, ad: nil, width: nil, height: nil, billable: nil)
                handler(resp)
            }
            
        }, failure: { data, response, error in
            let resp = AddResponse(succes: false, error: error?.localizedDescription, ad: nil, width: nil, height: nil, billable: nil)
            handler(resp)
        })

    }
    
    func requestPopUp(params: [String:Any], handler: @escaping ((AddResponse) -> Void)) {
        
        NetworkService().makeAPICall(url: popUpURL, params: params, success: { (data, response, error) in
            if let responseJSON = try? JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                print(responseJSON)
                let ad : String = responseJSON["ad"] as! String
                let billable : String = responseJSON["billable"] as! String
                let height : Int = responseJSON["height"] as! Int
                let width : Int = responseJSON["width"] as! Int
                let resp = AddResponse(succes: true, error: nil, ad: ad, width: width, height: height, billable: billable)
                handler(resp)
            } else {
                let resp = AddResponse(succes: false, error: error?.localizedDescription, ad: nil, width: nil, height: nil, billable: nil)
                handler(resp)
            }
            
        }, failure: { data, response, error in
            let resp = AddResponse(succes: false, error: error?.localizedDescription, ad: nil, width: nil, height: nil, billable: nil)
            handler(resp)
        })

    }
}
