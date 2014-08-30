//
//  CoffeeMemoService.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/30.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class CoffeeMemoService: NSObject {
    
    class func getMemoId() -> String {
        var prefix = "CJL"
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss.SSS"
        var timestamp = formatter.stringFromDate(NSDate())
        
        return "\(prefix)_\(timestamp)"
    }
   
}
