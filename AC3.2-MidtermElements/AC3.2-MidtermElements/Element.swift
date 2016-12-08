//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Marcel Chaucer on 12/8/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import Foundation

class Element {
    let weight: Double
    let name: String
    let number: Int
    let symbol: String
    let melting_c: Int
    let boiling_c: Int
    let density: Double
    let crust_percent: Double
    let discovery_year: String
    let group: Int
    let electrons: String
    let ion_energy: Double
    
    init(from dictionary: [String:Any])  {
        self.weight = dictionary["weight"] as? Double ?? 0.0
        self.name = dictionary["name"] as? String ?? ""
        self.number = dictionary["number"] as? Int ?? 0
        self.symbol = dictionary["symbol"] as? String ?? ""
        self.melting_c = dictionary["melting_c"] as? Int ?? 0
        self.boiling_c = dictionary["boiling_c"] as? Int ?? 0
        self.density = dictionary["density"] as? Double ?? 0.0
        self.crust_percent = dictionary["crust_percent"] as? Double ?? 0.0
        self.discovery_year = dictionary["discovery_year"] as? String ?? ""
        self.group = dictionary["group"] as? Int ?? 0
        self.electrons = dictionary["electrons"] as? String ?? ""
        self.ion_energy = dictionary["ion_energy"] as? Double ?? 0.0
}

    static func getElements(from: Data?) -> [Element]? {
        var allTheElements = [Element]()
        let data = try? JSONSerialization.jsonObject(with: from!, options: [])
        guard let validJson = data as? [[String: Any]] else { return nil }
        
        for element in validJson {
            allTheElements.append(Element(from: element))
        }
        return allTheElements
    }
}
