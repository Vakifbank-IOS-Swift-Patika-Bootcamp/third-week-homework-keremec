//
//  DevlistVC.swift
//  techCompanyApp
//
//  Created by Kerem Safa Dirican on 17.11.2022.
//

import UIKit

class DevlistVC: UIViewController {
    
    weak var company: TechCompany?
    var devNames = [String]()
    var filteredNames = [String]()

    @IBOutlet weak var devTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        devTableView.delegate = self
        devTableView.dataSource = self
        for i in company!.developers{
            devNames.append(i.name)
        }
        filteredNames = devNames
    }

}


extension DevlistVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell", for: indexPath)
        
        let dev = filteredNames[indexPath.row]
        
        cell.textLabel?.text = dev
        
        return cell
    }
    
    
    
}


extension DevlistVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNames = devNames.filter({$0.contains(searchText)})
        if filteredNames.count == 0{
            filteredNames = devNames
        }
        devTableView.reloadData()
    }
}
