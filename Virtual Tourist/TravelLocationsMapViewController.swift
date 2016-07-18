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
        mapView.delegate = self
        
        loadAllPins()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizerState.Ended {
            return
        }
    
        print("handleLongPress")
        
        let touchPoint = gestureRecognizer.locationInView(self.mapView)
        let mapCoordinate = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        addPin(mapCoordinate)
        
    }
    
    func loadAllPins() {
        let coreDataStack = appDelegate.coreDataStack
        let managedContext = coreDataStack.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Pin")
        
        do {
            
            let pins = try managedContext.executeFetchRequest(fetchRequest)
            for pin in pins {
                addPin(pin.coordinate)
             }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func addPin(coordinate: CLLocationCoordinate2D) {
        // Save the pin
        let coreDataStack = appDelegate.coreDataStack
        let managedContext = coreDataStack.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Pin",inManagedObjectContext:managedContext)!
        let pin = Pin(entity: entity, insertIntoManagedObjectContext: managedContext)
        pin.latitude = coordinate.latitude
        pin.longitude = coordinate.longitude
        coreDataStack.saveMainContext()
        
        // Draw the pin on the map
        self.mapView.addAnnotation(pin)
    }

}

extension TravelLocationsMapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Pin {
            let identifier = "\(annotation.latitude!)" + "\(annotation.longitude!)"
            
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let pin = view.annotation as! Pin
        print(pin)
    }
}

