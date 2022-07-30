//
//  Constants.swift
//  HealthyTracker
//
//  Created by Nguyen Quang Hung on 17/06/2022.
//

import Foundation
import UIKit

struct Constants {
    
    static let introSlides = [IntroModel(image: UIImage(named: "img-intro1"),
                                         title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần",
                                         subtitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"),
                              IntroModel(image: UIImage(named: "img-intro2"),
                                        title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần",
                                        subtitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"),
                              IntroModel(image: UIImage(named: "img-intro3"),
                                        title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần",
                                        subtitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà")]

    struct Color {
        static let background = UIColor(rgb: 0xF3F5FB)
        static let greenBold = UIColor(rgb: 0x2C8667)
        static let greenLight = UIColor(rgb: 0x2C8667, alpha: 0.3)
        static let greenExtraLight = UIColor(rgb: 0x0EAD69, alpha: 0.05)
        static let borderGray = UIColor(rgb: 0xEEEFF4)
        static let grayLight = UIColor(rgb: 0x242A61, alpha: 0.3)
        static let grayBold = UIColor(rgb: 0xD9DBE1)
        
        static let startGradientIntro = UIColor(rgb: 0xA6F1F7)
        static let endGradientIntro = UIColor(rgb: 0xF3F5FB)
        
        static let fontBlack = UIColor(rgb: 0x242A61)
    }
    
    struct Font {
        static let regular = "NunitoSans-Regular"
        static let light = "NunitoSans-Light"
        static let semiBold = "NunitoSans-SemiBold"
        static let bold = "NunitoSans-Bold"
    }
    
    struct HomeVC {
        static let tableNewsCellHeight: CGFloat = 286
        static let tableDoctorCellHeight: CGFloat = 251
        
        static let cltDoctorCellSize: CGSize = CGSize(width: 137, height: 213)
        static let cltNewsCellSize: CGSize = CGSize(width: 274, height: 248)
    }
    
    struct NewsListVC {
        static let newsTableCellHeight: CGFloat = 102
        static let firstNewsTableCellHeight: CGFloat = 296
    }
    
    struct DoctorListVC {
        static let estimateDoctorTableCellHeight: CGFloat = 180
    }
    
    struct Inset {
        static let insetForCltCell = UIEdgeInsets(top: 0, left: 16, bottom: 28, right: 0)
        static let insetForHeaderTbvCell = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
