//
//  PickerViewModel.swift
//  pickertest
//
//  Created by EIT on 16/2/18.
//  Copyright © 2016年 EIT. All rights reserved.
//

import UIKit

class PickerViewModel: NSObject, PickerViewDelegate {
    
    var items: [String]!
    var title: String = ""
    
    init(items: [String], title: String) {
        self.items = items
        self.title = title
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return items[row]
    }
}
