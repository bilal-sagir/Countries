//
//  CoreDataHelpers.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelpers{
    
    static func save(country: Country){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "CountryCore", in: context) else { return }
            let fetchRequest = NSFetchRequest<CountryCore>(entityName: "CountryCore")
            
            do{
                let countries = try context.fetch(fetchRequest)
                let found = countries.contains(where: { $0.code == country.code })
                
                if found{
                    return
                }
                
                let newCountry = NSManagedObject(entity: entityDescription, insertInto: context)
                newCountry.setValue(country.name, forKey: "name")
                newCountry.setValue(country.code, forKey: "code")
                
                try context.save()
                print("Saved")
                
            }catch{
                print("eror")
            }
        }
    }
    
    static func retrieveList(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<CountryCore>(entityName: "CountryCore")
            
            var array = [Country]()
            
            do{
                let results = try context.fetch(fetchRequest)
                
                for i in results {
                    array.append(Country(name: i.name!, code: i.code!))
                }
                
                SCTransfer.instance.countries = array
                print("Retrieve")
            }catch{
                print("Could not retrieve")
            }
        }
    }
    
    static func delete(country: Country){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<CountryCore>(entityName: "CountryCore")
            
            do{
                let countries = try context.fetch(fetchRequest)
                
                for i in countries{
                    let found = i.code == country.code
                    if found{
                        context.delete(i)
                    }
                }
                
                var array = [Country]()  //writing deleted array to singleton array
                let new = try context.fetch(fetchRequest)
                for k in new{
                    array.append(Country(name: k.name!, code: k.code!))
                }
                SCTransfer.instance.countries = array
                
                try context.save()
                print("Saved delete")
                
            }catch{
                print("eror")
            }
        }
        
    }
}
