//
//  DateUtility.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/16.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class DateUtility : NSObject {
    
    // シングルトン実装
    // http://qiita.com/susieyy/items/acb3bc80a1dafe64cffd
    class var sharedInstance : DateUtility {
    struct Static {
        static let instance : DateUtility = DateUtility()
        }
        return Static.instance
    }
    
    let dateFormatter : NSDateFormatter!
    
    convenience override init(){
        
        self.init(dateFormat : "")
    }
    
    init(dateFormat : String!){
        super.init()
        
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
    }
    
    func toDate(dateString : String!) -> NSDate {
        return dateFormatter.dateFromString(dateString)
    }
    
    func toDateString(date : NSDate!) -> String {
        return dateFormatter.stringFromDate(date)
    }
   
}
