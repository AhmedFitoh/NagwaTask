//
//  WebService.swift
//  NagwaIosTask
//
//  Created by Ahmed Fitoh on 10/6/18.
//  Copyright © 2018 Nagwa. All rights reserved.
//

import Foundation
import Alamofire


protocol DataFetcherProtocol {
    func onDataReady(_data : Any , url : String)
    func onError(_error:Error)
}


class WebService {
    
    var url : String!
    var params : Parameters
    var fetchDelegate : DataFetcherProtocol!
    
    init(url : String, params : Parameters ,fetchDelegate : DataFetcherProtocol!) {
        self.url = url
        self.params = params
        self.fetchDelegate = fetchDelegate
    }
    
    func get()  {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url, method: .get, parameters: params ).responseData { (response ) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result
            {
            case .success(let _data):
                self.fetchDelegate.onDataReady(_data: _data  , url : self.url )
            case .failure(let error):
                self.fetchDelegate.onError(_error: error)
            }
        }
    }
    
    func post()  {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
         Alamofire.request(url, method: .post, parameters: params ,  encoding: JSONEncoding.default ).responseData { (response ) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            switch response.result
            {
            case .success(let _data):
                self.fetchDelegate.onDataReady(_data: _data as AnyObject , url : self.url)
            case .failure(let error):
                self.fetchDelegate.onError(_error: error)
            }
        }
     }

}
