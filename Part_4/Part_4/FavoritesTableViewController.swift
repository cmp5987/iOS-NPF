//
//  FavoritesTableViewController.swift
//  Part_4
//
//  Created by catie on 4/23/20.
//  Copyright © 2020 cmp5987. All rights reserved.
//

import UIKit
import CoreLocation

class FavoritesTableViewController: UITableViewController, CLLocationManagerDelegate {

    var allParksTable = Parks()
    var locationManager = CLLocationManager()
    var parksTable : [Park] { //front end for LandmarkList model object
        get {
            return self.allParksTable.parkList
        }
        set(val) {
            self.allParksTable.parkList = val
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
}
