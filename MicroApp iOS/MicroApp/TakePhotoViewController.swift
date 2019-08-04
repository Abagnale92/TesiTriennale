//
//  TakePhotoViewController.swift
//  MicroApp
//
//  Created by Group1 on 11/07/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit

class TakePhotoViewController: UIViewController, ComponentController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if !photoToken {
            takePhoto()
        }
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
    
    func takePhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get picked image from info dictionary
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        photoToken = true
        // Memorizza foto
        // Take image picker off the screen
        // dismiss(animated: true, completion: nil)
    }
    
    func setInputsData(_ dataCollection: InputDataCollection) {
        
    }
    
    func getOutputData() -> OutputDataCollection? {
        var output = OutputDataCollection()
        output.addData(image, ofType: DataType.IMAGE)
        return output
    }
    
    var type = ComponentType.TAKEPHOTO
    var inputTypes: [String: DataType] = [:]
    var outputTypes = [DataType.IMAGE]
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]
    
    var image = UIImage()
    var photoToken = false
    
}
