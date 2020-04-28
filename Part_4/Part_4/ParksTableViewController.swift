//
//  ParksTableViewController.swift
//  Part_4
//
//  Created by catie on 4/23/20.
//  Copyright © 2020 cmp5987. All rights reserved.
//

import UIKit
import CoreLocation

class ParksTableViewController: UITableViewController,  CLLocationManagerDelegate{


    @IBOutlet var table: UITableView!
    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    
    var locationManager = CLLocationManager()
    var selectedRow:Int = -1
    
    var allParks = Parks()
    //var locationManager = CLLocationManager()
    var parkList : [Park] { //front end for LandmarkList model object
        get {
            return self.allParks.parkList
        }
        set(val) {
            self.allParks.parkList = val
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        self.tableView.reloadData()
    }
    
    //table view overrides
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "parkCell")
        let park = parkList[indexPath.row]
        let parkDistance = getDistanceInMiles(parkLocation: park.getLocation())
        
        cell.textLabel?.text = park.getParkName()
        cell.detailTextLabel?.text = String(format: "Distance: %.2f miles", parkDistance)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let dog = dogs[indexPath.row]
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    //supplemental functions
    func getDistanceInMiles(parkLocation:  CLLocation) -> Double{
        let userLocation = locationManager.location
        let distance = parkLocation.distance(from: userLocation!)
        let distanceMiles = distance *  0.000621371192
        return distanceMiles
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView:DetailedTableViewController = segue.destination as! DetailedTableViewController
        
        selectedRow = table.indexPathForSelectedRow!.row
        let park = parkList[selectedRow]
        
        detailView.setPark(inPark: park)
    }
    
    
    //Event Listeners
    @IBAction func segmentedForSorting(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
                    case 0:
                        parkList.sort(by: {$0.getParkName() < $1.getParkName()})  // sorting A-Z
                        tableView.reloadData()
                    case 1:
                        parkList.sort(by: {$0.getParkName() > $1.getParkName()})  // sorting Z-A
                        tableView.reloadData()
            
                    case 2:
                        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // best accuracy
                        locationManager.startUpdatingLocation()

                        for p in parkList {
                            p.set(dist: Float(getDistanceInMiles(parkLocation: p.getLocation())))
                        }
                        parkList.sort(by: {$0.getDistance() < $1.getDistance()})
                        tableView.reloadData()
                    default:
                        parkList.sort(by: {$0.getParkName() < $1.getParkName()})  // sorting A-Z
                        tableView.reloadData()
                    }

    }
}
