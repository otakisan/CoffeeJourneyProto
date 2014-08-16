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
        // ストーリーボード上で設定したSegueIdを参照できる変数・メソッドってないのかな
        self.performSegueWithIdentifier("showSearchResultSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        // 画面上の空は、条件を指定しないことを示すのでnilを設定
        // 空による検索はシステム内部で行う（もしくはUI上、チェックボックスを付け、「空を検索」とする必要がある）
        var condition = CoffeeMemoSearchCondition()
        condition.memoId = self.memoIdTextField.text == "" ? nil : self.memoIdTextField.text
        
        var vc = segue.destinationViewController as SearchResultTableViewController
        vc.searchCondition = condition
    }
    

}
