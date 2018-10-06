//
//  ViewController.swift
//  NagwaIosTask
//
//  Created by Ahmed Fitoh on 10/6/18.
//  Copyright © 2018 Nagwa. All rights reserved.
//

import UIKit


protocol HomeScreenDelegate {
    func reloadTable ()
    func stopSpinnerAnimation ()
    func showAlert (message : String)
}

class HomeScreen: UIViewController  , UITableViewDataSource , UITableViewDelegate , HomeScreenDelegate {
  
    @IBOutlet weak var repoTableView: UITableView!

    lazy var homeScreenPresenter  = HomeScreenPresenter(delegate: self)
    lazy var presenter : PresenterOperationDelegate? = homeScreenPresenter
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.loadCache()
    }
    
    func setupUI () {
        repoTableView.tableFooterView = UIView()
        navigationItem.title = "JeffreyWay Repos"
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Nagwa Ios Task", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Table Datasource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCellCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell") as! HomeScreenGroupCell
      let groupData = presenter!.getDataBy(indexPath: indexPath)
      cell.configureCell(input: groupData)
      return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         if indexPath.row == presenter?.lastIndex {
         spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
         tableView.tableFooterView = spinner
         tableView.tableFooterView?.isHidden = false
         spinner.startAnimating()
         self.presenter?.loadMore()
         }
        
    }
    func reloadTable (){
        repoTableView?.reloadData()
    }
    func stopSpinnerAnimation () {
        spinner.stopAnimating()
    }
}
