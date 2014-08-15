//
//  JourneyLogEditorViewController.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/14.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit
import CoreData

class JourneyLogEditorViewController: UIViewController {

    @IBOutlet weak var memoIdTextField: UITextField!
    @IBOutlet weak var tastingDateTextField: UITextField!
    @IBOutlet weak var beanTextField: UITextField!
    @IBOutlet weak var methodTextField: UITextField!
    @IBOutlet weak var aromaTextField: UITextField!
    @IBOutlet weak var acidityTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var flavorTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    @IBAction func saveButtonTouchedUpInside(sender: AnyObject) {
        self.saveJourneyLog()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadJourneyLog()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getManagedObjectContext() -> NSManagedObjectContext {
        
        var appDel : AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context : NSManagedObjectContext = appDel.managedObjectContext!
        
        return context
    }
    
    private func saveJourneyLog(){
//        var appDel : AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
//        var context : NSManagedObjectContext = appDel.managedObjectContext!
        
        var context : NSManagedObjectContext = self.getManagedObjectContext()
        var coffeeMemo = NSEntityDescription.insertNewObjectForEntityForName("CoffeeMemoEntity", inManagedObjectContext: context) as NSManagedObject
        coffeeMemo.setValue(memoIdTextField.text, forKey: "memoId")
        
        context.save(nil)
        
        println("memo saved.")
        println(coffeeMemo)
    }
    
    private func loadJourneyLog(){
        
        var context : NSManagedObjectContext = self.getManagedObjectContext()

        var request = NSFetchRequest(entityName: "CoffeeMemoEntity")
        request.returnsObjectsAsFaults = false
        
        // 条件
        request.predicate = NSPredicate(format: "memoId = %@", "test memo id")
        
        var results : NSArray = context.executeFetchRequest(request, error: nil)
        
        if(results.count > 0){
            for res in results{
                println(res)
            }
        } else {
            println("0 Results returned ... potential Error")
        }
        
    }
    
    private func setViewData(coffeeMemo : NSManagedObject!){
        self.memoIdTextField.text = coffeeMemo.valueForKey("memoId") as String
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
