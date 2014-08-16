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
    
    var memoId : String?
    var existingCoffeeMemo : CoffeeMemoEntity?

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
//        self.saveJourneyLog()
        self.saveJourneyLogObject()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // ロードは軽いテキストなら同期でもいいけど、
        // そうでないなら、非同期も考える必要あり
//        loadJourneyLog()
        if(self.memoId != nil){
            loadJourneyLogObject()
        }
        else{
            // 新規作成時
            self.memoIdTextField.text = getMemoId()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getMemoId() -> String {
        var prefix = "testmemoId"
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss.SSS"
        var timestamp = formatter.stringFromDate(NSDate())
        
        return "\(prefix)_\(timestamp)"
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
    
    private func saveJourneyLogObject(){
        
        var context : NSManagedObjectContext = self.getManagedObjectContext()
        let ent = NSEntityDescription.entityForName("CoffeeMemoEntity", inManagedObjectContext: context)
        
        // データ項目が多くなってきた場合の対処方法
        if(self.existingCoffeeMemo == nil){
            self.existingCoffeeMemo = CoffeeMemoEntity(entity: ent, insertIntoManagedObjectContext: context)
        }
        else{
            
        }
        self.existingCoffeeMemo!.memoId = self.memoIdTextField.text
        self.existingCoffeeMemo!.tastingDate = toDate(self.tastingDateTextField.text)
        self.existingCoffeeMemo!.beanName = self.beanTextField.text
        self.existingCoffeeMemo!.brewingMethod = self.methodTextField.text
        self.existingCoffeeMemo!.aroma = self.aromaTextField.text
        self.existingCoffeeMemo!.acidity = self.acidityTextField.text
        self.existingCoffeeMemo!.body = self.bodyTextField.text
        self.existingCoffeeMemo!.flavor = self.flavorTextField.text
        self.existingCoffeeMemo!.comment = self.commentTextField.text
        
        context.save(nil)
        
        println(self.existingCoffeeMemo!)
        println("Object Saved")
    }
    
    
    private func loadJourneyLog(){
        
        var context : NSManagedObjectContext = self.getManagedObjectContext()

        var request = NSFetchRequest(entityName: "CoffeeMemoEntity")
        request.returnsObjectsAsFaults = false
        
        // 条件
        request.predicate = NSPredicate(format: "memoId = %@", "test memo id")
        
        var results : NSArray = context.executeFetchRequest(request, error: nil)
        
        if(results.count > 0){
            
            var result = results[0] as NSManagedObject
            self.memoIdTextField.text = result.valueForKey("memoId") as String
            
            for res in results{
                println(res)
            }
        } else {
            println("0 Results returned ... potential Error")
        }
        
    }
    
    private func loadJourneyLogObject(){
        
        var context : NSManagedObjectContext = self.getManagedObjectContext()
        
        var request = NSFetchRequest(entityName: "CoffeeMemoEntity")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "memoId = %@", self.memoId!)
        
        // TODO一意キー制約で制限しないと複数件返却されてしまう
        var results : NSArray = context.executeFetchRequest(request, error: nil)
        if(results.count > 0){
            
            var thisMemo = results[0] as CoffeeMemoEntity
            self.memoIdTextField.text = thisMemo.memoId
            self.tastingDateTextField.text = toDateString(thisMemo.tastingDate)
            self.beanTextField.text = thisMemo.beanName
            self.methodTextField.text = thisMemo.brewingMethod
            self.aromaTextField.text = thisMemo.aroma
            self.acidityTextField.text = thisMemo.acidity
            self.bodyTextField.text = thisMemo.body
            self.flavorTextField.text = thisMemo.flavor
            self.commentTextField.text = thisMemo.comment
            
            self.existingCoffeeMemo = thisMemo

//            for memo in results{
//                var thisMemo = memo as CoffeeMemoEntity
//                println("This memoId is \(thisMemo.memoId)")
//                
//                self.memoIdTextField.text = thisMemo.memoId
//            }
            
            println("\(results.count) found")
        }
        else{
            println("Not Found")
        }
    }
    
    private func setViewData(coffeeMemo : NSManagedObject!){
        self.memoIdTextField.text = coffeeMemo.valueForKey("memoId") as String
    }
    
    private func createDateFormatter() -> NSDateFormatter{
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .MediumStyle
        
        return dateFormatter
    }
    
    // 日付⇄文字列の変換なんてのは、あらゆるところで必要になる
    // 王道の処理方式ってのはないんだろうか
    private func toDate(dateString : String) -> NSDate {
        
        var date : NSDate = NSDate()
        if(dateString != nil && dateString != ""){
            let dateFormatter = createDateFormatter()
            date = dateFormatter.dateFromString(dateString)
        }
        
        return date
    }
    
    private func toDateString(date : NSDate) -> String {
        
        var dateString : String = ""
        if(date != nil){
            let dateFormatter = createDateFormatter()
            dateString = dateFormatter.stringFromDate(date)
        }
        
        return dateString
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
