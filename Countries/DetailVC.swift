//
//  DetailVC.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var moreInfoBut: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: - Variables
    private var country: Country!
    private var favImage: UIImage!
    
    private var flag: String = ""{
        didSet{
            self.imgView.kf.setImage(with: URL(string: flag), options: [.processor(SVGImgProcessor())])
            spinner.stopAnimating()
        }
    }
    
    private var wikiDataId: String = ""{
        didSet{
            moreInfoBut.isEnabled = true
        }
    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        moreInfoBut.isEnabled = false
        
        spinner.startAnimating()
        
        country = SCTransfer.instance.country
        
        favStarDecider()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: favImage, style: .plain, target: self, action: #selector(handleFavTapped))
        
        cLbl.attributedText = attString(t1: "Country Code: ", t2: country.code)
        navigationItem.title = country.name
        
        API.fetchCountry(code: country.code!) { dto in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.flag = dto.data.flagImageURI
                self.wikiDataId = dto.data.wikiDataID
            }
        }

    }
    
    //MARK: - Helpers
    func attString(t1: String, t2: String) -> NSMutableAttributedString {
        let boldText = t1
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        let normalText = t2
        let normalString = NSMutableAttributedString(string:normalText)

        attributedString.append(normalString)
        return attributedString
    }
    
    func favStarDecider(){
        guard let countries = SCTransfer.instance.countries else { return }
        if countries.contains(where: { $0.code == country.code }){
            favImage = UIImage(systemName: "star.fill")
        }else{
            favImage = UIImage(systemName: "star")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destinationVC = segue.destination as! WikiVC
            destinationVC.wikiCode = wikiDataId
    }
    
    @objc func handleFavTapped() {
        if favImage == UIImage(systemName: "star.fill"){
            SCTransfer.instance.countries = SCTransfer.instance.countries!.filter{$0 != country}
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
            CoreDataHelpers.delete(country: country)
            favImage = UIImage(systemName: "star")
        }else{
            SCTransfer.instance.countries?.append(country)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
            CoreDataHelpers.save(country: country)
            favImage = UIImage(systemName: "star.fill")
        }
    }
}
