/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import CoreLocation
class Place: ARAnnotation {
   private let id: String
   private let creator: String
   private let longitude: Double
   private let latitude: Double
   private var text: String?
   private let locationn: CLLocationCoordinate2D
    private let anoLocation: CLLocation
    
    var infoText: String {
        get {
            var info = "id: \(id)"
            
            if text != nil {
                info += "\nText: \(text!)"
            }
            
            if creator != nil {
                info += "\nUser: \(creator)"
            }
            return info
        }
    }
    
    init(id: String, creator: String, longitude: Double, latitude: Double, text: String ) {
        self.id = id
        self.creator = creator
        self.longitude = longitude
        self.latitude = latitude
        self.text = text
        self.locationn = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.anoLocation = CLLocation(latitude: latitude, longitude: longitude)
        super.init()
        self.location = anoLocation
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        return self.locationn
    }
    func getText() -> String {
        return self.text!
    }
    func getCreator() -> String {
        return self.creator
    }
  

  
  override var description: String {
    return infoText
  }
}
