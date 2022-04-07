//
//  PremitiveDataType.swift
//  Short Codes
//
//  Created by Pulkit Vora on 07/04/22.
//


import Foundation
import UIKit

/// Represents parts of time
struct TimeParts: CustomStringConvertible {
    var seconds = 0
    var minutes = 0
    /// The string representation of the time parts (ex: 07:37)
    var description: String {
        return NSString(format: "%01d:%02d", minutes, seconds) as String
    }
}
/// Represents unset or empty time parts
let EmptyTimeParts = 0.toTimeParts()


extension Float
{
    var cleanValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
    func toDouble() -> Double? {
        return Double(self)
    }
    func toString() -> String
    {
        return String(self)
    } 
    func toInt() -> Int? {
        if self > Float(Int.min) && self < Float(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}

extension Int {
    
    
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
    
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    func toTimeParts() -> TimeParts {
        let seconds = self
        var mins = 0
        var secs = seconds
        if seconds >= 60 {
            mins = Int(seconds / 60)
            secs = seconds - (mins * 60)
        }
        
        return TimeParts(seconds: secs, minutes: mins)
    }
    
    /// The string representation of the time parts (ex: 07:37)
    func asTimeString() -> String {
        return toTimeParts().description
    }
    
    var abbreviated: String {
        let abbrev = "KMBTPE"
        return abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
            let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
            let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.1f%@")
            return accum ?? (factor > 1 ? String(format: format, factor, String(tuple.1)) : nil)
            } ?? String(self)
    }
    func toString() -> String
    {
        return String(self)
    }
    func toDouble() -> Double
    {
        return Double(self)
    }
    var currentTimeStamp: String {
        get {
            let date = NSDate(timeIntervalSince1970: TimeInterval(self)/1000)
            let dateFormatter = DateFormatter()
            
            // don't forget to set locale, otherwise you may get **周五** instead of **FRI**
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return dateFormatter.string(from: date as Date)
        }
    }
    var trimZero: String {
        get {
            return String(format: "%g", Double(self))
        }
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    var shortStringRepresentation: String {
        if self.isNaN {
            return "NaN"
        }
        if self.isInfinite {
            return "\(self < 0.0 ? "-" : "+")Infinity"
        }
        let units = ["", "k", "M"]
        var interval = self
        var i = 0
        while i < units.count - 1 {
            if abs(interval) < 1000.0 {
                break
            }
            i += 1
            interval /= 1000.0
        }
        if interval == 0 {
            return "\(0)"
        }
        // + 2 to have one digit after the comma, + 1 to not have any.
        // Remove the * and the number of digits argument to display all the digits after the comma.
        return "\(String(format: "%0.*g", Int(log10(abs(interval))) + 2, interval))\(units[i])"
    }
    mutating func square() {
        let pi = 3.1415
        self = pi * self * self
    }
    func celsiusToFahrenheit() -> Double {
        return self * 9 / 5 + 32
    }
    
    func fahrenheitToCelsius() -> Double {
        return (self - 32) * 5 / 9
    }
    
    func toInt() -> Int? {
        if self > Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
    
    func cleanValue()->String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
    
//    func cleanValue()->String?{
//        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
//    }
}

extension NSAttributedString {
    
    
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension Array {
    func filterDuplicates(includeElement: @escaping (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {
        
        var results = [Element]()
        
        forEach { (element) in
            
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        return results
    }
    var string: String? {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(data: data, encoding: .nonLossyASCII)
            
        } catch {
            
            return nil
        }
    }
    
    func withPriority(priority: UILayoutPriority) -> [NSLayoutConstraint] {
        var members: [NSLayoutConstraint] = []
        for member in self {
            switch member {
            case let constraint as NSLayoutConstraint:
                constraint.priority = priority
                members.append(constraint)
            default: break
            }
        }
        return members
    }
}
