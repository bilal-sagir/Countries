//
//  ViewController.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var countriesTableView: UITableView!
    
    private var countries = [Country]()
    private let cellSpacing: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Apicall.fetchCountries { [weak self] (countryList) in
            self!.countries = countryList
            
            DispatchQueue.main.async {
                self!.countriesTableView.reloadData()
            }
        }
    }
}

// MARK: - Delegations and DataSource

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: "cell") as! CountryCell
        
        cell.textLabel?.text = countries[indexPath.section].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: cell selected")
    }
    

    
    
}


