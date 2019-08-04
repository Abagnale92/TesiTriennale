//
//  PreviewImageViewController.swift
//  MicroApp
//
//  Created by Group1 on 11/07/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit

class PreviewImageViewController: UIViewController, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        showImage()
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
    
    func showImage() {
        preview.image = image
    }
    
    func setInputsData(_ dataCollection: InputDataCollection) {
        image = dataCollection.getData(named: "image")?[0] as! UIImage
    }
    
    func getOutputData() -> OutputDataCollection? {
        var output = OutputDataCollection()
        output.addData(image, ofType: DataType.IMAGE)
        return output
    }
    
    @IBOutlet var preview: UIImageView!
    
    var type = ComponentType.PREVIEWIMAGE
    var inputTypes = ["image": DataType.IMAGE]
    var outputTypes = [DataType.IMAGE]
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]
    
    var image = UIImage()
    
}
