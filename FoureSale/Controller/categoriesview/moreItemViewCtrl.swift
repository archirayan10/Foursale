//
//  moreItemViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 26/07/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class moreItemViewCtrl: UIViewController, UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var moreItemTableView: UITableView!
    var sectionOneArray: NSMutableArray = NSMutableArray()
    var sectionTwoArray: NSMutableArray = NSMutableArray()
    var sectionThreeArray: NSMutableArray = NSMutableArray()
    var sectionFourArray: NSMutableArray = NSMutableArray()
    var sectionFiveArray: NSMutableArray = NSMutableArray()
    var sectionOneImageArray: NSMutableArray = NSMutableArray()
    var sectionTwoImageArray: NSMutableArray = NSMutableArray()
    var sectionThreeImageArray: NSMutableArray = NSMutableArray()
    var sectionFourImageArray: NSMutableArray = NSMutableArray()
    var sectionFiveImageArray: NSMutableArray = NSMutableArray()
    var languageAndCountryArray: NSMutableArray = NSMutableArray()
    var login = "login"
    
    
    var sectionStr: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = false
        
        sectionOneArray = ["Country","Language"]
        sectionTwoArray = ["4Sale for Web","My Listing","Payment History","Buy More Tokens","My Profile"]
        sectionThreeArray = ["My Fevorites","Recently Viewed","Wanted Items","Notifications"]
        sectionFourArray = ["Like Us On FaceBook","Follow Us On Twitter","View Us On Instagram"]
        sectionFiveArray = ["Agents","Support","About Us","Terms & Conditions","Help"]
        languageAndCountryArray = ["Kuwait","English"]
        
        sectionOneImageArray = [#imageLiteral(resourceName: "flag.png"),#imageLiteral(resourceName: "crossed-flags.png")]
        sectionTwoImageArray = [#imageLiteral(resourceName: "laptop-icon.png"),#imageLiteral(resourceName: "list.png"),#imageLiteral(resourceName: "menu (1).png"),#imageLiteral(resourceName: "online-shop-cart.png"),#imageLiteral(resourceName: "user (1).png")]
        sectionThreeImageArray = [#imageLiteral(resourceName: "heart.png"),#imageLiteral(resourceName: "counterclockwise-rotating-arrow-around-a-clock.png"),#imageLiteral(resourceName: "bookmark-button.png"),#imageLiteral(resourceName: "dialogue.png")]
        sectionFourImageArray = [#imageLiteral(resourceName: "facebook.png"),#imageLiteral(resourceName: "twitter.png"),#imageLiteral(resourceName: "instagram-photo-camera-logo-outline.png")]
        sectionFiveImageArray = [#imageLiteral(resourceName: "seller.png"),#imageLiteral(resourceName: "phone-call.png"),#imageLiteral(resourceName: "warning.png"),#imageLiteral(resourceName: "list (1).png"),#imageLiteral(resourceName: "info.png")]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    /*public func numberOfSections(in tableView: UITableView) -> Int{
     return 5
     }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     
     return " "
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
     if section == 0 {
     return sectionOneArray.count
     }
     else if(section == 1)
     {
     return sectionTwoArray.count
     }
     else if(section == 2){
     return sectionThreeArray.count
     }
     else if(section == 3){
     return sectionFourArray.count
     }
     else if(section == 4){
     return sectionFiveArray.count
     }
     return 0
     
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     let mycell:moreIteamTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! moreIteamTableViewCell
     
     if(indexPath.section == 0)
     {
     mycell.itemNameLabel.text=sectionOneArray[indexPath.row] as? String
     mycell.itemImage.image=sectionOneImageArray[indexPath.row] as? UIImage
     mycell.countryLabel.text=languageAndCountryArray[indexPath.row] as? String
     
     }
     if(indexPath.section == 1)
     {
     mycell.itemNameLabel.text=sectionTwoArray[indexPath.row] as? String
     mycell.itemImage.image=sectionTwoImageArray[indexPath.row] as? UIImage
     mycell.countryLabel.text=" "
     }
     if(indexPath.section == 2)
     {
     mycell.itemNameLabel.text=sectionThreeArray[indexPath.row] as? String
     mycell.itemImage.image=sectionThreeImageArray[indexPath.row] as? UIImage
     mycell.countryLabel.text=" "
     
     }
     if(indexPath.section == 3)
     {
     mycell.itemNameLabel.text=sectionFourArray[indexPath.row] as? String
     mycell.itemImage.image=sectionFourImageArray[indexPath.row] as? UIImage
     mycell.countryLabel.text=" "
     
     }
     if(indexPath.section == 4)
     {
     mycell.itemNameLabel.text=sectionFiveArray[indexPath.row] as? String
     mycell.itemImage.image=sectionFiveImageArray[indexPath.row] as? UIImage
     mycell.countryLabel.text=" "
     }
     
     return mycell
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     var selectedCell = tableView.cellForRow(at: indexPath)
     
     if(indexPath.section == 0){
     if(indexPath.row == 0){
     
     let alert = UIAlertController(title: " ", message: "Select Country", preferredStyle: .actionSheet)
     
     alert.addAction(UIAlertAction(title: "Kuwait - الكويت", style: .default , handler:{ (UIAlertAction)in
     
     alert .removeFromParentViewController()
     
     }))
     
     alert.addAction(UIAlertAction(title: "Cancle", style: .default , handler:{ (UIAlertAction)in
     //alert.view.tintColor = UIColor.red
     alert .removeFromParentViewController()
     }))
     
     
     //alert.popoverPresentationController?.sourceView = selectedCell?.contentView
     //alert.popoverPresentationController?.sourceRect = selectedCell!.contentView.frame
     alert.popoverPresentationController?.sourceView = self.view
     alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
     
     alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 4)
     self.present(alert, animated: true, completion: {
     print("completion block")
     })
     
     }
     else if(indexPath.row == 1){
     let alert = UIAlertController(title: " ", message: "Select Language", preferredStyle: .actionSheet)
     
     alert.addAction(UIAlertAction(title: "English", style: .default , handler:{ (UIAlertAction)in
     alert .removeFromParentViewController()
     
     }))
     
     alert.addAction(UIAlertAction(title: "الكويت", style: .default , handler:{ (UIAlertAction)in
     //alert.view.tintColor = UIColor.red
     alert .removeFromParentViewController()
     }))
     
     alert.addAction(UIAlertAction(title: "Cancle", style: .default , handler:{ (UIAlertAction)in
     //alert.view.tintColor = UIColor.red
     alert .removeFromParentViewController()
     }))
     //alert.popoverPresentationController?.sourceView = selectedCell?.contentView
     //alert.popoverPresentationController?.sourceRect = selectedCell!.contentView.frame
     alert.popoverPresentationController?.sourceView = self.view
     alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
     
     alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 4)
     self.present(alert, animated: true, completion: {
     print("completion block")
     })
     
     }
     }
     if(indexPath.section == 1){
     if(indexPath.row == 0){
     
     }
     if(indexPath.row == 1){
     
     }
     if(indexPath.row == 2){
     
     }
     if(indexPath.row == 3){
     let myVC = storyboard?.instantiateViewController(withIdentifier: "BookMoreTokenViewCtrlID") as! BookMoreTokenViewCtrl
     navigationController?.pushViewController(myVC, animated: true)
     
     }
     if(indexPath.row == 4){
     let myVC = storyboard?.instantiateViewController(withIdentifier: "MyProfileViewCtrlID") as! MyProfileViewCtrl
     navigationController?.pushViewController(myVC, animated: true)
     
     }
     }
     if(indexPath.section == 2){
     if(indexPath.row == 0){
     
     }
     if(indexPath.row == 1){
     
     }
     if(indexPath.row == 2){
     let myVC = storyboard?.instantiateViewController(withIdentifier: "WantedItemViewCtrlID") as! WantedItemViewCtrl
     navigationController?.pushViewController(myVC, animated: true)
     
     }
     if(indexPath.row == 3){
     let myVC = storyboard?.instantiateViewController(withIdentifier: "NotificationViewCtrlID") as! NotificationViewCtrl
     navigationController?.pushViewController(myVC, animated: true)
     }
     }
     if(indexPath.section == 3){
     if(indexPath.row == 0){
     
     }
     if(indexPath.row == 1){
     
     }
     if(indexPath.row == 2){
     
     }
     }
     if(indexPath.section == 4){
     if(indexPath.row == 0){
     
     }
     if(indexPath.row == 1){
     let myVC = storyboard?.instantiateViewController(withIdentifier: "SupportViewCtrlID") as! SupportViewCtrl
     navigationController?.pushViewController(myVC, animated: true)
     
     }
     if(indexPath.row == 2){
     let myVC = storyboard?.instantiateViewController(withIdentifier: "AboutUsViewCtrlID") as! AboutUsViewCtrl
     navigationController?.pushViewController(myVC, animated: true)
     }
     if(indexPath.row == 3){
     let myVC = storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsViewCtrlID") as! TermsAndConditionsViewCtrl
     navigationController?.pushViewController(myVC, animated: true)
     }
     if(indexPath.row == 4){
     let alert = UIAlertController(title: "Tutorial", message: "Would you like to activate your Tutorial again", preferredStyle: .actionSheet)
     
     alert.addAction(UIAlertAction(title: "Activate", style: .default , handler:{ (UIAlertAction)in
     alert .removeFromParentViewController()
     
     }))
     
     alert.addAction(UIAlertAction(title: "Deactivate", style: .default , handler:{ (UIAlertAction)in
     //alert.view.tintColor = UIColor.red
     alert .removeFromParentViewController()
     }))
     
     //alert.popoverPresentationController?.sourceView = selectedCell?.contentView
     //alert.popoverPresentationController?.sourceRect = selectedCell!.contentView.frame
     alert.popoverPresentationController?.sourceView = self.view
     alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
     
     alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 4)
     self.present(alert, animated: true, completion: {
     
     })
     
     
     }
     }
     moreItemTableView.reloadData()
     
     }*/
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 5
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return " "
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return sectionOneArray.count
        }
        else if(section == 1)
        {
            return 1
        }
        else if(section == 2){
            return sectionThreeArray.count
        }
        else if(section == 3){
            return sectionFourArray.count
        }
        else if(section == 4){
            return sectionFiveArray.count
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mycell:moreIteamTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! moreIteamTableViewCell
        
        if(indexPath.section == 0)
        {
            mycell.itemNameLabel.text=sectionOneArray[indexPath.row] as? String
            mycell.itemImage.image=sectionOneImageArray[indexPath.row] as? UIImage
            mycell.countryLabel.text=languageAndCountryArray[indexPath.row] as? String
            
        }
        if(indexPath.section == 1)
        {
            mycell.itemNameLabel.text=login
            mycell.itemImage.image = #imageLiteral(resourceName: "web-log-in")
            mycell.countryLabel.text=" "
        }
        if(indexPath.section == 2)
        {
            mycell.itemNameLabel.text=sectionThreeArray[indexPath.row] as? String
            mycell.itemImage.image=sectionThreeImageArray[indexPath.row] as? UIImage
            mycell.countryLabel.text=" "
            
        }
        if(indexPath.section == 3)
        {
            mycell.itemNameLabel.text=sectionFourArray[indexPath.row] as? String
            mycell.itemImage.image=sectionFourImageArray[indexPath.row] as? UIImage
            mycell.countryLabel.text=" "
            
        }
        if(indexPath.section == 4)
        {
            mycell.itemNameLabel.text=sectionFiveArray[indexPath.row] as? String
            mycell.itemImage.image=sectionFiveImageArray[indexPath.row] as? UIImage
            mycell.countryLabel.text=" "
        }
        
        return mycell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedCell = tableView.cellForRow(at: indexPath)
        
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                
                let alert = UIAlertController(title: " ", message: "Select Country", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Kuwait - الكويت", style: .default , handler:{ (UIAlertAction)in
                    
                    alert .removeFromParentViewController()
                    
                }))
                
                alert.addAction(UIAlertAction(title: "Cancle", style: .default , handler:{ (UIAlertAction)in
                    //alert.view.tintColor = UIColor.red
                    alert .removeFromParentViewController()
                }))
                
                
                //alert.popoverPresentationController?.sourceView = selectedCell?.contentView
                //alert.popoverPresentationController?.sourceRect = selectedCell!.contentView.frame
                alert.popoverPresentationController?.sourceView = self.view
                alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                
                alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 4)
                self.present(alert, animated: true, completion: {
                    print("completion block")
                })
                
            }
            else if(indexPath.row == 1){
                let alert = UIAlertController(title: " ", message: "Select Language", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "English", style: .default , handler:{ (UIAlertAction)in
                    alert .removeFromParentViewController()
                    
                }))
                
                alert.addAction(UIAlertAction(title: "الكويت", style: .default , handler:{ (UIAlertAction)in
                    //alert.view.tintColor = UIColor.red
                    alert .removeFromParentViewController()
                }))
                
                alert.addAction(UIAlertAction(title: "Cancle", style: .default , handler:{ (UIAlertAction)in
                    //alert.view.tintColor = UIColor.red
                    alert .removeFromParentViewController()
                }))
                //alert.popoverPresentationController?.sourceView = selectedCell?.contentView
                //alert.popoverPresentationController?.sourceRect = selectedCell!.contentView.frame
                alert.popoverPresentationController?.sourceView = self.view
                alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                
                alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 4)
                self.present(alert, animated: true, completion: {
                    print("completion block")
                })
                
            }
        }
        if(indexPath.section == 1){
            if(indexPath.row == 0){
                let myVC = storyboard?.instantiateViewController(withIdentifier: "RegisterViewCtrlID") as! RegisterViewCtrl
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromTop;
                navigationController?.view.layer.add(transition, forKey: kCATransition)
                navigationController?.pushViewController(myVC, animated: true)
            }
            
        }
        if(indexPath.section == 2){
            if(indexPath.row == 0){
                
            }
            if(indexPath.row == 1){
                
            }
            if(indexPath.row == 2){
                let myVC = storyboard?.instantiateViewController(withIdentifier: "WantedItemViewCtrlID") as! WantedItemViewCtrl
                navigationController?.pushViewController(myVC, animated: true)
                
            }
            if(indexPath.row == 3){
                let myVC = storyboard?.instantiateViewController(withIdentifier: "NotificationViewCtrlID") as! NotificationViewCtrl
                navigationController?.pushViewController(myVC, animated: true)
            }
        }
        if(indexPath.section == 3){
            if(indexPath.row == 0){
                
            }
            if(indexPath.row == 1){
                
            }
            if(indexPath.row == 2){
                
            }
        }
        if(indexPath.section == 4){
            if(indexPath.row == 0){
                
            }
            if(indexPath.row == 1){
                let myVC = storyboard?.instantiateViewController(withIdentifier: "SupportViewCtrlID") as! SupportViewCtrl
                navigationController?.pushViewController(myVC, animated: true)
                
            }
            if(indexPath.row == 2){
                let myVC = storyboard?.instantiateViewController(withIdentifier: "AboutUsViewCtrlID") as! AboutUsViewCtrl
                navigationController?.pushViewController(myVC, animated: true)
            }
            if(indexPath.row == 3){
                let myVC = storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsViewCtrlID") as! TermsAndConditionsViewCtrl
                navigationController?.pushViewController(myVC, animated: true)
            }
            if(indexPath.row == 4){
                let alert = UIAlertController(title: "Tutorial", message: "Would you like to activate your Tutorial again", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Activate", style: .default , handler:{ (UIAlertAction)in
                    alert .removeFromParentViewController()
                    
                }))
                
                alert.addAction(UIAlertAction(title: "Deactivate", style: .default , handler:{ (UIAlertAction)in
                    //alert.view.tintColor = UIColor.red
                    alert .removeFromParentViewController()
                }))
                
                //alert.popoverPresentationController?.sourceView = selectedCell?.contentView
                //alert.popoverPresentationController?.sourceRect = selectedCell!.contentView.frame
                alert.popoverPresentationController?.sourceView = self.view
                alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                
                alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 4)
                self.present(alert, animated: true, completion: {
                    
                })
                
                
            }
        }
        moreItemTableView.reloadData()
        
    }
    
    
}
