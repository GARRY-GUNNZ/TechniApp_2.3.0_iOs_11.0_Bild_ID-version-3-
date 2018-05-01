//
//  SeachbarViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 20/10/2017.
//  Copyright © 2017 COFELY_Technibook. All rights reserved.
//

import CloudKit
import UIKit

class SeachbarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    //   MARK: - OUTLET
    
    @IBOutlet var tableView: UITableView!
    
   // var liste:CKRecord = []
    var mesContrats = [CKRecord]()
    
    
    
    struct Cake {
        var name = String()
        var size = String()
    }
    
    
    
    
    func remplieTableview ()  {
         mesContrats = [CKRecord]()
        /*
        let privateData = CKContainer.default().privateCloudDatabase
        
 */
    }
    
    
    
    
    
    //   MARK: - VARRIABLE
    
    
    var cakes = [Cake(name: "Red Velvet", size: "Small"),
                 Cake(name: "Brownie", size: "Medium"),
                 Cake(name: "Bannna Bread", size: "Large"),
                 Cake(name: "Vanilla", size: "Small"),
                 Cake(name: "Minty", size: "Medium"),
                 Cake(name: "Red Velvet", size: "Small"),
                 Cake(name: "Brownie", size: "Medium"),
                 Cake(name: "Minty", size: "Medium")]
    
    var filteredCakes = [Cake]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //   MARK: - LIFE VIEW
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredCakes = cakes
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //   MARK: - SEARCH BAR RESULTS
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // If we haven't typed anything into the search bar then do not filter the results
        
        if searchController.searchBar.text! == "" {
            filteredCakes = cakes
        } else {
            
            // Filter the results
            filteredCakes = cakes.filter { $0.name.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tableView.reloadData()
    }
    
    //   MARK: - LIFE VIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.filteredCakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell     {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = self.filteredCakes[indexPath.row].name
        cell.detailTextLabel?.text = self.filteredCakes[indexPath.row].size
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected")
    }
    
}


