//
//  InputData.swift
//  MicroApp
//
//  Created by Group1 on 13/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import Foundation

struct InputDataCollection {
    
    var dataCollection = [String: [AnyObject]]()
    
    func getData(named name: String) -> [AnyObject]? {
        return dataCollection[name]
    }
    
    func getNames() -> [String] {
        return dataCollection.keys.map {
            (name: String) -> String in return name
        }
    }
    
    mutating func addData(_ data: AnyObject, ofName dataName: String) {
        dataCollection.updateValue([data], forKey: dataName)
    }
    
    mutating func addData(_ data: [AnyObject], ofName dataName: String) {
        dataCollection.updateValue(data, forKey: dataName)
    }
    
    mutating func addData(_ collection: InputDataCollection) {
        for (name, data) in collection.dataCollection {
            addData(data, ofName: name)
        }
    }
    
}
