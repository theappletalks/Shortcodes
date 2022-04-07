//
//  UICollectionView.swift
//  Short Codes
//
//  Created by Pulkit Vora on 07/04/22.
//


import Foundation
import UIKit

extension UICollectionView{
    
    func checkForNoData(count:Int,strMessage : String,color : UIColor = defaultThemeColor()){
    
        
        if count > 0 {
            self.backgroundView = nil;
        }else{
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            noDataLabel.text          = strMessage
            noDataLabel.textColor     = color
            noDataLabel.textAlignment = .center
           // noDataLabel.font = 
            self.backgroundView = noDataLabel;
        }
    }

}

