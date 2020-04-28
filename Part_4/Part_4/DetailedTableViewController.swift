//
//  DetailedTableViewController.swift
//  Part_4
//
//  Created by catie on 4/27/20.
//  Copyright © 2020 cmp5987. All rights reserved.
//

import UIKit

class DetailedTableViewController: UITableViewController{

    var selectedPark = Park()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = selectedPark.getParkName()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        //cell.textLabel?.text = selectedPark.getParkName()
        
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    cell.textLabel?.text = selectedPark.getParkName()
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
                case 1:
                    //do something
                    cell.textLabel?.text = selectedPark.getParkLocation()
                case 2:
                    //do something
                    cell.textLabel?.text = selectedPark.getArea()
                case 3:
                    //do something
                    cell.textLabel?.text = selectedPark.getDateFormed()
                default:
                    print("In Row Default")
            }
            case 1:
                //change this to image
                if let url = NSURL(string: selectedPark.getImageLink()) {
                    if let data =  NSData(contentsOf: url as URL) {

                        cell.imageView?.image = UIImage(data: data as Data)
                        //cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
                    }
                }
                else{
                    cell.textLabel?.text = "Issue loading Image"
                }
            case 2:
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text  = selectedPark.getParkDescription()
            case 3:
                cell.textLabel?.text = selectedPark.getLink()
                 cell.selectionStyle = .default
            case 4:
                cell.textLabel?.text = "Show on Map"
                cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
                cell.selectionStyle = .blue
            case 5:
                cell.textLabel?.text = "Add to Favorites"
                cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
                cell.selectionStyle = .blue
                
            default:
                print("In Default")
                cell.textLabel?.text = selectedPark.getParkName()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }else {
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Selected tab

        switch indexPath.section {
        case 3:
            print("Selected URL")
            if let url = URL(string: selectedPark.getLink()){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case 4:
            print("Selected Show on Map")
            //Maybe try to segue?
            self.tabBarController?.selectedIndex = 0
            
            let mapVC = tabBarController?.viewControllers![0] as! MapViewController
              
            mapVC.zoomInPark(parkLocation: selectedPark.getLocation())
            
        case 5:
            print("Selected Add to Favorites")
            // save in userDefaults
            
            var array = UserDefaults.standard.array(forKey: "favorites") as? [String]
            var isFavorite:Bool = false
            
            if array != nil {
                //checks if you've already added it to favorites
                if !(array?.contains(selectedPark.getParkName()))! {
                    array!.append(selectedPark.getParkName())
                }
                else{
                    isFavorite = true
                }
            } else {
                //create the inital array
                array = []
            }
            
            if isFavorite == true{
                let msg  = "\(selectedPark.getParkName()) is already in your Favorites"
                let alert = UIAlertController(title: "Favorites", message: msg, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                UserDefaults.standard.set(array, forKey:"favorites")
                let msg = "\(selectedPark.getParkName()) added to favorites"
                let alert = UIAlertController(title: "Favorites", message: msg, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

            
        default:
            print("Selected outside the row but we don't do anything for these non buttons")
        }
    }
    

    
    //supplementary functions
    func setPark(inPark: Park){
        selectedPark = inPark
        
        if isViewLoaded{
            
        }
    }
    
}
