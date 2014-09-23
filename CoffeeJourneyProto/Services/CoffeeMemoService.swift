//
//  CoffeeMemoService.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/30.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit
import CoreData

/**
 コーヒーメモ業務処理クラス
*/
class CoffeeMemoService: NSObject {

    // 静的定数をclass内に定義できないので構造体でラップ
    struct Static {
        // 各種日付フォーマットは用途別に定数を定義する
        // ID用日付フォーマット
        static let dateTimeFormatId = "yyyyMMdd_HHmmss.SSS"
    }
    
    /**
        メモID取得
        
        :returns: メモID
    */
    class func getMemoId() -> String {

        var prefix = "CJL"
        var formatter = NSDateFormatter()
        formatter.dateFormat = Static.dateTimeFormatId
        var timestamp = formatter.stringFromDate(NSDate())
        
        return "\(prefix)_\(timestamp)"
    }
    
    /**
        ManagedObjectContext取得
    
        :returns: ManagedObjectContext
    */
    class func getManagedObjectContext() -> NSManagedObjectContext {
        
        var appDel : AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context : NSManagedObjectContext = appDel.managedObjectContext!
        
        return context
    }
    
    /**
        コーヒーメモエンティティを生成します
        
        :returns: コーヒーメモエンティティ
    */
    class func createEntity() -> CoffeeMemoEntity {
        var context : NSManagedObjectContext = CoffeeMemoService.getManagedObjectContext()
        let ent = NSEntityDescription.entityForName("CoffeeMemoEntity", inManagedObjectContext: context)
        
        return CoffeeMemoEntity(entity: ent!, insertIntoManagedObjectContext: context)
    }
   
}
