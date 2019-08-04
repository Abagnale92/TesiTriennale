//
//  SendMailViewController.swift
//  MicroApp
//
//  Created by Group1 on 08/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import ContactsUI
import MessageUI
import CoreLocation

class SendMailViewController: UIViewController, MFMailComposeViewControllerDelegate, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sendMail()
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
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            var mails = [String]()
            for contact in contacts {
                mails.append(contact.emailAddresses[0].value as String)
            }
            mailComposeVC.setToRecipients(mails)
            // aggiungi allegati objects
            // aggiungi posizioni locations
            // Present the view controller modally.
            self.present(mailComposeVC, animated: true, completion: nil)
        } else {
            print("Mail services are not available")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        // Check the result or perform other tasks.
        
        // Dismiss the message compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func setInputsData(_ dataCollection: InputDataCollection) {
        contacts = dataCollection.getData(named: "contact") as! [CNContact]
        objects = dataCollection.getData(named: "attachment")!
        locations = dataCollection.getData(named: "location") as! [CLLocation]
    }
    
    func getOutputData() -> OutputDataCollection? {
        return nil
    }

    var type = ComponentType.SENDMAIL
    var inputTypes = ["contact": DataType.CONTACT, "attachment": DataType.OBJECT, "location": DataType.LOCATION]
    var outputTypes: [DataType] = []
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]
    
    var contacts = [CNContact]()
    var objects = [AnyObject]()
    var locations = [CLLocation]()
    
}
