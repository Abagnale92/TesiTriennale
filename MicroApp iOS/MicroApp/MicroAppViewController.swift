//
//  MicroAppViewController.swift
//  MicroApp
//
//  Created by Group1 on 24/07/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit

class MicroAppViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let parser = DeployParser()
        if let sortedComponents = parser.getComponents(from: filePath) {
            components = sortedComponents
        }
        showCurrentComponent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
        }
        showCurrentComponent()
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let currentComp = components[currentIndex]
        if let dataCollection = currentComp.getOutput() {
            for destID in currentComp.outputReceivers {
                let destComp = components.first(where: { $0.id == destID })
                destComp?.putData(dataCollection, from: currentComp.id)
            }
        }
        if currentIndex < components.count - 1 {
            currentIndex += 1
            components[currentIndex].setInputs()
            showCurrentComponent()
        } else {
            self.dismiss(animated: true, completion: nil)
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
    
    func showCurrentComponent() -> Void {
        let currentController = components[currentIndex].getViewController()
        self.addChildViewController(currentController)
        currentController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        containerView.addSubview(currentController.view)
        currentController.didMove(toParentViewController: self)
    }
    
    @IBOutlet var containerView: UIView!
    
    var components = [Component]()
    var currentIndex = 0
    var filePath: URL! = nil
    
}
