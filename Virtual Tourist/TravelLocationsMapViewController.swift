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

        // add pins to map
        mapView.delegate = self

        loadAllPinsToMap()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        
        // set back button
        let backButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButtonItem
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
    
    func loadAllPinsToMap() {
        let coreDataStack = appDelegate.coreDataStack
        let managedContext = coreDataStack.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Pin")
        
        do {
            
            let pins = try managedContext.executeFetchRequest(fetchRequest) as! [Pin]
            print(pins.count)
            
            for pin in pins {
                self.mapView.addAnnotation(pin)
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
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("PhotoAlbum") as! PhotoAlbumViewController
        vc.pin = pin
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

