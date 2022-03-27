//
//  SavedVC.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import UIKit

class SavedVC: UIViewController {
    
    @IBOutlet weak var countriesTableView: UITableView!
    
    private let cellSpacing: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoreDataHelpers.retrieveList()
        countriesTableView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Delegations and DataSource

extension SavedVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let countries = SCTransfer.instance.countries else { return 0}
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
        
        cell.textLabel?.text = SCTransfer.instance.countries![indexPath.section].name
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        
        
        cell.buttonPressed = { [weak self] in
            guard self != nil else { return }
            
            guard var favs = SCTransfer.instance.countries else { return }
            CoreDataHelpers.delete(country: favs[indexPath.section])
            favs = favs.filter{$0 != favs[indexPath.section] }
            tableView.reloadData()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SCTransfer.instance.country = SCTransfer.instance.countries![indexPath.section]
    }
}

