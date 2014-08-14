//
//  CoffeeMemoEntity.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/14.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import Foundation
import CoreData

class CoffeeMemoEntity: NSManagedObject {

    @NSManaged var memoId: String
    @NSManaged var beanName: String
    @NSManaged var tastingDate: NSDate
    @NSManaged var brewingMethod: String
    @NSManaged var aroma: String
    @NSManaged var acidity: String
    @NSManaged var body: String
    @NSManaged var flavor: String
    @NSManaged var comment: String

}
