//
//  SaveViewController.swift
//  MicroApp
//
//  Created by Group1 on 08/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import ContactsUI

class SaveViewController: UIViewController, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        saveData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func saveData() {
        if objects != nil {
            for object in objects! {
                let objClass = String (describing: type(of: object))
                switch objClass {
                // case DataType.CONTACT:
                case DataType.STRING.rawValue:
                    let text = String(object as! String)
                    let filePath = documentsUrl.appendingPathComponent("string.txt")
                    try? text?.write(to: filePath, atomically: false, encoding: String.Encoding.utf8)
                // case DataType.LOCATION:
                case DataType.IMAGE.rawValue:
                    let data = UIImageJPEGRepresentation(object as! UIImage, 1)
                    let filePath = documentsUrl.appendingPathComponent("image.JPG")     // sovrascrive file omonimo?
                    try? data?.write(to: filePath)
                // case DataType.URI:
                default:
                    break
                }
            }
        }
    }
    
    func setInputsData(_ dataCollection: InputDataCollection) {
        objects = dataCollection.getData(named: "data")
    }
    
    func getOutputData() -> OutputDataCollection? {
        return nil
    }
    
    var type = ComponentType.SAVE
    var inputTypes = ["data": DataType.OBJECT]
    var outputTypes: [DataType] = []
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: true, StateType.PROGRESS: true]
    
    var objects: [AnyObject]?
    var documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
}
