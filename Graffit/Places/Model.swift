//
//  Model.swift
//  Graffit
//
//  Created by Zachary Cheshire on 3/14/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit
import CoreLocation
let model = Model()
class Model: NSObject {
    private var postArray: [Place]
    
    override init() {
        self.postArray = []
    
        super.init()
    }
    //1
    class var sharedInstance: Model {
        //2
        struct Singleton {
            //3
            static let instance = Model()
        }
        //4
        return Singleton.instance
    }
    
    func addPost(place: Place) -> Void {
        postArray.append(place)
    }
    func getPost() -> [Place] {
        return postArray
    }
    func setPost(location: CLLocationCoordinate2D) -> Void {
        //postArray.removeAll()
        let placesLoader = PlacesLoader()
        placesLoader.loadPost(location: location)
        
    }

}
