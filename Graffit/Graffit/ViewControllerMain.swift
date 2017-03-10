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
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var manager = CLLocationManager()
    var locationArray = [CLLocation] ()

    @IBOutlet weak var userGreeting: UILabel!
    @IBOutlet weak var postTextField: UITextField!
    
    @IBAction func post(_ sender: Any) {
        print(user.userToken, "is")
        print(user.userToken)
        
        user.createPost(postText: postTextField.text!, longitude: longitude, latitude: latitude, token: user.userToken)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userGreeting.text = "Hello \(user.currentUserName)"
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
        latitude = locations[0].coordinate.latitude
        longitude = locations[0].coordinate.longitude
        let coordinate2 = CLLocation(latitude: latitude, longitude: longitude)
        let coordinate₀ = CLLocation(latitude: 5.0, longitude: 5.0)
        let coordinate₁ = CLLocation(latitude: 5.0, longitude: 3.0)
        let distanceInMeters = coordinate₀.distance(from: coordinate2)
        print(distanceInMeters)
        checkCoordinates(currentLocation: coordinate2, locationArray: locationArray)
    }
    
    func checkCoordinates(currentLocation: CLLocation, locationArray: [CLLocation]) -> [CLLocation] {
        var coordinatesToView: [CLLocation] = locationArray
        for post in locationArray {
            let distanceInMeters = currentLocation.distance(from: post)
            if distanceInMeters < 0.0001 {
                
                coordinatesToView.append(post)
                
            }
            
        }
        return coordinatesToView
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
