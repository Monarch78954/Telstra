//
//  ViewController.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 10/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Variables
    var dataTableView: UITableView!
    let cellIdentifier = "cell"
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setView()
        
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
        self.view.addSubview(dataTableView)
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
        activityIndicator.translatesAutoresizingMaskIntoConstraints = true
        activityIndicator.startAnimating()
        self.dataTableView.addSubview(activityIndicator)
//        activityIndicator.centerXAnchor.constraint(equalTo: dataTableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: dataTableView.centerYAnchor).isActive = true
    }
}

//MARK: TableView function extension
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
}

