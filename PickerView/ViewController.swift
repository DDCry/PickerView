//
//  ViewController.swift
//  PickerView
//
//  Created by EIT on 16/9/7.
//  Copyright © 2016年 EIT. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var cityPickerView: PickerView!
    var cityPickerModel: ChooseCityViewModel!
    var relationPickerView: PickerView!
    var relationPickerViewModel: PickerViewModel!
    
    var pickerDic:NSDictionary!
    var provinceArray:NSArray!
    var cityArray:NSArray!
    var townArray:NSArray!
    var selectedArray:NSArray!
    
    var relation = ["祖父","祖母","外祖父","外祖母","伯父","伯母","叔父","叔母","舅舅","舅妈","姨夫","姨妈"]

    @IBOutlet weak var cityName: UIButton!
    @IBOutlet weak var otherName: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getPickerData()
        
        //城市选择器
        cityPickerModel = ChooseCityViewModel(title: "请选择城市", pickerDic: self.pickerDic, provinceArray: self.provinceArray, cityArray: self.cityArray, townArray: self.townArray, selectedArray: self.selectedArray)
        cityPickerView = PickerView.LoadXibFile()
        cityPickerModel.delegate = cityPickerView
        cityPickerView.configCityPickerView(cityPickerModel, actionDelegate: self, superView: self.view, pickerTag: CityPickerTag)
        
        //单列选择器
        relationPickerViewModel = PickerViewModel(items: relation, title: "请选择认证关系")
        relationPickerView = PickerView.LoadXibFile()
        relationPickerView.configOtherPickerView(relationPickerViewModel, actionDelegate: self, superView: self.view, pickerTag: OtherPickerTag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //城市plist列表数据
    func getPickerData(){
        let path = NSBundle.mainBundle().pathForResource("Address", ofType: "plist")
        self.pickerDic = NSDictionary.init(contentsOfFile: path!)
        self.provinceArray = self.pickerDic.allKeys
        self.selectedArray = self.pickerDic.objectForKey(self.pickerDic.allKeys[0]) as! NSArray
        if (self.selectedArray.count > 0){
            self.cityArray = self.selectedArray[0].allKeys
        }
        
        if (self.cityArray.count > 0){
            self.townArray = self.selectedArray[0].objectForKey(self.cityArray[0]) as! NSArray
        }
    }

    @IBAction func ChooseCity(sender: UIButton) {
        
        cityPickerView.show()
    }

    @IBAction func OtherChoose(sender: UIButton) {
        
        relationPickerView.show()
    }
    
    
}


// 代理
extension ViewController: CityPickerViewActionDelegate, OtherPickerViewActionDelegate{
    
    func didSelectItemForCityName(city: String?) {
        self.cityName.setTitle(city, forState: UIControlState.Normal)
        cityPickerView.hide()
    }
    
    func didSelectItem(row: Int) {
        self.otherName.setTitle(relation[row], forState: UIControlState.Normal)
        relationPickerView.hide()
    }
    
    func cancelAction() {
        cityPickerView.hide()
        relationPickerView.hide()
    }
    
}


