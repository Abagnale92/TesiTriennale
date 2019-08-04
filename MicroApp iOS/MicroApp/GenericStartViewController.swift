//
//  GenericStartViewController.swift
//  MicroApp
//
//  Created by Group1 on 18/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit

class GenericStartViewController: UIViewController, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        string = "Hello, world!"
        dataLabel.text = string as String
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
    
    func setInputsData(_ dataCollection: InputDataCollection) {
        string = dataCollection.getData(named: "string")?[0] as! NSString
    }
    
    func getOutputData() -> OutputDataCollection? {
        if textField.hasText {
            string = textField.text! as NSString
        } else {
            string = "Hello, world!"
        }
        var output = OutputDataCollection()
        output.addData(string, ofType: DataType.STRING)
        return output
    }
    
    var type = ComponentType.GENERICSTART
    var inputTypes: [String: DataType] = [:]
    var outputTypes = [DataType.STRING]
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]
    
    var string = NSString()
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
}
