//
//  CartTableViewController.swift
//  OldTelephones
//
//  Created by Patrick White on 11/20/16.
//  Copyright © 2016 Patrick White. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    var orders: [Order]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch our orders from the archive
        orders = Orders.readOrdersFromArchive()
        
        // Tell the view to recompute itself in case there is new data to display
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)
        
        guard let order = orders?[indexPath.row]
        else  { return cell }
        
        cell.textLabel?.text = order.product?.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            orders?.remove(at: indexPath.row) // Remove data from array
            
            if let orders = orders {
                if(Orders.saveOrdersToArchive(orders: orders)) {        // Persist changes to archive
                    tableView.deleteRows(at: [indexPath], with: .fade)  // Remove row from view
                }
            }
        } else if editingStyle == .insert {
            // Create a new order instance, insert it into array, add new row to table
        }
    }



}
