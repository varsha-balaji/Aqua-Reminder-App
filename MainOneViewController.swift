//
//  MainOneViewController.swift
//  Aqua Hydrate
//
//  Created by Varsha Balaji on 8/23/20.
//  Copyright © 2020 Varsha Balaji. All rights reserved.
//

import UIKit

//putting it here so that it is globally accessible
var list = ["WATER INTAKE LOG"]

class MainOneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //creating an array in Swift
    @IBOutlet weak var myTableView: UITableView!
    
    //method used to define how mnay rows you want in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //prototype os what we named the protype cell identifier
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "prototype")
        
        //this goes through the whole array
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    //override because each time the table appears we refesh the table view
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
