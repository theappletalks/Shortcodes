//
//  UIImage.swift
//  Short Codes
//
//  Created by Pulkit Vora on 07/04/22.
//


import Foundation
import UIKit
import AVKit



extension UIImage {
    
    //convert image to base64 string
    func toBase64() -> String {
        var imageData: NSData
        //        switch ImageFormat.self {
        //        case .PNG: imageData = UIImagePNGRepresentation(self)! as NSData
        //        case .JPEG(let compression): imageData = UIImageJPEGRepresentation(self, compression)! as NSData
        //        }
        imageData = self.pngData()! as NSData
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    //convert string to image
    class func base64ToImage(toImage strEncodeData: String) -> UIImage {
        let dataDecoded  = NSData(base64Encoded: strEncodeData, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        let image = UIImage(data: dataDecoded as Data)
        return image!
    }
    
    //Function for store file/Image into local directory. If image is already on the directory then first remove it and replace new image/File on that location
    func storedFileIntoLocal(strImageName:String) -> String{
        var strPath = ""
        let documentDirectory1 = NSString.init(string: String.documentDirectory())
        let imageName:String = strImageName + ".png"
        let imagePath = documentDirectory1.appendingPathComponent(imageName)
        strPath = imagePath
        let fileManager = FileManager.default
        let isExist = fileManager.fileExists(atPath: String.init(imagePath))
        if(isExist == true)
        {
            do {
                try fileManager.removeItem(atPath: imagePath as String)//removing file if exist
                // print("Remove success")
            } catch {
                print(error)
            }
        }
        let imageData:Data = self.jpegData(compressionQuality: 0.5)!
        do {
            try imageData.write(to: URL(fileURLWithPath: imagePath as String), options: .atomic)
        } catch {
            print(error)
            strPath = "Failed to cache image data to disk"
            return strPath
        }
        return strPath
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizedTo1MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        
        while imageSizeKB > 1000 { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                let imageData = resizedImage.pngData()
                else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        }
        
        return resizingImage
    }
    
    
    
    
    //function for resize image
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            //                        newSize = size
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    

}
