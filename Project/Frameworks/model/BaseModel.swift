//
//  BaseModel.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/11/6.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import UIKit

/// 数据模型基类
class BaseModel: NSObject {
    
    
    /// 类属性集合
    lazy var modelTopDictionaryKeys = Array<String>()
    /// 数组数据
    lazy var arrayData = Array<Any>()
    /// 子类
    fileprivate lazy var childModelClass = Dictionary<String, AnyClass>()
    
    required override init() {
        super.init()
        initSubClass()
    }
    
    /// 初始化子类
    public func initSubClass() {
        
    }
    
    /// 添加子类
    ///
    /// - Parameters:
    ///   - subClass: 子类
    ///   - key: 对应key
    public func add(subClass : AnyClass, key : String) {
        childModelClass[key] = subClass
    }
    
    /// 处理json数据
    ///
    /// - Parameter data: 传入数据
    public func handleJson(_ data : Any) {
        
        if let  dic = data as? Dictionary<String, Any> {
            setValuesForKeys(dic)
        }
        
        if let arr = data as? Array<Dictionary<String, Any>> {
            arrayData = arr
        }
    }
    
    
    /// 处理子项列表数据
    func handleListData(_ listadata : Array<Any>, items : Array<Any>, itemClass : AnyClass) {
        if listadata.count > 0 {
         
        }
    }
    
    /// model转Dictionary
    ///
    /// - Returns: Dictionary
    public func modelToDictionary() -> Dictionary<String, Any> {
        return Dictionary<String, Any>()
    }
    
    
    /// 重写方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        let realValue = getRealValue(value, forKey: key)
        
        super.setValue(realValue, forKey: key)
    }
    
    fileprivate func getRealValue(_ value: Any?, forKey key: String) -> Any {
        
        if childModelClass.keys.contains(key) {
            
            if let valueDic = value as? Dictionary<String, Any> {
                
                if let childType = childModelClass[key] as? BaseModel.Type {
                    let childModel = childType.init()
                    childModel.handleJson(valueDic)
                    return childModel
                }
            }
            
            if let valueArr = value as? Array<Any> {
                
                if let childType = childModelClass[key] as? BaseArrayModel.Type {
                    let childModel = childType.init()
                    childModel.handleJson(valueArr)
                    return childModel
                }
            }
        }
        return value ?? ""
    }
    
}


/// 数组数据模型基类
class BaseArrayModel: BaseModel {
    
    /// 列表子项类名
    lazy var itemClassName = BaseModel.self
    
    /// 有多少元素
    var rows : Int {
        return items.count
    }
    
    /// 存放子项数据
    lazy var items : [BaseModel?] = [BaseModel?]()
    
    /// 处理子项数据
    ///
    /// - Parameters:
    ///   - data: 数据数组
    ///   - itemClass: 子项类型
    public func handleJson(_ data : Any, itemClass : AnyClass) {
        
        itemClassName = itemClass as! BaseModel.Type
        
        super.handleJson(data)
        
        items.removeAll()
        
        if arrayData.count > 0 {
            
            for i in 0..<arrayData.count {
                
                let itemModel = itemClassName.init()
                itemModel.handleJson(arrayData[i])
                items.append(itemModel)
            }
        }
        
    }
    
    /// 获取指定位置的子项数据
    ///
    /// - Parameter atRow: 位置
    /// - Returns: 指定子项数据
    public func itemModel(atRow : Int) -> BaseModel? {
        if atRow < items.count {
            return items[atRow]
        }
        return itemClassName.init()
    }
    
}


/// 数据请求返还数据模型
class RequestResultModel: BaseModel {
    
    @objc var status = ""
    @objc var err = 0
    @objc var msg = ""
    @objc var error = ""
    
    /// 是否是正确返回数据
    var isSuccess : Bool {
        if status.isEmpty  {
            
        } else {
            if status == "success" {
                return true
            }
        }
        return false
    }
    
    /// 报错信息
    var errorMessage : String {
        if isSuccess  {
            return ""
        } else {
            if !msg.isEmpty  {
                return msg
            }
            if !error.isEmpty  {
                return msg
            }
        }
        return ""
    }
}
