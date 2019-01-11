//
//  ViewController.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 10/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import UIKit
import Reachability

class MainViewController: UIViewController {
    
    //MARK: Variables
    var dataTableView: UITableView!
    let cellIdentifier = "cell"
    var viewRefresh: UIRefreshControl!
    var activityIndicator: UIActivityIndicatorView!
    var dataArray: [DataModel] = []
    var apiCall: ApiCall!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setView()
        apiCall = ApiCall()
        apiCall.delegate = self
        getData()
    }
    
    //MARK: UISetup
    func setView(){
        dataTableView = UITableView()
        dataTableView.register(DataTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.rowHeight = 150
        dataTableView.rowHeight = UITableView.automaticDimension
        dataTableView.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        dataTableView.translatesAutoresizingMaskIntoConstraints = false
        viewRefresh = UIRefreshControl()
        viewRefresh.attributedTitle = NSAttributedString(string: "Pull down to Refresh")
        viewRefresh.addTarget(self, action: #selector(refreshHandler(_:)), for: .valueChanged)
        self.view.addSubview(dataTableView)
        self.dataTableView.addSubview(viewRefresh)
        constraintsToTableView()
        setActivityIndicator()
    }

    func constraintsToTableView(){
        dataTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dataTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dataTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dataTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func setActivityIndicator(){
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.darkGray
        activityIndicator.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        self.dataTableView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func refreshHandler(_ sender: UIRefreshControl){
        getData()
    }
    
    func updateUI(_ data: NSDictionary){
        
    }
    
    func getData(){
        if isDeviceReachable(){
            activityIndicator.startAnimating()
            apiCall.requestData(URLString.dataURLString)
        }else{
            DispatchQueue.main.async {
                weak var weakSelf = self
                weakSelf?.activityIndicator.stopAnimating()
                weakSelf?.discoverAlert("Connection Failed", "Please connect to Internet")
            }
        }
    }
}

//MARK: TableView function extension.
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? DataTableViewCell
        if cell == nil{
            cell = DataTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: AlertView.
extension MainViewController{
    func discoverAlert(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            weak var weakSelf = self
            if weakSelf?.viewRefresh.isRefreshing ?? true{
                weakSelf?.viewRefresh.endRefreshing()
            }
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: API Call back.
extension MainViewController: ApiCallDelegate{
    func didRecieveResponse(_ data: NSDictionary?, _ code: Int?, _ error: Error?) {
        if error == nil{
            if let data = data{
                updateUI(data)
            }
        }else{
            DispatchQueue.main.async {
                weak var weakSelf = self
                weakSelf?.activityIndicator.stopAnimating()
                weakSelf?.discoverAlert("API CALL Error", error?.localizedDescription ?? "")
            }
        }
    }
}

//MARK: Reachability check.
extension MainViewController{
    func isDeviceReachable() -> Bool{
        let reachability = Reachability()
        if reachability?.connection.description != "No Connection"{
            return true
        }else{
            return false
        }
    }
}

