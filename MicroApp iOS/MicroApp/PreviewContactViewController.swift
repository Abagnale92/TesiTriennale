//
//  PreviewContactViewController.swift
//  MicroApp
//
//  Created by Group1 on 07/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import ContactsUI

class PreviewContactViewController: UIViewController, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        previewContact()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func previewContact() {
        firstNameLabel.text = contact.givenName
        middleNameLabel.text = contact.middleName
        lastNameLabel.text = contact.familyName
        nicknameLabel.text = contact.nickname
        phoneNumberLabel.text = contact.phoneNumbers[0].label
        emailAddressLabel.text = contact.emailAddresses[0].label
        if contact.imageDataAvailable {
            contactImageView.image = UIImage(data: contact.imageData!)
        }
    }
    
    func setInputsData(_ dataCollection: InputDataCollection) {
        contact = dataCollection.getData(named: "contact")?[0] as! CNContact
    }
    
    func getOutputData() -> OutputDataCollection? {
        var output = OutputDataCollection()
        output.addData(contact, ofType: DataType.CONTACT)
        return output
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    */
    
    var type = ComponentType.PREVIEWCONTACT
    var inputTypes = ["contact": DataType.CONTACT]
    var outputTypes = [DataType.CONTACT]
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]
    
    var contact = CNContact()
    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var middleNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var emailAddressLabel: UILabel!
    @IBOutlet var contactImageView: UIImageView!

}
