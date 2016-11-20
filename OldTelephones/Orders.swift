//
//  Orders.swift
//  OldTelephones
//
//  Created by Patrick White on 11/20/16.
//  Copyright © 2016 Patrick White. All rights reserved.
//

import Foundation

class Orders: NSObject, NSCoding {
    var orders: [Order]?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.orders = aDecoder.decodeObject(forKey: "orders") as! [Order]?
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.orders, forKey: "orders")
    }
    
    class func archiveFilePath() -> String {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                          .appendingPathComponent("cart.archive")
                          .path
    }
    
    class func readOrdersFromArchive() -> [Order]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: archiveFilePath()) as! [Order]?
    }
    
    // NOTE
    // This will wipe out everything that is in the archive.
    class func saveOrdersToArchive(orders: [Order]) -> Bool {
        return NSKeyedArchiver.archiveRootObject(orders, toFile: archiveFilePath())
    }
}
