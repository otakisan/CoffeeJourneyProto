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
    
    // なんかうまくいかない
    private class func getFindPredicateCondition(condition : CoffeeMemoSearchCondition!) -> NSPredicate {
        
         // 汎用性を考えて、utility側でnil許容としているため。
        var predicates : [NSPredicate] = []
    
        // TODO: 検索条件の型ごとに汎用的に一気に作れるようにしたい
        // 今回はひとまず動作させてたいので、べた書きする
        if(condition.memoId != nil){
            predicates.append(NSPredicate(format: "memoId BEGINSWITH[c] %@", condition.memoId!))
        }
        
        if(condition.fromTastingDate != nil){
            predicates.append(NSPredicate(format: "tastingDate >= %@", condition.fromTastingDate!))
        }
        
        if(condition.toTastingDate != nil){
            predicates.append(NSPredicate(format: "tastingDate <= %@", condition.toTastingDate!))
        }

        if(condition.beanName != nil){
            predicates.append(NSPredicate(format: "beanName ==[c] %@", condition.beanName!))
        }
        
        if(condition.brewingMethod != nil){
            predicates.append(NSPredicate(format: "brewingMethod ==[c] %@", condition.brewingMethod!))
        }

        if(condition.aroma != nil){
            predicates.append(NSPredicate(format: "aroma CONTAINS[c] %@", condition.aroma!))
        }

        if(condition.acidity != nil){
            predicates.append(NSPredicate(format: "acidity CONTAINS[c] %@", condition.acidity!))
        }
        
        if(condition.body != nil){
            predicates.append(NSPredicate(format: "body CONTAINS[c] %@", condition.body!))
        }
        
        if(condition.flavor != nil){
            predicates.append(NSPredicate(format: "flavor CONTAINS[c] %@", condition.flavor!))
        }
        
        if(condition.comment != nil){
            predicates.append(NSPredicate(format: "comment CONTAINS[c] %@", condition.comment!))
        }
        
        var predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicates)
        
        return predicate
    }
    
    // セキュリティ的に良くないけど、ひとまず動作させるため、全て文字列として埋め込む
    // サニタイジングさえしてしまえば、自分で作りきってしまうのもあり？？
    class func getFindPredicateConditionString(condition : CoffeeMemoSearchCondition!) -> String {
        
        var formatStrings : [String!] = []
        
        if(condition.memoId != nil){
            formatStrings.append("memoId LIKE '\(condition.memoId!)*'")
        }
        
        if(condition.fromTastingDate != nil || condition.toTastingDate != nil){
            // NSDate型のカラムに対して絞り込みする場合、%@を使った形でないとダメ？？
            var fromDateTimeString = "0000-01-01 00:00:00.000"
            var toDateTimeString = "9999-12-31 23:59:59.999"
            
            if(condition.fromTastingDate != nil){
                fromDateTimeString = DateUtility.sharedInstance.toDateString(condition.fromTastingDate)
            }
            if(condition.toTastingDate != nil){
                toDateTimeString = DateUtility.sharedInstance.toDateString(condition.toTastingDate)
            }
            
            // 数字しか使えないっぽい
//            formatStrings.append("tastingDate between {\(fromDateTimeString), \(toDateTimeString)}")
//            formatStrings.append("(tastingDate >= '\(fromDateTimeString)') && (tastingDate <= '\(toDateTimeString)')")
            formatStrings.append("tastingDate >= '2014-08-16 00:00:00 +0900'")
        }
        
        var formatString = StringUtility.join(formatStrings, delimiter: " AND ")
        
        return formatString
    }
    
    class func find(condition : CoffeeMemoSearchCondition!, limit : Int) -> [CoffeeMemoEntity] {
        
        var request = NSFetchRequest(entityName: "CoffeeMemoEntity")
        request.returnsObjectsAsFaults = false
        
        // うまくいかない
//        var predicateInfo = getFindPredicateCondition(condition)
//        request.predicate = NSPredicate(format: predicateInfo.0, predicateInfo.1)
        
        // どうやら、prmに[AnyObject]!を取るのは、in句のように複数項目をとるキーワードに対するバインド変数のみらしい
//        var str : String! = "memoId in %@"
//        var prm : [AnyObject]! = ["testmemoId_20140816", "CJL"]
//        request.predicate = NSPredicate(format: str, prm)
        
        // 複数指定
//        var str : String! = "memoId beginswith %@"
//        var prm : String = "CJL"
//        // NSDateを使用する場合、Betweenは使えないっぽい
//        var fromStr : String! = "tastingDate >= %@"
//        var fromPrm : CVarArgType = DateUtility.sharedInstance.toDate("2014-08-16 00:00:00.000")
//        
//        var toStr : String! = "tastingDate <= %@"
//        var toPrm : CVarArgType = DateUtility.sharedInstance.toDate("2014-08-18 00:00:00.000")
//        
//        DateUtility.sharedInstance.toDate("2014-08-17 00:00:00.000")
//        request.predicate = NSCompoundPredicate(
//            type: NSCompoundPredicateType.AndPredicateType,
//            subpredicates: [NSPredicate(format: str, prm), NSPredicate(format: fromStr, fromPrm), NSPredicate(format: toStr, toPrm)]
//        )

        // これはうまくいく
//        var str : String = "tastingDate >= %@"
//        var prm : CVarArgType = DateUtility.sharedInstance.toDate("2014-08-16 00:00:00.000")
//        request.predicate = NSPredicate(format: str, prm)
        
        // 全て文字列で埋めてしまう
//        var queryString : String = getFindPredicateConditionString(condition)
//        if(queryString != ""){
//            request.predicate = NSPredicate(format: queryString)
//        }
        
        request.predicate = getFindPredicateCondition(condition)
        
        if(limit > 0){
            request.fetchLimit = limit
        }
        
        // predicateのほうも[AnyObject]!とありながら、実は特定の型を要求しているかもしれない
        // NSCompoundPredicate
        request.sortDescriptors = [NSSortDescriptor(key: "tastingDate", ascending: false)]
        
        // 検索
        var results : NSArray = sharedInstance.executeFetchRequest(request, error: nil)
        
        return results as [CoffeeMemoEntity]
    }
   
}
