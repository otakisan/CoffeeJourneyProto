//
//  SearchConditionViewController.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/14.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class SearchConditionViewController: UIViewController {

    @IBOutlet weak var memoIdTextField: UITextField!
    @IBOutlet weak var fromTastingDateTextField: UITextField!
    @IBOutlet weak var toTastingDateTextField: UITextField!
    @IBOutlet weak var brewingMethodTextField: UITextField!
    @IBOutlet weak var beanNameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func searchButtonTouchedUpInside(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
