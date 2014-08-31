//
//  CJLEditorTableViewController.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/24.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class CJLEditorTableViewController: UITableViewController {

    @IBOutlet weak var memoIdCell: UITableViewCell!
    @IBOutlet weak var tastingDateCell: UITableViewCell!
    @IBOutlet weak var beanNameCell: UITableViewCell!
    @IBOutlet weak var brewingMethodCell: UITableViewCell!
    @IBOutlet weak var aromaCell: UITableViewCell!
    @IBOutlet weak var acidityCell: UITableViewCell!
    @IBOutlet weak var bodyCell: UITableViewCell!
    @IBOutlet weak var flavorCell: UITableViewCell!
    @IBOutlet weak var commentCell: UITableViewCell!
    @IBOutlet weak var placeCell: UITableViewCell!
    @IBOutlet weak var liquidusTemperatureCell: UITableViewCell!
    @IBOutlet weak var atmosphericTemperatureCell: UITableViewCell!
    @IBOutlet weak var humidityCell: UITableViewCell!
    
    var memoId : String?
    let nodataString = "[No Data]"//空文字列にすると、テキストビューなんかから返ってきたときに値が表示されない。ただ、その項目を選択（押しっぱなしでも）すると表示される
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if(self.memoId != nil){
            
        }
        else{
            self.initializeViewData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initializeViewData(){
        
        self.memoIdCell.detailTextLabel.text = CoffeeMemoService.getMemoId()
        self.tastingDateCell.detailTextLabel.text = DateUtility.sharedInstance.toDisplayDateString(NSDate())
        self.beanNameCell.detailTextLabel.text = nodataString
        self.brewingMethodCell.detailTextLabel.text = nodataString
        self.aromaCell.detailTextLabel.text = nodataString
        self.acidityCell.detailTextLabel.text = nodataString
        self.bodyCell.detailTextLabel.text = nodataString
        self.flavorCell.detailTextLabel.text = nodataString
        self.commentCell.detailTextLabel.text = nodataString
        self.placeCell.detailTextLabel.text = nodataString
        self.liquidusTemperatureCell.detailTextLabel.text = nodataString
        self.atmosphericTemperatureCell.detailTextLabel.text = nodataString
        self.humidityCell.detailTextLabel.text = nodataString
        
    }
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

//    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        
//        switch(indexPath.row){
//        case 2:
//            self.performSegueWithIdentifier("showTastingDateViewSegue", sender: self)
//        default:
//            NSLog("")
//        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        // 種類ごとに処理は決まってくるので、Dictionaryなんかを使ってまとめられるけど、
        // しばらく個別に処理して、それでも汎用化できそうであればする。
        switch segue.identifier! {
            
        case "showTastingDateViewSegue":
            var destView = segue.destinationViewController as DatePickerViewController
            destView.tagString = "tastingDateCell"
            
        case "showBeanPickerViewSegue":
            var pickerView = segue.destinationViewController as PickerViewController
            pickerView.tagString = "beanNameCell"
            pickerView.pickerViewItems = [
                "Willow Blend","Lightnote Blend","Breakfast Blend","Pike Place Roast","Guatemala Antigua","Kenya","House Blend","Ethiopia","Colombia","Sumatra","Komodo Dragon Blend","Decaf Komodo Dragon Blend","Caffe Verona","Espresso Roast","Italian Roast","French Roast","Anniversary Blend","Autumn Blend","Malawi Peaberry","Maui Mokka","Peru Chonti"
            ]
            pickerView.selectedItem = self.beanNameCell.detailTextLabel.text
        case "showMethodPickerViewSegue":
            var pickerView = segue.destinationViewController as PickerViewController
            pickerView.tagString = "brewingMethodCell"
            pickerView.pickerViewItems = [
                "Drip(Machine)", "French Press", "Espresso", "Pour Over", "Instant"
            ]
            pickerView.selectedItem = self.brewingMethodCell.detailTextLabel.text
        case "showAcidityPickerViewSegue":
            var pickerView = segue.destinationViewController as PickerViewController
            pickerView.tagString = "acidityCell"
            pickerView.pickerViewItems = [
                "High", "Medium", "Low"
            ]
            pickerView.selectedItem = self.acidityCell.detailTextLabel.text
        case "showBodyPickerViewSegue":
            var pickerView = segue.destinationViewController as PickerViewController
            pickerView.tagString = "bodyCell"
            pickerView.pickerViewItems = [
                "Full", "Medium", "Light"
            ]
            pickerView.selectedItem = self.bodyCell.detailTextLabel.text
        case "showFlavorPickerViewSegue":
            var pickerView = segue.destinationViewController as PickerViewController
            pickerView.tagString = "flavorCell"
            pickerView.pickerViewItems = [
                "Bright", "Complex", "Crisp", "Herbal", "Spicy", "Dark Cocoa", "Citrus"
            ]
            pickerView.selectedItem = self.flavorCell.detailTextLabel.text
        case "showLiquidusTemperaturePickerViewSegue":
            var pickerView = segue.destinationViewController as PickerViewController
            pickerView.tagString = "liquidusTemperatureCell"
            pickerView.pickerViewItems = [
                "Very Hot", "Hot", "Light Hot", "Lukewarm", "Cold", "Very Cold"
            ]
            pickerView.selectedItem = self.liquidusTemperatureCell.detailTextLabel.text
        case "showAtmosphericTemperaturePickerViewSegue":
            var pickerView = segue.destinationViewController as PickerViewController
            pickerView.tagString = "atmosphericTemperatureCell"
            pickerView.pickerViewItems = [
                "More Than 30", "28-30", "26-28", "24-26", "22-24", "20-22", "18-20", "16-18", "14-16", "12-14", "10-12", "Less Than 10"
            ]
            pickerView.selectedItem = self.atmosphericTemperatureCell.detailTextLabel.text
        case "showHumidityPickerViewSegue":
            var pickerView = segue.destinationViewController as PickerViewController
            pickerView.tagString = "humidityCell"
            pickerView.pickerViewItems = [
                "100", "90", "80", "70", "60", "50", "40", "30", "20", "10", "0"
            ]
            pickerView.selectedItem = self.humidityCell.detailTextLabel.text
            
        case "showAromaTextViewSegue":
            var textView = segue.destinationViewController as TextViewController
            textView.tagString = "aromaCell"
            textView.inputText = self.aromaCell.detailTextLabel.text
        case "showCommentTextViewSegue":
            var textView = segue.destinationViewController as TextViewController
            textView.tagString = "commentCell"
            textView.inputText = self.commentCell.detailTextLabel.text
        case "showPlaceTextViewSegue":
            var textView = segue.destinationViewController as TextViewController
            textView.tagString = "placeCell"
            textView.inputText = self.placeCell.detailTextLabel.text
            
        default:
            break
        }
        
    }
    
    // 再び表示された、だけだとコンテキストを絞るのが大変そうなので、使用しない
//    override func viewDidAppear(animated: Bool) {
//        if(self.tableView.numberOfRowsInSection(0) > 1){
//            var cell = self.tastingDateCell
//            cell.detailTextLabel.text = "" + cell.detailTextLabel.text + "a"
//            
//        }
//    }
    
    @IBAction func datePickerViewReturnActionForSegue(segue : UIStoryboardSegue)
    {
        NSLog(segue.sourceViewController.title)
        NSLog("First view return action invoked.")
        
        var dateView = segue.sourceViewController as DatePickerViewController
        var cell : UITableViewCell = self.valueForKey(dateView.tagString) as UITableViewCell
        cell.detailTextLabel.text = dateView.dateString
    }
    
    @IBAction func pickerViewReturnActionForSegue(segue : UIStoryboardSegue){
        var pickerView = segue.sourceViewController as PickerViewController
        var cell : UITableViewCell = self.valueForKey(pickerView.tagString) as UITableViewCell
        cell.detailTextLabel.text = pickerView.selectedItem
    }
    
    @IBAction func textViewReturnActionForSegue(segue : UIStoryboardSegue){
        var textView = segue.sourceViewController as TextViewController
        var cell : UITableViewCell = self.valueForKey(textView.tagString) as UITableViewCell
        cell.detailTextLabel.text = textView.inputText
    }
    
    @IBAction func goToRoot(segue : UIStoryboardSegue)
    {
        NSLog("Called goToRoot: unwind action")
    }

}
