//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Ming Hu on 7/20/16.
//  Copyright © 2016 Ming Hu. All rights reserved.
//

import UIKit
import MapKit

class PhotoAlbumViewController: UIViewController {
    var pin: Pin?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pin)

        self.navigationItem.title = ""
        
        initMapRegion()
    }
    
    func initMapRegion() {
        let regionRadius: CLLocationDistance = 1000
        let region = MKCoordinateRegionMakeWithDistance(pin!.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(region, animated: true)
        
        // add the pin
        self.mapView.addAnnotation(pin!)
    }
}