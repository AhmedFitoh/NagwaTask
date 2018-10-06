//
//  ServiceHandler.swift
//  NagwaIosTask
//
//  Created by Ahmed Fitoh on 10/6/18.
//  Copyright © 2018 Nagwa. All rights reserved.
//

import Foundation
import Alamofire


class ServiceHandler : ModelOperationDelegate {
    
   private lazy var BASE_URL               = "https://api.github.com/"
   private lazy var URL_UserSearch         = "users/"
   private lazy var URL_RepoSearch         = "repos"
    
    func  search( page : Int , itemsPerPage : Int , username : String , delegate:DataFetcherProtocol){
        let params : Parameters = ["page" : page  ,
                                   "per_page" : itemsPerPage
                                  ]
        let urlString = BASE_URL + URL_UserSearch + username + "/" + URL_RepoSearch
        let service =  WebService.init(url: urlString , params: params, fetchDelegate: delegate)
        service.get()
    }

  
}
