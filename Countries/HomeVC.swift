//
//  ViewController.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import UIKit

class HomeVC: UIViewController {

    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Apicall.fetchCountries { countryList in
            self.countries = countryList
        }
    }


}

