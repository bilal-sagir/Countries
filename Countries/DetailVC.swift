//
//  DetailVC.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var country: Country!
    private var flag: String = ""{
        didSet{
            self.imgView.kf.setImage(with: URL(string: flag), options: [.processor(SVGImgProcessor())])
            spinner.stopAnimating()
        }
    }
    private var wikiDataId: String = ""{
        didSet{
            print(wikiDataId)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
        country = SCTransfer.instance.country
        cLbl.attributedText = attString(t1: "Country Code: ", t2: country.code)
        
        
        
        navigationItem.title = country.name
        
        Apicall.fetchCountries(code: country.code!) { dto in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.flag = dto.data.flagImageURI
                self.wikiDataId = dto.data.wikiDataID
            }
        }

    }
    
    func attString(t1: String, t2: String) -> NSMutableAttributedString {
        let boldText = t1
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        let normalText = t2
        let normalString = NSMutableAttributedString(string:normalText)

        attributedString.append(normalString)
        return attributedString
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
    }
}
