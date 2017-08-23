//
//  VerifyViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 22/08/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class VerifyViewCtrl: UIViewController, UITextFieldDelegate {
    @IBOutlet var verificationNumberLabel: UILabel!
    @IBOutlet var verificationCodeTextField: UITextField!
    @IBOutlet var termsAndCondationLabel: UILabel!
    @IBOutlet var verifyButton: UIButton!
    @IBOutlet var resendButton: UIButton!
    @IBOutlet var changeNumberButton: UIButton!
    @IBOutlet var termsAndCondationSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

         verifyButton.layer.backgroundColor = UIColor(red:184/255.0, green:184/255.0, blue:184/255.0, alpha: 0.5).cgColor
        // Do any additional setup after loading the view.
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Accept Terms & Conditions", attributes: underlineAttribute)
        termsAndCondationLabel.attributedText = underlineAttributedString
        
        verifyButton.layer.cornerRadius = 5
        resendButton.layer.cornerRadius = 5
        changeNumberButton.layer.cornerRadius = 5
        
        
        var numberStr = "Please enter your verification code sent to you on"
        var phoneStr = UserDefaults.standard.value(forKey: "PhoneNumber") as? String
        var joinstr = numberStr + "" + phoneStr!
        verificationNumberLabel.text = joinstr
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
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        let length = (textField.text?.characters.count)! - range.length + string.characters.count
        if length == 5{
            verifyButton.layer.backgroundColor = UIColor(red:0/255.0, green:181/255.0, blue:255/255.0, alpha: 1.0).cgColor
            verifyButton.titleLabel?.textColor = UIColor .white
            
        }
        else if(length < 5){
            verifyButton.layer.backgroundColor = UIColor(red:184/255.0, green:184/255.0, blue:184/255.0, alpha: 0.5).cgColor
            verifyButton.titleLabel?.textColor = UIColor .black
        }
        return !(length > 5)
    }
    
    
    
    @IBAction func cancleButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "moreItemViewCtrlID") as! moreItemViewCtrl
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromBottom;
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(myVC, animated: true)

    }
    @IBAction func resendButtonClicked(_ sender: Any) {
        resendVerificationCode()
    }
    @IBAction func changeNumberButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "VerifyViewCtrlID") as! VerifyViewCtrl
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(myVC, animated: true)
    }
    @IBAction func verifyButtonClicked(_ sender: Any) {
        if((verificationCodeTextField.text?.characters.count) == 5){
            if termsAndCondationSwitch.isOn{
               
                print("hello")
                let myVC = storyboard?.instantiateViewController(withIdentifier: "moreItemViewCtrlID") as! moreItemViewCtrl
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromBottom;
                navigationController?.view.layer.add(transition, forKey: kCATransition)
                navigationController?.pushViewController(myVC, animated: true)
                
            }
        }
        else{
            
        }
        verifyButton.titleLabel?.textColor = UIColor .white
    }
    
    
    func resendVerificationCode(){
        EZLoadingActivity.show("Loading...", disableUI: false)
        
        DispatchQueue.global(qos: .background).async {
            
            let myUrl = URL(string: GlobleUrl.BASEURL + "regisater.php?");
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "POST"
            
            // let fromvalue = self.categoryStr
            let email = UserDefaults.standard.value(forKey: "email") as? String
            let phone = UserDefaults.standard.value(forKey: "PhoneNumber") as? String
            
            let postString = "email=" + email! + "&" + "mobile_no=" + phone!
            
            
            request.httpBody = postString.data(using: String.Encoding.utf8);
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil
                {
                    EZLoadingActivity.hide(false, animated: true)
                    print("error=\(error)")
                    let alert = UIAlertController(title: "", message: "Something going wrong", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
                
                
                print("response = \(response)")
                
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    
                    DispatchQueue.main.async {
                        
                        if let parseJSON = json {
                            //  let str: Bool? = true
                            print(parseJSON)
                            let status =   parseJSON["status"] as! String
                            
                            if status == "true"{
                                
                                EZLoadingActivity.hide(true, animated: false)
                                
                                // self.data =  parseJSON["data"] as! NSMutableArray
                                // print(self.data)
                                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyViewCtrlID") as! VerifyViewCtrl
                                let transition = CATransition()
                                transition.duration = 0.5
                                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                                transition.type = kCATransitionPush;
                                transition.subtype = kCATransitionFromTop;
                                self.navigationController?.view.layer.add(transition, forKey: kCATransition)
                                self.navigationController?.pushViewController(myVC, animated: true)
                                
                            }else{
                                EZLoadingActivity.hide(false, animated: true)
                            }
                            
                        }
                    }
                }
                catch {
                    EZLoadingActivity.hide(false, animated: true)
                    let alert = UIAlertController(title: "", message: "Something going wrong", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(error)
                }
            }
            task.resume()
        }
        
    }

   

}
