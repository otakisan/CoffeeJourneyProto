//
//  ViewUtility.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/16.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class ViewUtility: NSObject {
    
    class func showMessageDialog(view : UIViewController, title : String, message : String){
        
        var message:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "閉じる", style: UIAlertActionStyle.Default, handler: nil))
        
        view.presentViewController(message, animated: true, completion: nil)
        
    }
}
