//
//  Pin+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Ming Hu on 7/10/16.
//  Copyright © 2016 Ming Hu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pin {

    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?

}
