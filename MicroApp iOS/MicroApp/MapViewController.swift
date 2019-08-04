//
//  MapViewController.swift
//  MicroApp
//
//  Created by Group1 on 08/09/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, ComponentController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        showMap()
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
    
    func showMap() {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setInputsData(_ dataCollection: InputDataCollection) {
        location = dataCollection.getData(named: "location")?[0] as! CLLocation
    }
    
    func getOutputData() -> OutputDataCollection? {
        return nil
    }
    
    var type = ComponentType.MAP
    var inputTypes = ["location": DataType.LOCATION]
    var outputTypes: [DataType] = []
    let statesAvailable = [StateType.VISIBLE: true, StateType.HIDDEN: false, StateType.PROGRESS: false]
    
    var location = CLLocation()

    @IBOutlet var mapView: MKMapView!
    
}
