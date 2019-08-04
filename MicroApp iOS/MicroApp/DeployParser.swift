//
//  DeployParser.swift
//  MicroApp
//
//  Created by Group1 on 18/07/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import Foundation
import UIKit.UIStoryboard


class DeployParser: NSObject, XMLParserDelegate {
    
    var components = [Component]()
    
    func getComponents(from filePath: URL) -> [Component]? {
        var xmlString = String()
        do {
            xmlString = try String(contentsOf: filePath, encoding: String.Encoding.utf8)
        }
        catch {
            // errore
        }
        let xmlData = xmlString.data(using: String.Encoding.utf8)!
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        parser.parse()
        
        print("Ecco le componenti:")
        print(components)
        
        let graph = createGraph()
        print("Ecco i vertici del grafo:")
        print(graph.vertices)
        print("Ecco gli archi del grafo:")
        print(graph.edges)
        
        return graph.topologicalSort()
    }
    
    func createGraph() -> Graph<Component> {
        let graph = UnweightedGraph<Component>()
        for comp in components {
            _ = graph.addVertex(comp)
        }
        for comp in components {
            for destID in comp.outputReceivers {
                if let destComp = components.first(where: { $0.id == destID }) {
                    graph.addEdge(from: comp, to: destComp, directed: true)
                }
            }
        }
        return graph
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "component" {
            let compID = attributeDict["id"]!
            let compType = ComponentType(rawValue: attributeDict["type"]!)!
            let compState = StateType(rawValue: attributeDict["state"]!)!
            components.append(Component(id: compID, type: compType, state: compState))
        }
        if elementName == "input" {
            let dataName = attributeDict["dataname"]!
            let sendID = attributeDict["id"]!
            components.last?.addInputSender(compID: sendID, dataName: dataName)
        }
        if elementName == "output" {
            let destID = attributeDict["id"]!
            components.last?.addOutputReceiver(compID: destID)
        }
    }
    
}
