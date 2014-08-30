//
//  DatePickerViewController.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/30.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    var tagString : String = ""
    var dateString : String = ""

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var selector : Selector = "didDoneButton:"
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: selector)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        self.dateString = DateUtility.sharedInstance.toDisplayDateString(self.datePicker.date)
    }

//    @IBAction func unwind(sender: UIStoryboardSegue) {
//        // ↓を実行すると戻るけど、ダイアログが表示されない
//        self.navigationController.popViewControllerAnimated(true)
//    }
    

    func didDoneButton(sender : AnyObject){
//        self.navigationController.popViewControllerAnimated(true)
//        self.navigationController.dismissViewControllerAnimated(true, completion: nil)
        
//        SEL theUnwindSelector = @selector(goToRoot:);
        var unwindSegueIdentifier : String = "unwindToRootSeque"
        
        var nc : UINavigationController = self.navigationController
        // Find the view controller that has this unwindAction selector (may not be one in the nav stack)
        var selector : Selector = "goToRoot:"
        var viewControllerToCallUnwindSelectorOn : UIViewController =
            nc.viewControllerForUnwindSegueAction(selector, fromViewController: self, withSender: sender)
        // None found, then do nothing.
        if (viewControllerToCallUnwindSelectorOn == nil) {
            NSLog("No controller found to unwind too")
            return;
        }
        
        // Can the controller that we found perform the unwind segue.  (This is decided by that controllers implementation of canPerformSeque: method
        var cps = viewControllerToCallUnwindSelectorOn.canPerformUnwindSegueAction(selector,
            fromViewController: self,
            withSender: sender)
        // If we have permision to perform the seque on the controller where the unwindAction is implmented
        // then get the segue object and perform it.
        if (cps) {
            
            var unwindSegue : UIStoryboardSegue = nc.segueForUnwindingToViewController(viewControllerToCallUnwindSelectorOn, fromViewController: self, identifier: unwindSegueIdentifier)
            
            viewControllerToCallUnwindSelectorOn.prepareForSegue(unwindSegue, sender: self)
            
            unwindSegue.perform()
        }
    }
    

}
