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
    
    var text:String = ""
    var toptitle:String = ""
    
    let parkNameSection = 0
    let parkLocSection = 1
    let parkAreaSection = 2
    let parkDateSection = 3
    let parkImageSection = 4
    let parkUrlSection  = 5
    let parkMapSection = 6
    let parFavSection = 7

 override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
    }
}
