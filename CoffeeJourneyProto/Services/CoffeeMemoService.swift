//
//  CoffeeMemoService.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/30.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit
import CoreData

class CoffeeMemoService: NSObject {
    
    class func getMemoId() -> String {
        var prefix = "CJL"
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss.SSS"
        var timestamp = formatter.stringFromDate(NSDate())
        
        return "\(prefix)_\(timestamp)"
    }
    
    class func getManagedObjectContext() -> NSManagedObjectContext {
        
        var appDel : AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context : NSManagedObjectContext = appDel.managedObjectContext!
        
        return context
    }
    
    class func createEntity() -> CoffeeMemoEntity {
        var context : NSManagedObjectContext = CoffeeMemoService.getManagedObjectContext()
        let ent = NSEntityDescription.entityForName("CoffeeMemoEntity", inManagedObjectContext: context)
        
        return CoffeeMemoEntity(entity: ent!, insertIntoManagedObjectContext: context)
    }
   
}
