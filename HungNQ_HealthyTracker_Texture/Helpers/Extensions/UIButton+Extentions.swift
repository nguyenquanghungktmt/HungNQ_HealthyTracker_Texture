//
//  UIButton+Extentions.swift
//  HealthyTracker
//
//  Created by Nguyen Quang Hung on 24/06/2022.
//

import UIKit

extension UIButton {
    func imageToRight() {
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
  }
}
