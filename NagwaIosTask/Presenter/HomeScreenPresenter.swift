//
//  HomeScreenPresenter.swift
//  NagwaIosTask
//
//  Created by Ahmed Fitoh on 10/6/18.
//  Copyright © 2018 Nagwa. All rights reserved.
//

import Foundation


protocol PresenterOperationDelegate {
    func getCellCount() -> Int
    func search ()
    func loadMore ()
    func loadCache ()
    func getDataBy(indexPath : IndexPath) -> GithubModelElement
    var lastIndex : Int {get }
}

protocol ModelOperationDelegate {
    func  search( page : Int , itemsPerPage : Int , username : String , delegate:DataFetcherProtocol)
}

class HomeScreenPresenter : PresenterOperationDelegate {
    
   private var homeScreenDelegate : HomeScreenDelegate
   private var webService : ModelOperationDelegate = ServiceHandler ()
   private var cacheService : CacheOperationDelegate = CachingService ()
   private var fetchedData : GithubModel = []
   private var pageCounter = 1
   private var itemsPerPage = 15
   private let username = "JeffreyWay"
   var lastIndex : Int {
        get {
            return  (pageCounter * itemsPerPage ) - 4
        }
    }
    init(delegate: HomeScreenDelegate) {
        self.homeScreenDelegate = delegate
    }
   
    func getCellCount() -> Int {
       return fetchedData.count
    }
    func loadCache () {
      let fetchedList =  cacheService.retriveData()
        if fetchedList.isEmpty {
            // fetch data from github
            search()
        } else {
            self.fetchedData = fetchedList
            pageCounter = fetchedList.count / itemsPerPage
        }
    }
    func search () {
        webService.search(page: pageCounter, itemsPerPage: itemsPerPage, username: username, delegate: self)
    }
    func loadMore() {
        pageCounter += 1
        search()
    }
    
    func getDataBy(indexPath: IndexPath) -> GithubModelElement {
        return fetchedData [indexPath.row]
    }
    
    private func dataFetchFinilize (){
        homeScreenDelegate.reloadTable()
        homeScreenDelegate.stopSpinnerAnimation()
    }
}



extension HomeScreenPresenter : DataFetcherProtocol {
   
    func onDataReady(_data: Any, url: String ) {
                // github model response
                if let fetchedData = try? JSONDecoder().decode( GithubModel.self, from: _data as! Data) {
                    self.fetchedData += fetchedData
                    cacheService.saveDataLocaly(fetchedData: fetchedData)
                    dataFetchFinilize()
                }
                // error response
                else {
                let json = try? JSONSerialization.jsonObject(with: _data as! Data, options: [])
                 homeScreenDelegate.showAlert(message: "Response is corrupted\nPlease try again.")
                }
     }
 
 func onError(_error: Error) {
    homeScreenDelegate.showAlert(message: "Request has been failed\nPlease try again later.")
 }
 
 
 }

