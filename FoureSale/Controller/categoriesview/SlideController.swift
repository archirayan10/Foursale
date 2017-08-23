//
//  SlideController.swift
//  PhotoSlideShow-Swift
//
//  Created by VillyG on 4/21/15.
//  Copyright (c) 2015 VillyG. All rights reserved.
//

import UIKit


class SlideController: UIViewController, UIDocumentInteractionControllerDelegate {
    var documentIC: UIDocumentInteractionController!
    
    var itemIndex: Int = -1
    
    var image: UIImage!
    
    
    
    // ***********************************************
    // MARK: UIView
    // ***********************************************
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        let scrollView: ImageScrollView = ImageScrollView()
        
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = UIColor.black
        self.view = scrollView
        scrollView.displayImage(image)
     
        if UIDevice.current.userInterfaceIdiom == .pad {
            let productNameLabel = UILabel()
            productNameLabel.backgroundColor = UIColor.clear
            productNameLabel.frame = CGRect(x: 10, y: 960, width: 200, height: 30)
            productNameLabel.textColor = UIColor.white
            productNameLabel.text = "product_title"
            scrollView.addSubview(productNameLabel)
            
            let viwedImage = UIImageView()
            viwedImage.frame = CGRect(x: 10, y: 990, width: 30, height: 30)
            viwedImage.image = #imageLiteral(resourceName: "visible")
            scrollView.addSubview(viwedImage)
            
            let ViewedLabel = UILabel()
            ViewedLabel.backgroundColor = UIColor.clear
            ViewedLabel.frame = CGRect(x: viwedImage.frame.size.width+10, y: 990, width: 200, height: 30)
            ViewedLabel.textColor = UIColor.white
            ViewedLabel.text = "20"
            scrollView.addSubview(ViewedLabel)
            
            let likedImage = UIImageView()
            likedImage.frame = CGRect(x: 565, y: 990, width: 30, height: 30)
            likedImage.image = #imageLiteral(resourceName: "like")
            scrollView.addSubview(likedImage)
            
            let likedLabel = UILabel()
            likedLabel.backgroundColor = UIColor.clear
            likedLabel.frame = CGRect(x: 605, y: 990, width: 30, height: 30)
            likedLabel.textColor = UIColor.white
            likedLabel.text = "10"
            scrollView.addSubview(likedLabel)
            
            let whatsappButton = UIButton(type: .custom) as UIButton
            whatsappButton.backgroundColor = UIColor.clear
            whatsappButton.frame = CGRect(x: 650, y: 990, width: 30, height: 30)
            whatsappButton.setImage(#imageLiteral(resourceName: "whatsapp-logo"), for: .normal)
            whatsappButton.addTarget(self, action: #selector(whatsAppButtonClicked), for: .touchUpInside)
            scrollView.addSubview(whatsappButton)
            
            let browserButton = UIButton(type: .custom) as UIButton
            browserButton.backgroundColor = UIColor.clear
            browserButton.frame = CGRect(x: 690, y: 990, width: 30, height: 30)
            browserButton.setImage(#imageLiteral(resourceName: "world-wide-web"), for: .normal)
            browserButton.addTarget(self, action: #selector(browserButtonClicked), for: .touchUpInside)
            scrollView.addSubview(browserButton)
            
            let callButton = UIButton(type: .custom) as UIButton
            callButton.backgroundColor = UIColor.clear
            callButton.frame = CGRect(x: 730, y: 990, width: 30, height: 30)
            callButton.setImage(#imageLiteral(resourceName: "phone-call-1"), for: .normal)
            callButton.addTarget(self, action: #selector(callButtonClicke), for: .touchUpInside)
            scrollView.addSubview(callButton)
            
            let closeButton = UIButton(type: .custom) as UIButton
            closeButton.backgroundColor = UIColor.clear
            closeButton.setTitle("Close", for: .normal)
            closeButton.setTitleColor(UIColor.white, for: .normal)
            closeButton.frame = CGRect(x: 700, y: 20, width: 60, height: 30)
            closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
            scrollView.addSubview(closeButton)
 
        }
        else{
            let productNameLabel = UILabel()
            productNameLabel.backgroundColor = UIColor.clear
            productNameLabel.frame = CGRect(x: 10, y: 670, width: 200, height: 30)
            productNameLabel.textColor = UIColor.white
            productNameLabel.text = "product_title"
            scrollView.addSubview(productNameLabel)
        
            let viwedImage = UIImageView()
            viwedImage.frame = CGRect(x: 10, y: 700, width: 30, height: 30)
            viwedImage.image = #imageLiteral(resourceName: "visible")
            scrollView.addSubview(viwedImage)
        
            let ViewedLabel = UILabel()
            ViewedLabel.backgroundColor = UIColor.clear
            ViewedLabel.frame = CGRect(x: viwedImage.frame.size.width+10, y: 700, width: 200, height: 30)
            ViewedLabel.textColor = UIColor.white
            ViewedLabel.text = "20"
            scrollView.addSubview(ViewedLabel)
        
            let likedImage = UIImageView()
            likedImage.frame = CGRect(x: 229, y: 700, width: 30, height: 30)
            likedImage.image = #imageLiteral(resourceName: "like")
            scrollView.addSubview(likedImage)
        
            let likedLabel = UILabel()
            likedLabel.backgroundColor = UIColor.clear
            likedLabel.frame = CGRect(x: 264, y: 700, width: 30, height: 30)
            likedLabel.textColor = UIColor.white
            likedLabel.text = "10"
            scrollView.addSubview(likedLabel)

            let whatsappButton = UIButton(type: .custom) as UIButton
            whatsappButton.backgroundColor = UIColor.clear
            whatsappButton.frame = CGRect(x: 304, y: 700, width: 30, height: 30)
            whatsappButton.setImage(#imageLiteral(resourceName: "whatsapp-logo"), for: .normal)
            whatsappButton.addTarget(self, action: #selector(whatsAppButtonClicked), for: .touchUpInside)
            scrollView.addSubview(whatsappButton)
        
            let browserButton = UIButton(type: .custom) as UIButton
            browserButton.backgroundColor = UIColor.clear
            browserButton.frame = CGRect(x: 344, y: 700, width: 30, height: 30)
            browserButton.setImage(#imageLiteral(resourceName: "world-wide-web"), for: .normal)
            browserButton.addTarget(self, action: #selector(browserButtonClicked), for: .touchUpInside)
            scrollView.addSubview(browserButton)
            
            let callButton = UIButton(type: .custom) as UIButton
            callButton.backgroundColor = UIColor.clear
            callButton.frame = CGRect(x: 384, y: 700, width: 30, height: 30)
            callButton.setImage(#imageLiteral(resourceName: "phone-call-1"), for: .normal)
            callButton.addTarget(self, action: #selector(callButtonClicke), for: .touchUpInside)
            scrollView.addSubview(callButton)
            
            let closeButton = UIButton(type: .custom) as UIButton
            closeButton.backgroundColor = UIColor.clear
            closeButton.setTitle("Close", for: .normal)
            closeButton.setTitleColor(UIColor.white, for: .normal)
            closeButton.frame = CGRect(x: 354, y: 20, width: 60, height: 30)
            closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
            scrollView.addSubview(closeButton)
          

        }
        
    }
    
    @IBAction func callButtonClicke(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: "9876543210", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            UIAlertAction in
            alertController .removeFromParentViewController()
            
        }
        let cancelAction = UIAlertAction(title: "Call", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            let phoneNumber = "9876543210"
            if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        
        // Add the actions
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func closeButtonClicked(_ sender: Any) {

        let myVC = storyboard?.instantiateViewController(withIdentifier: "AllCategoryViewCtrlID") as! AllCategoryViewCtrl
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromBottom;
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(myVC, animated: true)

    }
    @IBAction func browserButtonClicked(_ sender: Any){
        let myVC = storyboard?.instantiateViewController(withIdentifier: "FoureSaleWebViewCtrlID") as! FoureSaleWebViewCtrl
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(myVC, animated: true)

    }
    /*@IBAction func whatsAppButtonClicked(_ sender: Any){
        let date = Date()
        let msg = "Hi my dear friends\(date)"
        let urlWhats = "whatsapp://send?text=\(msg)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                    }
                } else {
                    print("please install watsapp")
                    let alert = UIAlertController(title: "Alert", message: "Please Install Whatsapp", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }*/
    @IBAction func whatsAppButtonClicked(_ sender: Any){
        let urlWhats = "whatsapp://app"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlUserAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    
                   // if let image = UIImage(named: "twitter") {
                    if let image = image {
                        if let imageData = UIImageJPEGRepresentation(image, 1.0) {
                            let tempFile = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
                            do {
                                try imageData.write(to: tempFile!, options: .atomic)
                                
                                self.documentIC = UIDocumentInteractionController(url: tempFile!)
                                self.documentIC.uti = "net.whatsapp.image"
                                self.documentIC.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)                            } catch {
                                print(error)
                            }
                        }
                    }
                    
                } else {
                    // Cannot open whatsapp
                    let alert = UIAlertController(title: "Alert", message: "Please Install Whatsapp", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
