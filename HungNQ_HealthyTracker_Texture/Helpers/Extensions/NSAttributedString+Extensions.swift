//
//  NSAttributedString+Extensions.swift
//  HungNQ_HealthyTracker_Texture
//
//  Created by Nguyen Quang Hung on 29/07/2022.
//

import UIKit
import Foundation


extension NSAttributedString {

    static func attributedString(string: String?, font: String, fontSize size: CGFloat, color: UIColor?) -> NSAttributedString? {
    guard let string = string else { return nil }

    let attributes = [convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): color ?? UIColor.black,
                      convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont(name: font, size: size)]

        let attributedString = NSMutableAttributedString(string: string, attributes: convertToOptionalNSAttributedStringKeyDictionary(attributes as [String : Any]))

    return attributedString
  }
  
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
