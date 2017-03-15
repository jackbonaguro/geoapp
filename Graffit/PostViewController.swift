//
//  PostViewController.swift
//  Graffit
//
//  Created by Zachary Cheshire on 3/14/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
class postViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var location = CLLocationCoordinate2D()
    private var placeCreate = PlaceCreate()
    @IBAction func submitPost(_ sender: Any) {
        
        placeCreate.createPost(user: model.getCurrentUser().currentUserName, textt: postTextField.text!,location: location)
        
        
    }
    @IBOutlet weak var postTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            let location = locations.last!
            // if location.horizontalAccuracy < 10 {
            //manager.stopUpdatingLocation()
            let currentLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.location = currentLocation
        }
    }
}
