//
//  ViewControllerMain.swift
//  Graffit
//
//  Created by Zachary Cheshire on 2/15/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class ViewControllerMain: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var locationn = CLLocation()
    var manager = CLLocationManager()

    @IBOutlet weak var postTextField: UITextField!
    
    @IBAction func post(_ sender: Any) {
        let user = User()
        
        
        user.createPost(postText: postTextField.text!, coordinate: locationn)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        // longitude = locations[0].coordinate.longitude
         //latitude = locations[0].coordinate.latitude
        print("hey")
        print(locations[0].coordinate.longitude)
        print(locations[0].coordinate.latitude)
        let coordinate2 = CLLocation(latitude: locations[0].coordinate.longitude, longitude:locations[0].coordinate.latitude)
        let coordinate₀ = CLLocation(latitude: 5.0, longitude: 5.0)
        //let coordinate₁ = CLLocation(latitude: 5.0, longitude: 3.0)
        locationn = coordinate2
        let distanceInMeters = coordinate₀.distance(from: coordinate2)
        print(distanceInMeters)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
