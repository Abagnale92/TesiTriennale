//
//  GenericViewController.swift
//  MicroApp
//
//  Created by Group1 on 15/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataLabel.text = string as String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataLabel.text = string as String
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        dataLabel.text = string as String
        
      
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
        print("La stringa ricevuta è", string)
    }
    
    func getOutputData() -> OutputDataCollection? {
        var output = OutputDataCollection()
        output.addData(string, ofType: DataType.STRING)
        return output
    }
    
    var type = ComponentType.GENERIC
    var inputTypes = ["string": DataType.STRING]
    var outputTypes = [DataType.STRING]
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]

    var string = NSString()
    @IBOutlet var dataLabel: UILabel!
    
}
