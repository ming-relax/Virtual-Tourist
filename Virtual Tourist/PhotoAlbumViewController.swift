//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Ming Hu on 7/20/16.
//  Copyright © 2016 Ming Hu. All rights reserved.
//

import UIKit

class PhotoAlbumViewController: UIViewController {
    var pin: Pin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PhotoAlbumViewController did load")
        print(pin)
    }
}