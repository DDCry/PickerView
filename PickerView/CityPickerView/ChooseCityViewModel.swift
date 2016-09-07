//
//  ChooseCityViewModel.swift
//  bag
//
//  Created by EIT on 16/7/7.
//  Copyright © 2016年 Eastern Innovation Technologies Co., Ltd. All rights reserved.
//

import UIKit
protocol loadCityDataDelegate: class {
    
    func didSelectItem(city: NSString)

}

class ChooseCityViewModel: NSObject, CityPickerViewDelegate {
    
    var delegate: loadCityDataDelegate?
    var title: String = ""
    var pickerDic:NSDictionary!
    var provinceArray:NSArray!
    var cityArray:NSArray!
    var townArray:NSArray!
    var selectedArray:NSArray!
    
    init(title: String, pickerDic: NSDictionary, provinceArray: NSArray, cityArray: NSArray, townArray:NSArray, selectedArray:NSArray) {
        self.title = title
        self.pickerDic = pickerDic
        self.provinceArray = provinceArray
        self.cityArray = cityArray
        self.townArray = townArray
        self.selectedArray = selectedArray
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = UILabel()
        pickerLabel = UILabel.init()
        pickerLabel.font = UIFont(name: "Helvetica", size: 16)
        pickerLabel.adjustsFontSizeToFitWidth = true
        pickerLabel.textAlignment = .Center
        pickerLabel.backgroundColor = UIColor.clearColor()
        pickerLabel.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        return pickerLabel
    }
    
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return self.provinceArray.count;
        } else if (component == 1) {
            return self.cityArray.count;
        } else {
            return self.townArray.count;
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            //return [self.provinceArray objectAtIndex:row];
            return self.provinceArray[row] as? String
        } else if (component == 1) {
            return self.cityArray[row] as? String;
        } else {
            return self.townArray[row] as? String;
        }
        
    }
    
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if (component == 0) {
            return 110;
        } else if (component == 1) {
            return 100;
        } else {
            return 110;
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            self.selectedArray = self.pickerDic.objectForKey(self.provinceArray[row]) as! NSArray
            if (self.selectedArray.count > 0) {
                self.cityArray = self.selectedArray[0].allKeys
            } else {
                self.cityArray = nil;
            }
            if (self.cityArray.count > 0) {
                self.townArray = self.selectedArray[0].objectForKey(self.cityArray[0]) as! NSArray
            } else {
                self.townArray = nil;
            }
        }
        pickerView.selectedRowInComponent(1)
        pickerView.reloadComponent(1)
        pickerView.selectedRowInComponent(2)
        
        if (component == 1) {
            if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
                
                self.townArray = self.selectedArray[0].objectForKey(self.cityArray[row]) as! NSArray
                
            } else {
                self.townArray = nil;
            }
            pickerView.selectRow(1, inComponent: 2, animated: true)
            
        }
        
        pickerView.reloadComponent(2)
        
        self.delegate?.didSelectItem((self.provinceArray[pickerView.selectedRowInComponent(0)] as! String) + (self.cityArray[pickerView.selectedRowInComponent(1)] as! String) + (self.townArray[pickerView.selectedRowInComponent(2)] as! String))
    }

}
