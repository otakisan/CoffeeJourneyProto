//
//  CoffeeMemoEntity.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/24.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import Foundation
import CoreData

@objc(CoffeeMemoEntity)
class CoffeeMemoEntity: NSManagedObject {

    @NSManaged var acidity: String
    @NSManaged var aroma: String
    @NSManaged var atmosphericTemperature: String
    @NSManaged var beanName: String
    @NSManaged var body: String
    @NSManaged var brewingMethod: String
    @NSManaged var comment: String
    @NSManaged var createdDate: NSDate
    @NSManaged var flavor: String
    @NSManaged var humidity: String
    @NSManaged var lastUpdatedDate: NSDate
    @NSManaged var liquidusTemperature: String
    @NSManaged var memoId: String
    @NSManaged var place: String
    @NSManaged var tastingDate: NSDate

}
