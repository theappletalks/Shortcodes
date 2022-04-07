//
//  Constants.swift
//  Short Codes
//
//  Created by Pulkit Vora on 07/04/22.
//

import UIKit
import Foundation

let NoSelection = -1
let APPDELEGATE = (UIApplication.shared.delegate as! AppDelegate)
let Google_Place_Api_Key = ""
let debounceValue = Int(0.5)
let PROGRESS_INDICATOR_VIEW_TAG:Int = 10


let PopUp_Frame = CGRect(x: 0, y:  0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
let device_LanguageCode = Locale.current.languageCode

let viewTopBarHeightForIphoneXOrAbove = CGFloat(84.0)
let topBarHeight = CGFloat(64.0)
let maxRequiredWidth = CGFloat(550.0)

var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}

func getScreenSize()->CGSize{
    return UIScreen.main.bounds.size
}

func defaultThemeColor()->UIColor{
    return UIColor.blue.withAlphaComponent(0.3)
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
