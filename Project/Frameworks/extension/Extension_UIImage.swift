//
//  Extension_UIImage.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/10/30.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import UIKit
import Photos

// MARK: - UIImage 扩展
extension UIImage {
    
    /// 创建并返回给定颜色和尺寸的纯彩色图片
    ///
    /// - Parameters:
    ///   - color: 给定颜色
    ///   - size: 给定尺寸
    static func initImage(color : UIColor, size : CGSize) -> UIImage {
        if size.width <= 0 || size.height <= 0 {
            return UIImage.init()
        }
        
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    /// 根据CIImage生成指定大小的UIImage
    ///
    /// - Parameters:
    ///   - image: CIImage
    ///   - size: 图片宽度
    /// - Returns: 生成的高清的UIImage
    static func creatNonInterpolatedUIImage(formCIImage image : CIImage, withSize size : CGFloat) -> UIImage {
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
    }
    
    /// 截图
    ///
    /// - Parameter view: 截图控件
    /// - Returns: 截图
    static func captureImageFromView(_ view : UIView) -> UIImage {
        let screenRect = view.bounds
        UIGraphicsBeginImageContextWithOptions(screenRect.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// 保存图片到相册
    public func sharedPhotoLibrary() {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: self)
        }) { (isSuccess: Bool, error: Error?) in
            if isSuccess {
                print("保存成功")
            } else {
                print("保存失败")
            }
        }
    }
    
    /// 识别图片二维码内的信息
    ///
    /// - Returns: 二维码信息
    public func qrCodeInfo() -> String {
        
        /// CIDetector是Core Image框架中提供的一个识别类，包括对人脸、形状、条码、文本的识别
        let detector : CIDetector = CIDetector.init(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])!
        /// 监测到的结果数组  CIFeature 在图像中检测到的显着特征的对象的抽象超类
        let features : [CIFeature] = detector.features(in: CIImage.init(cgImage: self.cgImage!))
        if features.count > 0 {
            /// 结果对象 CIQRCodeFeature 条码信息
            let feature : CIQRCodeFeature = features[0] as! CIQRCodeFeature
            let scannedResult = feature.messageString
            return scannedResult!
        }
        return ""
    }
}
