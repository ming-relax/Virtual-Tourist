//
//  Pin.swift
//  Virtual Tourist
//
//  Created by Ming Hu on 7/10/16.
//  Copyright © 2016 Ming Hu. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class Pin: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

}

extension Pin: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude as! CLLocationDegrees, longitude: longitude as! CLLocationDegrees)
        }
    }
}