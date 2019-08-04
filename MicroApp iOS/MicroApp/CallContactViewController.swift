//
//  CallContactViewController.swift
//  MicroApp
//
//  Created by Group1 on 07/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import ContactsUI

class CallContactViewController: UIViewController, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        callContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callContacts() {
        for contact in contacts {
            if let numberLabel = contact.phoneNumbers[0].label {
                if let number = URL(string: "tel://" + numberLabel){
                    UIApplication.shared.open(number)
                }
            }
        }
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
        contacts = dataCollection.getData(named:"contact") as! [CNContact]
    }
    
    func getOutputData() -> OutputDataCollection? {
        return nil
    }
    
    var type = ComponentType.CALLCONTACT
    var inputTypes = ["contact": DataType.CONTACT]
    var outputTypes: [DataType] = []
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]
    
    var contacts = [CNContact]()

}
