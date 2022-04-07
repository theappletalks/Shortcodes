//
//  UIViewController.swift
//  Short Codes
//
//  Created by Pulkit Vora on 07/04/22.
//
import Foundation
import UIKit
import MessageUI


extension UIViewController {

    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = .red
        let someAction = UIAlertAction(title: "Dismiss !!", style: .default, handler: nil)
        alertController.addAction(someAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        let backItem = UIBarButtonItem.init(image:nil, style: .plain, target: self, action: #selector(UIViewController.backViewController))
        backItem.image = #imageLiteral(resourceName: "Back")
        self.navigationItem.leftBarButtonItem = backItem
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black.cgColor,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        
        //self.navigationController?.navigationBar.barTintColor
          self.navigationController?.navigationBar.tintColor = defaultThemeColor()
        
    }
    
    func showNavigationBarWithoutBack(){
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black.cgColor,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        
        //self.navigationController?.navigationBar.barTintColor
        self.navigationController?.navigationBar.tintColor = defaultThemeColor()

    }

    func showNavigationBarWithRightButton(img:UIImage){
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

        let rightItem = UIBarButtonItem.init(image:nil, style: .plain, target: self, action: #selector(UIViewController.rightBtnClick))
        rightItem.image = img
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black.cgColor,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        
        //self.navigationController?.navigationBar.barTintColor
        self.navigationController?.navigationBar.tintColor = defaultThemeColor()
    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        //gradientLayer.colors = getBackgroundGradient()
        
//        let angle: CGFloat = -36
//        let t = CATransform3DMakeRotation(angle, 0, 0, 1)
//        gradientLayer.transform = t
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    func showNavigationBarWithLeftButton(img:UIImage){
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black.cgColor,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        
        //self.navigationController?.navigationBar.barTintColor
        self.navigationController?.navigationBar.tintColor = defaultThemeColor()

        
        let leftItem = UIBarButtonItem.init(image:nil, style: .plain, target: self, action: #selector(UIViewController.backViewController))
        leftItem.image = img
        self.navigationItem.leftBarButtonItem = leftItem
    }
   
    func hideNavigationBar(){
       //self.navigationController?.isNavigationBarHidden = true;
        self.navigationController?.navigationBar.isHidden = true

    }
    
    func hideNavigationBarWithoutInteractiveGesture(){
       self.navigationController?.isNavigationBarHidden = true;
    }
    
    
    func leftBarItem(image:UIImage,name:String?) -> UIBarButtonItem {
        
        let leftItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: nil)
        leftItem.title = name
        leftItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftItem
        return leftItem
    }
    
    func rightBarItem(image:UIImage?,name:String?) -> UIBarButtonItem {
        
        let rightItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: nil)
        rightItem.title = name
        rightItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightItem
        return rightItem
    }
    
    func getBarButtonItem(image:UIImage?,name:String?)  -> UIBarButtonItem {
        
        let rightItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: nil)
        rightItem.title = name
        rightItem.tintColor = UIColor.white
        return rightItem
    }
    
    @objc func rightBtnClick() {
        
    }
    
    @objc func backViewController() {
        self.navigationController!.popViewController(animated: true)
    }
    
    func configuredMailComposeViewController(recipients : [String]?, subject :
           String, body : String, isHtml : Bool = false,
                   images : [UIImage]?) -> MFMailComposeViewController {
           let mailComposerVC = MFMailComposeViewController()
        
           
           mailComposerVC.setToRecipients(recipients)
           mailComposerVC.setSubject(subject)
           mailComposerVC.setMessageBody(body, isHTML: isHtml)
           
           for img in images ?? [] {
               if let jpegData = img.jpegData(compressionQuality: 1.0) {
                   mailComposerVC.addAttachmentData(jpegData,
                                                    mimeType: "image/jpg",
                                                    fileName: "Image")
               }
           }
           
           return mailComposerVC
       }
       
       func presentMailComposeViewController(mailComposeViewController :
           MFMailComposeViewController) {
           if MFMailComposeViewController.canSendMail() {
               
               self.present(mailComposeViewController,
                                          animated: true, completion: nil)
           } else {
            let sendMailErrorAlert = UIAlertController.init(title: "Error",
                                                               message: "Error opening mail client" +
                "Try Again", preferredStyle: .alert)
                sendMailErrorAlert.addAction(UIAlertAction.init(title: "Okay",
                                                            style: .default, handler: nil))

               self.present(sendMailErrorAlert, animated: true,
                                          completion: nil)
           }
       }
       
       public func mailComposeController(controller: MFMailComposeViewController,
                                         didFinishWith result: MFMailComposeResult,
                                         error: Error?) {
           self.dismiss(animated: true, completion: nil)
       }
}
