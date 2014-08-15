//
//  CoffeeMemoEntity.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/14.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import Foundation
import CoreData

@objc(CoffeeMemoEntity)
class CoffeeMemoEntity: NSManagedObject {
    
    override init(entity: NSEntityDescription!, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity : entity, insertIntoManagedObjectContext: context)
        
        // ここで初期化してしまうと、データが空に
        // そもそも登録するときに必ずデフォルト値を設定するようにする
//        memoId = ""
//        beanName = ""
//        tastingDate = NSDate()
//        brewingMethod = ""
//        aroma = ""
//        acidity = ""
//        body = ""
//        flavor = ""
//        comment = ""
    }

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
