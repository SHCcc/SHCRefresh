//
//  UIImage+SP.swift
//  Pods
//
//  Created by BigL on 2017/5/19.
//
//

import UIKit

extension UIImage {

  /// 重设图片大小
  ///
  /// - Parameter size: 新的尺寸
  /// - Returns: 新图
  func reSize(size: CGSize) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale)
    self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return reSizeImage
  }
  
}
