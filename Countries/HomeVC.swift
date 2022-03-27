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
        
        API.fetchCountries { [weak self] (countryList) in
            self!.countries = countryList
            
            DispatchQueue.main.async {
                self!.countriesTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoreDataHelpers.retrieveList()
        countriesTableView.reloadData()
        
        tabBarController?.tabBar.isHidden = false
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
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        if let favs = SCTransfer.instance.countries {
            if favs.contains(where: { $0.code == countries[indexPath.section].code }) {
                cell.FavButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }else{
                cell.FavButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
        
        cell.buttonPressed = { [weak self] in
            guard let self = self else { return }
            guard var favs = SCTransfer.instance.countries else { return }

            if favs.contains(where: { $0.code == self.countries[indexPath.section].code })
            {
                CoreDataHelpers.delete(country: self.countries[indexPath.section])
                favs = favs.filter{$0 != self.countries[indexPath.section]}
                cell.FavButton.setImage(UIImage(systemName: "star"), for: .normal)
        
            }else{
                favs.append(self.countries[indexPath.section])
                CoreDataHelpers.save(country: self.countries[indexPath.section])
                cell.FavButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
            CoreDataHelpers.retrieveList()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        SCTransfer.instance.country = countries[indexPath.section]
    }
}


