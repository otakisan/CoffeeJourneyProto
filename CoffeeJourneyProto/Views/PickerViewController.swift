//
//  PickerViewController.swift
//  CoffeeJourneyProto
//
//  Created by takashi on 2014/08/31.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var selectedItemTextField: UITextField!
    var pickerViewItems : [String] = [
//        "Willow Blend","Lightnote Blend","Breakfast Blend","Pike Place Roast","Guatemala Antigua","Kenya","House Blend","Ethiopia","Colombia","Sumatra","Komodo Dragon Blend","Decaf Komodo Dragon Blend","Caffe Verona","Espresso Roast","Italian Roast","French Roast","Anniversary Blend","Autumn Blend","Malawi Peaberry","Maui Mokka","Peru Chonti"
    ]
    
    var selectedItem : String = ""
    var tagString : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 行もコンポーネントもインデックスはゼロ基点
        self.pickerView.selectRow(pickerViewItems.count / 2, inComponent: 0, animated: true)
        self.selectedItemTextField.text = self.selectedItem == "" ? pickerViewItems[pickerViewItems.count / 2] : self.selectedItem
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
        self.selectedItem = self.selectedItemTextField.text
    }
    
//    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String!{
//        return items[row]
//    }

}

extension PickerViewController : UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
        return pickerViewItems.count
    }
}

extension PickerViewController : UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String!{
        return pickerViewItems[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        self.selectedItemTextField.text = self.pickerViewItems[row]
    }
}
