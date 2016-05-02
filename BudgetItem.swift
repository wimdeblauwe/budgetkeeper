//
//  BudgetItem.swift
//  BudgetKeeper
//
//  Created by Wim Deblauwe on 02/05/16.
//  Copyright © 2016 Wim Deblauwe. All rights reserved.
//

import UIKit

class BudgetItem: NSObject, NSCoding {
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("BudgetItems")
    
    // MARK: Properties
    
    var name: String
    var price:Int
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let priceKey = "price"
    }
    
    // MARK: Initialization
    
    init?(name:String, price:Int) {
        self.name = name
        self.price = price
        
        super.init()
        
        // REVIEW: throw IllegalArgumentException?
        if( name.isEmpty || price < 0) {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeInteger(price, forKey: PropertyKey.priceKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let price = aDecoder.decodeIntegerForKey(PropertyKey.priceKey)
        self.init(name: name, price: price)
    }
}