//
//  Network.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import Foundation
import Alamofire

private let headers: HTTPHeaders = [
    "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com",
    "X-RapidAPI-Key": "a19385b631msh5c25bffc7ec44cfp1cf51fjsn708549b64aa5"
]
class Apicall{
    static func fetchCountries(completionHandler: @escaping ([Country]) -> Void) {
        
        let url = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10"
        var countries = [Country]()
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CountriesDTO.self) { response in
            guard let response = response.value else { return }
            
            for i in response.data{
                countries.append(Country(name: i.name, code: i.code))
            }
            
            
            completionHandler(countries)
        }
    }
    
    static func fetchCountries(code: String, completionHandler: @escaping (CountryDetailDTO) -> Void) {
        
        let url = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(code)"
        
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CountryDetailDTO.self) { response in
            guard let response = response.value else { return }
        
            completionHandler(response)
        }
    }
    
    

    
}
