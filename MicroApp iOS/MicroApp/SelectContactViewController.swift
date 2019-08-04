//
//  SelectContactViewController.swift
//  MicroApp
//
//  Created by Roberto on 05/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import ContactsUI

class SelectContactViewController: UIViewController, CNContactPickerDelegate, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        selectContact()
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
    
    func selectContact() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        self.contacts = contacts
    }
    
    func setInputsData(_ dataCollection: InputDataCollection) {
        
    }
    
    func getOutputData() -> OutputDataCollection? {
        var output = OutputDataCollection()
        output.addData(contacts, ofType: DataType.CONTACT)
        return output
    }
    
    var type = ComponentType.SELECTCONTACT
    var inputTypes: [String: DataType] = [:]
    var outputTypes = [DataType.CONTACT]
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]
    
    var contacts = [CNContact]()

}
