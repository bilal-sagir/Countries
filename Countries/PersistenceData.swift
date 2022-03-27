//
//  PersistenceData.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import Foundation

class PersistenceData{
    static let docsUrl = try! FileManager.default.url(for: .documentDirectory,
                                                         in: .userDomainMask,
                                                         appropriateFor: nil,
                                                         create: false)
    
    static let dataFile = docsUrl.appendingPathComponent("favorites.plist")
    
    class func write(){
        guard let items = SCTransfer.instance.countries else { return }
        
        do{
            let arch = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
            try arch.write(to: dataFile)
        }catch{
            print(error)
        }
    }
    
    class func read(){
        let data = try? Data(contentsOf: dataFile)
        
        if data == nil {
            SCTransfer.instance.countries = []
            return
        }
        
        do{
            if let readArr = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? Array<Country>{
                SCTransfer.instance.countries = readArr
            }
        }catch{
            SCTransfer.instance.countries = []
            print(error)
        }
    }
}

