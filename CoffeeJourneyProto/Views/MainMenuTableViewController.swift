//
//  MainMenuTableViewController.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/14.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum Menus{
        case RecentEntries(Int, String, String)
    }
    
    let defaultTableViewCellIdentifier = "defaultMainMenuTableViewCell"
    
    let segueIdRecentEntries = "showSearchResultEntries"
    let segueIdSearchCondition = "showSearchConditionSegue"
    let segueIdNewEntry = "showJourneyLogEditorSegue"
    
    // メニューデータをオブジェクト化するか、他の仕組みで効率的に保持できるか。
    let menuData = [
        ["title" : "Recent Entries", "segueId" : "showSearchResultEntries"],
        ["title" : "Search", "segueId" : "showSearchConditionSegue"],
        ["title" : "New Entry", "segueId" : "showJourneyLogEditorSegue"]
    ]
    
    let prepareMethod = [
        "" : prepareForNewEntry
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // 動的にセルの数を増やす場合に
        // トップ画面は固定セルなので処理しない
//        self.tableView.registerClass(DefaultMainMenuTableViewCell.self, forCellReuseIdentifier: self.defaultTableViewCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return menuData.count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        // StoryBoard上でセルにreuseIdentifierを設定しておく必要あり
        var cell = tableView.dequeueReusableCellWithIdentifier(self.defaultTableViewCellIdentifier, forIndexPath: indexPath) as DefaultMainMenuTableViewCell
        
        // Configure the cell...
        var cellData = self.menuData[indexPath.row] as NSDictionary
        cell.textLabel.text = cellData.valueForKey("title") as String

        return cell
    }
    

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
        
        self.performSegueWithIdentifier((self.menuData[indexPath.row] as NSDictionary).valueForKey("segueId") as String, sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        switch(segue.identifier){
        case self.segueIdRecentEntries:
            self.prepareForRecentEntries(segue, sender: sender)
        case self.segueIdSearchCondition:
            self.prepareForSearchCondition(segue, sender: sender)
        case self.segueIdNewEntry:
            self.prepareForNewEntry(segue, sender: sender)
        default:
            break
        }
    }
    
    private func prepareForRecentEntries(segue: UIStoryboardSegue!, sender: AnyObject!){
        var vc = segue.destinationViewController as SearchResultTableViewController
        vc.title = " recent called!"
    }
    
    private func prepareForSearchCondition(segue: UIStoryboardSegue!, sender: AnyObject!){
        var vc = segue.destinationViewController as SearchConditionViewController
        vc.title = " cond called!"
    }
    
    private func prepareForNewEntry(segue: UIStoryboardSegue!, sender: AnyObject!){
        var vc = segue.destinationViewController as JourneyLogEditorViewController
        
        vc.title = " new called!"
    }


}
