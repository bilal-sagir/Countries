//
//  DetailVC.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cLbl: UILabel!
    
    private var country: Country!
    private var flag: String = ""{
        didSet{
            print(flag)
        }
    }
    private var wikiDataId: String = ""{
        didSet{
            print(wikiDataId)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        country = SCTransfer.instance.country
        cLbl.text = "Countrycode: \(country.code!)"
        navigationItem.title = country.name
        
        Apicall.fetchCountries(code: country.code!) { dto in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.flag = dto.data.flagImageURI
                self.wikiDataId = dto.data.wikiDataID
            }
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
    }
}
