//
//  Generic.swift
//  Short Codes
//
//  Created by Pulkit Vora on 07/04/22.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import Photos


extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}

extension PHAsset {
    
    var originalFilename: String? {

        var fname:String?

        if #available(iOS 9.0, *) {
            let resources = PHAssetResource.assetResources(for: self)
            if let resource = resources.first {
                fname = resource.originalFilename
            }
        }

        if fname == nil {
            // this is an undocumented workaround that works as of iOS 9.1
            fname = self.value(forKey: "filename") as? String
        }

        return fname
    }

    var image : UIImage {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        
        let requestImageOption = PHImageRequestOptions()
        requestImageOption.deliveryMode = .opportunistic
        requestImageOption.isNetworkAccessAllowed = true
        requestImageOption.version = .current
        
        imageManager.requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: requestImageOption, resultHandler: { image, _ in
            thumbnail = image!
        })
        return thumbnail
    }
}


extension AVURLAsset {
    var fileSize: Int? {
        let keys: Set<URLResourceKey> = [.totalFileSizeKey, .fileSizeKey]
        let resourceValues = try? url.resourceValues(forKeys: keys)
        
        return resourceValues?.fileSize ?? resourceValues?.totalFileSize
    }
}

extension String {
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }

    func string24To12() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "h:mm a"
        let Date12 = dateFormatter.string(from: date!)
        print("12 hour formatted Date:",Date12)
        return Date12
    }
    
    
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
    var pathExtension: String {
        return fileURL.pathExtension
    }
    var lastPathComponent: String {
        return fileURL.lastPathComponent
    }
    func customizeString(fullString: NSString, smallPartOfString: NSString, font: UIFont!, smallFont: UIFont! , smallColor: UIColor) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:smallFont!, NSAttributedString.Key.foregroundColor: smallColor]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        boldString.addAttributes(boldFontAttribute, range: fullString.range(of: smallPartOfString as String))
        return boldString
    }
    
    func convertStringToDate(dateFormate strFormate:String) -> Date{
        let dateFormate = DateFormatter()
        dateFormate.timeZone = TimeZone(secondsFromGMT: 0)!
        dateFormate.dateFormat = strFormate
        //dateFormate.timeZone = TimeZone.init(abbreviation: "UTC")
        let dateResult:Date = dateFormate.date(from: self)!
        return dateResult
    }
    
    func getDateFromString(strDateFormate:String, strRequiredDateFormate:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormate
        dateFormatter.timeZone = TimeZone.current
        let strDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = strRequiredDateFormate
        let dateFormated = dateFormatter.string(from: strDate!)
        return dateFormated
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width + 40
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var jsonStringRedecoded: String? {
        let data = ("\""+self+"\"").data(using: .utf8)!
        let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! String
        return result
    }
    
    func getEmojies()-> String {
        
        let aData: Data? = self.data(using: .utf8)!
        let decodedValue = String(data:aData!, encoding: String.Encoding(rawValue: String.Encoding.nonLossyASCII.rawValue))
        
        if decodedValue != nil {return decodedValue!} else
        { if let tmpString = self.jsonStringRedecoded{return tmpString}}
        return self}
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func toInt() -> Int {
        if let num = NumberFormatter().number(from: self)?.intValue{
            return num
        }
        return 0
    }
    
    func toFloat() -> Float {
        
        if let num = NumberFormatter().number(from: self)?.floatValue{
            return num
        }
        return 0.0
    }
    func toDateFormatterString(customFormat : String) -> String
    {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = DD_MM_YYYY_1
        
        //Parse into NSDate
        let dateFromString = dateFormatter.date(from: self)!
        
        dateFormatter.dateFormat = customFormat
        
        //Return Parsed Date
        return dateFormatter.string(from: dateFromString)
        
    }
    
    func toDateTime() -> Date
    {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)! as Date
        
        //Return Parsed Date
        return dateFromString
    }
    
    func toDate() -> NSDate
    {
        
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        
        //Parse into NSDate
        let dateFromString : NSDate = dateFormatter.date(from: self)! as NSDate
        
        //Return Parsed Date
        return dateFromString
    }
    func toOnlyDate() -> Date
       {
           
           //Create Date Formatter
           let dateFormatter = DateFormatter()
           
           //Specify Format of String to Parse
           dateFormatter.dateFormat = "yyyy-MM-dd"
           
           
           //Parse into Date
           let dateFromString : Date = dateFormatter.date(from: self)!
           
           //Return Parsed Date
           return dateFromString
       }
    
    
    
    
    //    func getDate() -> Date? {
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyy-dd-MM HH:mm a"
    //        dateFormatter.timeZone = TimeZone.current
    //        dateFormatter.locale = Locale.current
    //        return dateFormatter.date(from: self) // replace Date String
    //    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func toArrayOfElements() -> [String] {
        return self.components(separatedBy: ",")
    }
    
    
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
    
    func trim()->String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    func trimLines()->String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    static func documentDirectory()->String{
        
        let path  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        return  path[0] as String;
    }
    
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func isValidPassword() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9]{6,30}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    func isValidFLName() -> Bool {
        let nameRegEx = "^[a-zA-Z ]+$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return !emailTest.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ").inverted
        let filtered: String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return self == filtered
    }
    
    func isEmptyText() -> Bool {
        let string = self.trimmingCharacters(in: NSCharacterSet.whitespaces)
        return string.isEmpty
    }
    
    func substring(_ from: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        return String(self[start ..< endIndex])
    }
    
    var toNSString: NSString {
        return self as NSString
    }
    
}

extension CAShapeLayer {
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
}
extension AVPlayer {
    var isPlaying: Bool {
        if (self.rate != 0 && self.error == nil) {
            return true
        } else {
            return false
        }
    }
}
private var handle: UInt8 = 0;
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
extension UIBarButtonItem {
    
    var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func setBadge(text: String?, withOffsetFromTopRight offset: CGPoint = CGPoint.zero, andColor color:UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11) {
        badgeLayer?.removeFromSuperlayer()
        if (text == nil || text == "") {
            return
        }
        //addBadge(text: text!, withOffset: offset, andColor: color, andFilled: filled)
    }
    
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
    
}
extension NSDictionary {

    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }

    func printJson() {
        print(json)
    }

}
extension Dictionary where Value: Comparable {
    var valueKeySorted: [(Key, Value)] {
        return sorted{ if $0.value != $1.value { return $0.value > $1.value } else { return String(describing: $0.key) < String(describing: $1.key) } }
    }
}
extension NSObject {
    /// Returns the className for the Class, removing the project namespace.
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? NSStringFromClass(self)
        
    }
}

extension UIFont{
    // Returns a scaled version of UIFont
    func scaled(scaleFactor: CGFloat) -> UIFont {
        let newDescriptor = fontDescriptor.withSize(fontDescriptor.pointSize * scaleFactor)
        return UIFont(descriptor: newDescriptor, size: 0)
    }
}
extension UIScrollView{
    
    func AumaticScroller() {
        var contentRect = CGRect.zero
        for view in self.subviews{
            contentRect = contentRect.union(view.frame);
        }
        self.contentSize = contentRect.size;
    }
    
    func AumaticScrollerFlexible() {
        var contentRect = CGRect.zero
        for view in self.subviews{
            contentRect = contentRect.union(view.frame);
        }
        self.contentSize = CGSize(width: contentRect.width, height: contentRect.height + 60)
    }
}

//MARK:
//MARK: Autolayout

struct Inset {
    let value: CGFloat
    let attr: NSLayoutConstraint.Attribute
    
    init(_ value: CGFloat, from attr: NSLayoutConstraint.Attribute) {
        self.attr = attr;
        switch (attr) {
        case .right, .bottom:  self.value = -value
        default: self.value = value
        }
    }
}
