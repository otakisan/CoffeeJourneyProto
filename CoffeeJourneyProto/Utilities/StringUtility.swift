//
//  StringUtility.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/16.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class StringUtility: NSObject {
    
    // TODO: nilを含む配列、含まない配列をひとつの定義で記述することはできる？
    class func join(stringArray : [String!], delimiter : String!) -> String!{
        
        var joinedString = ""
        var isFirst = true
        for element in stringArray{
//            if(element != nil){
                if(!isFirst){
                    joinedString += delimiter
                }
                else{
                    isFirst = false
                }
                
                joinedString += element!
//            }
        }
        
        return joinedString
    }
   
}
