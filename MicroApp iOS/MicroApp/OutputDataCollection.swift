//
//  OutputDataCollection.swift
//  MicroApp
//
//  Created by Group1 on 13/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import Foundation

struct OutputDataCollection {
    
    var dataCollection = [DataType: [AnyObject]]()
    
    func getData(ofType dataType: DataType) -> [AnyObject]? {
        return dataCollection[dataType]
    }
    
    func getTypes() -> [DataType] {
        return dataCollection.keys.map {
            (dataType: DataType) -> DataType in return dataType
        }
    }
    
    mutating func addData(_ data: AnyObject, ofType dataType: DataType) {
        if dataCollection[dataType] != nil {
            dataCollection[dataType]!.append(data)
        } else {
            dataCollection[dataType] = [data]
        }
    }
    
    mutating func addData(_ data: [AnyObject], ofType dataType: DataType) {
        if dataCollection[dataType] != nil {
            dataCollection[dataType]!.append(contentsOf: data)
        } else {
            dataCollection[dataType] = data
        }
    }
    
    mutating func addData(_ collection: OutputDataCollection) {
        for (dataType, data) in collection.dataCollection {
            addData(data, ofType: dataType)
        }
    }
    
}
