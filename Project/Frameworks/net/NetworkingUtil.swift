//
//  NetworkingUtil.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/11/5.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import Foundation

/// 请求类型
///
/// - Post: post请求
/// - Get: get请求
enum ResqustMethod : String {
    case Post = "post"
    case Get  = "get"
}


/// 网络请求工具类
class NetworkingUtil {
    
    /// 请求成功返回闭包
    typealias RequestSuccess = (_ success : Any) -> ()
    /// 请求失败返回闭包
    typealias RequestFailure = (_ failure : Error?) -> ()
    
    
    /// 请求队列管理者 单例创建形式
    fileprivate static let sessionManager : AFHTTPSessionManager = {
        
        let manager = AFHTTPSessionManager.init()
        
//        manager.responseSerializer = AFJSONResponseSerializer.init()
        manager.responseSerializer = AFJSONResponseSerializer.init(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        manager.responseSerializer.acceptableContentTypes = NSSet.init(array: ["application/json", "text/html", "text/json", "text/javascript", "text/plain"]) as? Set<String>
//        manager.requestSerializer = AFJSONRequestSerializer.init()
        manager.requestSerializer.timeoutInterval = 30
//        manager.operationQueue.maxConcurrentOperationCount = 8
        
        return manager
    }()
    
    
    /// 网络请求结构
    ///
    /// - Parameters:
    ///   - MethodType: 网络请求类型
    ///   - url: 请求地址
    ///   - parameter: 请求参数
    ///   - success: 成功返回数据
    ///   - failure: 失败返回数据
    public static func request(MethodType : ResqustMethod,
                               url : String,
                               parameter : [String : String]?,
                               success : @escaping RequestSuccess,
                               failure : @escaping RequestFailure) {
        
        networkActivityIndicator(true)
        logRequestInfo(url, parameter)
        
        let successBlock = { (task : URLSessionDataTask, responseObj : Any?) in
//            print("responseObj:\n\(url)\n\(responseObj ?? "")")
            
            let object = responseObj ?? ""
            networkActivityIndicator(false)
            success(object)
        }
        
        let failureBlock = { (task : URLSessionDataTask?, error : Error) in
            networkActivityIndicator(false)
            showNetworkError(error)
            failure(error)
            print("error : \(error)")
        }
        
        if MethodType == ResqustMethod.Post {
            sessionManager.post(url, parameters: parameter, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        if MethodType == ResqustMethod.Get {
            sessionManager.get(url, parameters: parameter, progress: nil, success: successBlock, failure: failureBlock)
        }
    }
    
    
    /// 打印网络请求信息
    ///
    /// - Parameters:
    ///   - url: 网络请求链接
    ///   - parameter: 网络请求参数
    fileprivate static func logRequestInfo(_ url : String, _ parameter : [String : String]?) {
        var requestInfo = url + "?"
        var keyArr = [String]()
        let param = parameter ?? Dictionary<String, String>()
        
        keyArr = param.keys.sorted(by: { (key1 : String, key2 : String) -> Bool in
            return key1.localizedStandardCompare(key2) == ComparisonResult.orderedAscending
        })
        for key in keyArr {
            requestInfo = requestInfo + key + "=" + param[key]! + "&"
        }
        requestInfo.remove(requestInfo.count-1)
        
//        print("requestInfo:")
//        print(requestInfo)
//        print(param)
    }
    
}


/// 监测网络状态
///
/// - Parameter error: 错误信息
fileprivate func showNetworkError(_ error : Error?) {
    
    if AFNetworkReachabilityManager.shared().isReachable {
        ProgressHUD.show("网络状况不佳")
    } else {
        ProgressHUD.show("网络不可用")
    }
}

/// 开始网络监测
public func networkStartMonitoring() {
    let manger = AFNetworkReachabilityManager.shared()
    
    manger.setReachabilityStatusChange { (status : AFNetworkReachabilityStatus) in

        switch status {
            
        case .unknown:
            print("网络状态:未知网络")
        case .notReachable:
            print("网络状态:没有网络")
        case .reachableViaWWAN:
            print("网络状态:3G|4G")
        case .reachableViaWiFi:
            print("网络状态:wifi")
        @unknown default:
            print("未知状况")
        }
    }
    manger.startMonitoring()
}


/// 停止网络监测
public func networkStopMonitoring() {
    AFNetworkReachabilityManager.shared().stopMonitoring()
}


/// 设置状态栏风火轮
///
/// - Parameter bo: 是否启动
public func networkActivityIndicator(_ bo : Bool) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = bo
}
