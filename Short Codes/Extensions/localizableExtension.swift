//
//  localizableExtension.swift
//  Short Codes
//
//  Created by Pulkit Vora on 07/04/22.
//

import Foundation
import UIKit

protocol Localizable {
    var localized: String { get }
}
extension String: Localizable {
    var localized: String {
        return APPDELEGATE.read_Localizable(self)
    }
}
protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
protocol XIBConstraint {
    var newConstraint: CGFloat { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}
extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
   }
}

extension UITextView: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
    @IBInspectable var xibLocPlaceholderKey: String? {
          get { return nil }
          set(key) {
              placeholderString = key?.localized
          }
      }
}
extension UITextField: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
   }
    @IBInspectable var xibLocPlaceholderKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}
extension NSLayoutConstraint : XIBConstraint {
    @IBInspectable var newConstraint: CGFloat {
        get { return 0.0 }
        set(key) {
            if hasTopNotch{
                self.constant = key
            }
        }
   }
}
