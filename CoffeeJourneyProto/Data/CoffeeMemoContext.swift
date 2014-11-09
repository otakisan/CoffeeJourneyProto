//
//  CoffeeMemoContext.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/16.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit
import CoreData

class CoffeeMemoContext: NSObject {
    
    class var sharedInstance : NSManagedObjectContext {
    struct Static {
        // getManagedObjectContext単独で記載してもXcode上はエラーにならないが
        // 実際にコンパイルするとエラーになる
        // しかも、エラーメッセージ見てもよくわからない
        // 要は、Static構造体にgetManagedObjectContextメソッドが存在しないからエラーだけど、
        // それがXcode上に表示されないし、コンパイルエラーの情報にもない
        static let instance : NSManagedObjectContext = CoffeeMemoContext.getManagedObjectContext()
        }
        return Static.instance
    }

    class func getManagedObjectContext() -> NSManagedObjectContext {
        
        var appDel : AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context : NSManagedObjectContext = appDel.managedObjectContext!
        
        return context
    }
    
    // AND連結固定
    private class func getFindPredicateCondition(condition : CoffeeMemoSearchCondition!) -> NSPredicate {
        
         // 個別の条件を保持する配列
        var predicates : [NSPredicate] = []
    
        // TODO: 検索条件の型ごとに汎用的に一気に作れるようにしたい
        // 今回はひとまず動作させたいので、べた書きする
        if(condition.memoId != nil){
            predicates.append(NSPredicate(format: "memoId BEGINSWITH[c] %@", condition.memoId!)!)
        }
        
        if(condition.fromTastingDate != nil){
            predicates.append(NSPredicate(format: "tastingDate >= %@", condition.fromTastingDate!)!)
        }
        
        if(condition.toTastingDate != nil){
            predicates.append(NSPredicate(format: "tastingDate <= %@", condition.toTastingDate!)!)
        }

        if(condition.beanName != nil){
            predicates.append(NSPredicate(format: "beanName ==[c] %@", condition.beanName!)!)
        }
        
        if(condition.brewingMethod != nil){
            predicates.append(NSPredicate(format: "brewingMethod ==[c] %@", condition.brewingMethod!)!)
        }

        if(condition.aroma != nil){
            predicates.append(NSPredicate(format: "aroma CONTAINS[c] %@", condition.aroma!)!)
        }

        if(condition.acidity != nil){
            predicates.append(NSPredicate(format: "acidity CONTAINS[c] %@", condition.acidity!)!)
        }
        
        if(condition.body != nil){
            predicates.append(NSPredicate(format: "body CONTAINS[c] %@", condition.body!)!)
        }
        
        if(condition.flavor != nil){
            predicates.append(NSPredicate(format: "flavor CONTAINS[c] %@", condition.flavor!)!)
        }
        
        if(condition.comment != nil){
            predicates.append(NSPredicate(format: "comment CONTAINS[c] %@", condition.comment!)!)
        }
        
        var predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicates)
        
        return predicate
    }
    
    class func find(condition : CoffeeMemoSearchCondition!, limit : Int) -> [CoffeeMemoEntity] {
        
        var request = NSFetchRequest(entityName: "CoffeeMemoEntity")
        request.returnsObjectsAsFaults = false
        request.predicate = getFindPredicateCondition(condition)
        
        if(limit > 0){
            request.fetchLimit = limit
        }
        
        request.sortDescriptors = [NSSortDescriptor(key: "tastingDate", ascending: false)]
        
        // 検索
        var results : NSArray = sharedInstance.executeFetchRequest(request, error: nil)!
        
        return results as [CoffeeMemoEntity]
    }
   
}
