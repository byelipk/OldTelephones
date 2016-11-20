//
//  ProductViewController.swift
//  OldTelephones
//
//  Created by Patrick White on 11/18/16.
//  Copyright © 2016 Patrick White. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let p = product,
              let i = p.productImage
        else { return }
        
        productNameLabel.text = p.name
        productImageView.image = UIImage(named: i)
    }

    @IBAction func didAddToCart(_ sender: Any, forEvent event: UIEvent) -> Void {
        print("Button tapped.")
        
        guard
            let product = product,
            let price = product.price,
            let scalar = UnicodeScalar(0x1F603)
        else { return }

        
        // Create the alert
        let alertController = UIAlertController(
            title: "You're gonna love this!",
            message: "We may charge you $\(price) without your consent. It's a completely arbitrary process that you have no control over. \(scalar)",
            preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Sounds good", style: .default, handler: {(alert: UIAlertAction) -> Void in
            // Save the order to the archive
            let order = Order()
            order.order_id = 1
            order.product  = product
            
            var orders = Orders.readOrdersFromArchive()
            orders?.append(order)
            if let orders = orders {
                if (Orders.saveOrdersToArchive(orders: orders)) {
                   print("Added!")
                }
            }

        })
        
        let action2 = UIAlertAction(title: "Not Cool", style: .cancel, handler: {(alert: UIAlertAction) -> Void in
            print("OK We're good!")
        })
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        

        present(alertController, animated: true, completion: nil)

        
    }

}
