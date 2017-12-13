//
//  GifManager.swift
//  Pods
//
//  Created by BigL on 2017/6/19.
//
//

import UIKit

class GifManager {

  static let shared = GifManager()

  struct Result {
    let images: [UIImage]
    let time: Double
  }

  enum `Type` {
    case header
    case footer
  }

  enum State {
    case idle
    case pulling
    case refreshing
  }

  enum Style {
    case car
  }


 func images(type: Type,state: State, style: Style) -> Result? {
    guard let path = Bundle(for: Refresh.self).path(forResource: "Refresh", ofType: "bundle") else { return nil }
    guard let bundle = Bundle(path: path) else { return nil }

    var images = [UIImage]()
    var range = [0...0]
    var haspix = ""
    var time = 0.0
    switch style {
    case .car:
      haspix = "RefreshGif-"
      switch state {
      case .idle:
        time = 0.4
        range = [0...9]
      case .pulling:
        time = 0.4
        range = [10...13]
      case .refreshing:
        time = 1.0
        range = [14...24,0...9]
      }
    }

    range.forEach { (item) in
      for index in item {
        guard let image = UIImage(named: haspix + "\(index).png", in: bundle, compatibleWith: nil) else { return }
        let reImage = image.reSize(size: CGSize(width: UIScreen.main.bounds.width, height: 44))
        images.append(reImage)
      }
    }
    
    return Result(images: images, time: time)
  }
}
