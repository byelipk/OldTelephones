//
//  ProductsTableViewController.swift
//  OldTelephones
//
//  Created by Patrick White on 11/18/16.
//  Copyright © 2016 Patrick White. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    var products: [Product]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // Create our data
        let product1 = Product()
        let product2 = Product()
        let product3 = Product()
        let product4 = Product()
        
        product1.name = "Is it cooler than ember?"
        product1.productImage = "phone-fullscreen1"
        product1.cellImage = "image-cell1"
        product1.price = 19.99
        
        product2.name = "IOS is cool!"
        product2.productImage = "phone-fullscreen2"
        product2.cellImage = "image-cell2"
        product2.price = 19.99
        
        product3.name = "Fun Bags!"
        product3.productImage = "phone-fullscreen3"
        product3.cellImage = "image-cell3"
        product3.price = 19.99
        
        product4.name = "Is it cooler than react?"
        product4.productImage = "phone-fullscreen4"
        product4.cellImage = "image-cell4"
        product4.price = 19.99
        
        products = [product1, product2, product3, product4]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let p = products {
          return p.count
        }
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell",
                                                 for: indexPath)

         // Configure the cell...
        guard let product = products?[indexPath.row],
              let image = product.cellImage
        else { return cell }
        
        cell.textLabel?.text = product.name
        cell.imageView?.image = UIImage(named: image)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProduct" {
            guard let productVC = segue.destination as? ProductViewController,
                  let cell = sender as? UITableViewCell,
                  let indexPath = tableView.indexPath(for: cell)
            
            else { return }
            
            productVC.product = products?[indexPath.row]
        }
    }
    
    
    

}
