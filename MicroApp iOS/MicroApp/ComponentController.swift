//
//  ComponentController.swift
//  MicroApp
//
//  Created by Group1 on 26/07/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import Foundation
import UIKit

protocol ComponentController {
    
    var type: ComponentType { get set }
    var inputTypes: [String: DataType] { get }
    var outputTypes: [DataType] { get }
    var statesAvailable: [StateType: Bool] { get }
    
    func setInputsData(_ dataCollection: InputDataCollection) -> Void
    func getOutputData() -> OutputDataCollection?
    
}
