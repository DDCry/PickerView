//
//  PickerView.swift
//  pickertest
//
//
//  Created by EIT on 16/2/18.
//  Copyright © 2016年 EIT. All rights reserved.
//

import UIKit

public let CityPickerTag = 1001
public let OtherPickerTag = 1002

protocol PickerViewDelegate: class, UIPickerViewDelegate, UIPickerViewDataSource {
    var title: String { get }
}

protocol CityPickerViewDelegate: class, UIPickerViewDelegate, UIPickerViewDataSource {
    var title: String { get }
}

protocol CityPickerViewActionDelegate: class {
    func cancelAction()
    func didSelectItemForCityName(city: String?)
}


protocol OtherPickerViewActionDelegate: class {
    func didSelectItem(row: Int)
    func cancelAction()
}

class PickerView: UIView,loadCityDataDelegate {
    
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pickerTitle: UILabel!
    
    weak var actionDelegate: OtherPickerViewActionDelegate?
    weak var cityDelegate: CityPickerViewActionDelegate?
    var cityName: String?
    
    class func LoadXibFile() -> PickerView {
        let picker = NSBundle.mainBundle().loadNibNamed(String(self.classForCoder()), owner: nil, options: nil).last! as! PickerView
        picker.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height, width: UIScreen.mainScreen().bounds.width, height: 254)
        return picker
    }
    
    @IBAction func cancelAction(sender: UIButton) {
        if picker.tag == OtherPickerTag {
            
            actionDelegate?.cancelAction()
        }
        if picker.tag == CityPickerTag {
            
            cityDelegate?.cancelAction()
        }
        
    }
    
    @IBAction func doneAction(sender: UIButton) {
       
        if picker.tag == OtherPickerTag {
            
            actionDelegate?.didSelectItem(picker.selectedRowInComponent(0))
        }
        if picker.tag == CityPickerTag {
            
            cityDelegate?.didSelectItemForCityName(self.cityName)
        }
        
    }
    
    func didSelectItem(city: NSString) {
        cityName = city as String
        
    }
    func configOtherPickerView(delegate: PickerViewDelegate, actionDelegate: OtherPickerViewActionDelegate, superView: UIView, pickerTag:Int) {
        picker.tag = pickerTag
        picker.dataSource = delegate
        picker.delegate = delegate
        self.actionDelegate = actionDelegate
        superView.addSubview(self)
        
        self.pickerTitle.text = delegate.title
    }
    
    
    func configCityPickerView(delegate: CityPickerViewDelegate, actionDelegate: CityPickerViewActionDelegate, superView: UIView, pickerTag:Int) {
        picker.tag = pickerTag
        picker.dataSource = delegate
        picker.delegate = delegate
        self.cityDelegate = actionDelegate
        superView.addSubview(self)
        
        self.pickerTitle.text = delegate.title
    }
    
    func show() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height - 254, width: UIScreen.mainScreen().bounds.width, height: 254)
        }
    }
    
    func hide() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height, width: UIScreen.mainScreen().bounds.width, height: 254)
        }
    }
}
