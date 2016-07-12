//
//  ViewController.swift
//  Virtual Tourist
//
//  Created by Ming Hu on 7/10/16.
//  Copyright © 2016 Ming Hu. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class TravelLocationsMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizerState.Ended {
            return
        }
        
        let coreDataStack = appDelegate.coreDataStack
        let managedContext = coreDataStack.managedObjectContext

        let entity = NSEntityDescription.entityForName("Person",inManagedObjectContext:managedContext)!
        let pin = Pin(entity: entity, insertIntoManagedObjectContext: managedContext)
        pin.latitude = 10.0
        pin.longitude = 200.0
        coreDataStack.saveMainContext()
        
    }

}

