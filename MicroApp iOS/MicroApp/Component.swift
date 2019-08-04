//
//  ComponentStruct.swift
//  MicroApp
//
//  Created by Roberto on 05/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import Foundation
import UIKit

class Component: Equatable {
    
    let controller: ComponentController
    let id: String
    let state: StateType
    
    // dati ricevuti in input
    var inputData: InputDataCollection
    // id comp. mittente / nomi dei dati ricevuti in input da quel mittente
    var inputSenders: [String: [String]]
    // id comp. destinatarie dell'output
    var outputReceivers: [String]
    
    init (id: String, type: ComponentType, state: StateType) {
        self.id = id
        let storyboard = UIStoryboard(name: "MicroApplication", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: (type.rawValue)) as! ComponentController
        self.state = state
        inputSenders = [String: [String]]()
        outputReceivers = [String]()
        inputData = InputDataCollection()
    }
    
    func getViewController() -> UIViewController {
        return controller as! UIViewController
    }
    
    func getInputTypes() -> [String: DataType] {
        return controller.inputTypes
    }
    
    func getOutputTypes() -> [DataType] {
        return controller.outputTypes
    }
    
    func addInputSender(compID: String, dataName: String) {
        if inputSenders[compID] != nil {
            inputSenders[compID]!.append(dataName)
        } else {
            inputSenders[compID] = [dataName]
        }
    }
    
    func addOutputReceiver(compID: String) {
        outputReceivers.append(compID)
    }
    
    func putData(_ outputData: OutputDataCollection, from sendID: String) {
        // per ogni dato che deve ricevere dalla comp. mittente
        for dataName in inputSenders[sendID]! {
            // prende il tipo del dato della comp. dest. che ha quel nome
            if let dataType = controller.inputTypes[dataName] {
                // prende i dati di quel tipo dalla comp. corr.
                if let data = outputData.getData(ofType: dataType) {
                    // assegna quei dati con quel nome alla comp. dest.
                    inputData.addData(data, ofName: dataName)
                }
            }
        }
    }
    
    func setInputs() {
        for (dataName, _) in controller.inputTypes {
            if !inputData.getNames().contains(dataName) {
                return  // missing input
            }
        }
        controller.setInputsData(inputData)
    }
    
    func getOutput() -> OutputDataCollection? {
        let dataCollection = controller.getOutputData()
        if dataCollection != nil {
            for dataType in controller.outputTypes {
                if !dataCollection!.getTypes().contains(dataType) {
                    return nil  // missing output
                }
            }
        }
        return dataCollection
    }
    
    static func ==(comp1: Component, comp2: Component) -> Bool {
        return comp1.id == comp2.id
    }
    
}
