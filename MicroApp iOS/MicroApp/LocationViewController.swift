//
//  LocationViewController.swift
//  MicroApp
//
//  Created by Group1 on 08/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate,UINavigationControllerDelegate, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getLocation()
        showLocation()
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
    
    func getLocation() {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            self.openAlertToSettings(title: "Location in use disabled.", description: "To enable location change it in Settings.")
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            location = locationManager.location!
            
            break
        }
    }
    
    func showLocation() {
        latitude.text = location.coordinate.latitude.description
        longitude.text = location.coordinate.longitude.description
        altitude.text = location.altitude.description
    }
    
    private func openAlertToSettings(title: String, description: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        _ = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let openAction = UIAlertAction(title: "Open Settings", style: .default) {
            (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setInputsData(_ dataCollection: InputDataCollection) { }
    
    func getOutputData() -> OutputDataCollection? {
        var output = OutputDataCollection()
        output.addData(location, ofType: DataType.LOCATION)
        return output
    }
    
    var type = ComponentType.LOCATION
    var inputTypes: [String: DataType] = [:]
    var outputTypes: [DataType] = [DataType.LOCATION]
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: true, StateType.PROGRESS: true]
    
    var location = CLLocation()
    
    @IBOutlet var altitude: UILabel!
    @IBOutlet var latitude: UILabel!
    @IBOutlet var longitude: UILabel!
    
}
