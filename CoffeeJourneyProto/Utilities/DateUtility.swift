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
        
        self.init(dateFormat : "yyyy-MM-dd HH:mm:ss.SSS")
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

    private func createDisplayDateFormatter() -> NSDateFormatter{
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .MediumStyle
        
        return dateFormatter
    }
    
    // 日付⇄文字列の変換なんてのは、あらゆるところで必要になる
    // 王道の処理方式ってのはないんだろうか
    func toDateFromDisplayString(dateString : String) -> NSDate {
        
        // 受け入れ可能なフォーマットが実は固定な仕様になっている
        var date : NSDate = NSDate()
        if(dateString != nil && dateString != ""){
            let dateFormatter = createDisplayDateFormatter()
            date = dateFormatter.dateFromString(dateString)
        }
        
        return date
    }
    
    func toDisplayDateString(date : NSDate) -> String {
        
        var dateString : String = ""
        if(date != nil){
            let dateFormatter = createDisplayDateFormatter()
            dateString = dateFormatter.stringFromDate(date)
        }
        
        return dateString
    }
    
    func toSubtitleDateString(date : NSDate) -> String{
        // 日付⇄文字列
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.stringFromDate(date)

    }

}
