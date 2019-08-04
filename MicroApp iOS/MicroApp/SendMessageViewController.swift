//
//  SendMessageViewController.swift
//  MicroApp
//
//  Created by Group1 on 08/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import MessageUI
import ContactsUI

class SendMessageViewController: UIViewController, MFMessageComposeViewControllerDelegate, ComponentController  {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sendMessage()
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
    
    func sendMessage() {
        if MFMessageComposeViewController.canSendText() {
            let messComposeVC = MFMessageComposeViewController()
            messComposeVC.messageComposeDelegate = self
            var numbers = [String]()
            for contact in contacts {
                numbers.append(contact.phoneNumbers[0].value.stringValue)
            }
            messComposeVC.recipients?.append(contentsOf: numbers)
            // Present the view controller modally.
            self.present(messComposeVC, animated: true, completion: nil)
        } else {
            print("SMS services are not available")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        
        // Check the result or perform other tasks.
        
        // Dismiss the message compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func setInputsData(_ dataCollection: InputDataCollection) {
        contacts = dataCollection.getData(named: "contact") as! [CNContact]
    }
    
    func getOutputData() -> OutputDataCollection? {
        return nil
    }
    
    var type = ComponentType.SENDMESSAGE
    var inputTypes = ["contact": DataType.CONTACT]
    var outputTypes: [DataType] = []
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]
    
    var contacts = [CNContact]()
    
}
