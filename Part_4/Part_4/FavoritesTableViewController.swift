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

    @IBOutlet var table: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var favoriteParks : [String] = []
    var allParks = Parks()
    var selectedRow:Int = -1
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteParks = UserDefaults.standard.array(forKey: "favorites") as! [String]
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteParks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell()
        
        cell.textLabel?.text = favoriteParks[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView:DetailedTableViewController = segue.destination as! DetailedTableViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            for p in parkList {
                if p.getParkName() == favoriteParks[indexPath.row] {
                    detailView.selectedPark = p
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            favoriteParks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        var array = UserDefaults.standard.array(forKey: "favorites") as? [String]
        if array != nil {
            if (array?.contains((array?[indexPath.row])!))! {
                array!.remove(at: indexPath.row)
            }
        }
        UserDefaults.standard.set(array, forKey:"favorites")
    }
}

