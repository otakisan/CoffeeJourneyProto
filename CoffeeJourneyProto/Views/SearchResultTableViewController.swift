//
//  SearchResultTableViewController.swift
//  CoffeeJourneyProto
//
//  Created by Takashi Ikeda on 2014/08/14.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    // nilを許容しない型の場合は、ここで初期化する必要がある
    // もしくはイニシャライザ（init系メソッド）
    var searchCondition : CoffeeMemoSearchCondition! = CoffeeMemoSearchCondition()
    var searchResult : [CoffeeMemoEntity] = []
    var fetchLimit : Int = 0
    
//    let showLogEditorSegueId = "showJourneyLogEditorSegue"
    let showLogEditorSegueId = "showJourneyLogEditorV2Segue"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.searchResult = CoffeeMemoContext.find(self.searchCondition, limit: self.fetchLimit)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.searchResult.count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseSearchResultCellIdentifier", forIndexPath: indexPath) as UITableViewCell

        // detailはcellのタイプをsubtitleにしておく必要がある
        cell.textLabel.text = self.searchResult[indexPath.row].comment
        
        var dateForSubtitle = DateUtility.sharedInstance.toSubtitleDateString(self.searchResult[indexPath.row].tastingDate)
        cell.detailTextLabel.text = dateForSubtitle + " " + self.searchResult[indexPath.row].beanName + ", " + self.searchResult[indexPath.row].brewingMethod + ", " + self.searchResult[indexPath.row].place
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            
            // 先に行数の元となる配列から要素を削除し、numberOfRowsInSectionで削除後の行数を返却するようにする
            // 先に削除しないと、deleteRowsAtIndexPathsでエラーになる
            var rowIndexDeleting = indexPath.row
            var memoIdDeleting = searchResult[rowIndexDeleting].memoId
            var coffeeMemoEntityDeleting = searchResult.removeAtIndex(rowIndexDeleting)
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            // 念のため、前の処理が全部成功してから実際に削除する
            CoffeeMemoContext.sharedInstance.deleteObject(coffeeMemoEntityDeleting)
            ViewUtility.showMessageDialog(self, title: "log deleted", message: "deleted : \(memoIdDeleting)")
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        
        self.performSegueWithIdentifier(showLogEditorSegueId, sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        switch segue.identifier! {
            case "showJourneyLogEditorSegue":
                var vc = segue.destinationViewController as JourneyLogEditorViewController
                vc.memoId = self.searchResult[self.tableView.indexPathForSelectedRow().row].memoId
        case "showJourneyLogEditorV2Segue":
            var vc = segue.destinationViewController as CJLEditorTableViewController
            vc.memoId = self.searchResult[self.tableView.indexPathForSelectedRow().row].memoId
        default:
            break
        }
    }
    
    
}
