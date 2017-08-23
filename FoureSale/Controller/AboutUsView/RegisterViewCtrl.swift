//
//  RegisterViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 22/08/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class RegisterViewCtrl: UIViewController, UITextFieldDelegate {
   
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    var dataArray: NSMutableArray = NSMutableArray()

    
    let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
    let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
    var __emailRegex: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerButton.layer.cornerRadius = 5
       __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,6}"
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
    @IBAction func registerButtonClicked(_ sender: Any) {
        if (phoneNumberTextField.text?.characters.count)! >= 8 && (phoneNumberTextField.text?.characters.count)! <= 9{
           if NSPredicate(format: "SELF MATCHES %@", __emailRegex).evaluate(with: emailAddressTextField.text){
                let phonecode = "+965"
                let phonenumber = phoneNumberTextField.text
                let joinNumber = phonecode + "" + phonenumber!
                UserDefaults.standard.setValue(joinNumber, forKey: "PhoneNumber")
                UserDefaults.standard.setValue(emailAddressTextField.text, forKey: "email")
            registration()
            
            /*let myVC = storyboard?.instantiateViewController(withIdentifier: "VerifyViewCtrlID") as! VerifyViewCtrl
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromTop;
            navigationController?.view.layer.add(transition, forKey: kCATransition)
            navigationController?.pushViewController(myVC, animated: true)*/

            
            }
        }
        else{
            
        }
    }

    

       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if(textField == phoneNumberTextField){
            let length = (textField.text?.characters.count)! - range.length + string.characters.count
            if length >= 8 && length <= 9 {
                phoneNumberTextField.textColor = UIColor .black
            }
            else {
                phoneNumberTextField.textColor = UIColor .red
            }
        }
        else{
            if NSPredicate(format: "SELF MATCHES %@", __emailRegex).evaluate(with: emailAddressTextField.text){
                emailAddressTextField.textColor = UIColor .black
        }
        else{
                emailAddressTextField.textColor = UIColor .red
            }
        }
        return true
    }
    
    func registration(){
        EZLoadingActivity.show("Loading...", disableUI: false)
        
        DispatchQueue.global(qos: .background).async {
            
            let myUrl = URL(string: GlobleUrl.BASEURL + "regisater.php?");
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "POST"
            
            // let fromvalue = self.categoryStr
            let phonecode = "+965"
            let phonenumber = self.phoneNumberTextField.text
            let joinNumber = phonecode + "" + phonenumber!
            
            let postString = "email=" + self.emailAddressTextField.text! + "&" + "mobile_no=" + joinNumber
            
            
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
                                
                                 //self.dataArray =  parseJSON as! NSMutableArray
                              //  print(self.dataArray)
                               // let otp = self.dataArray .value(forKey: "otp")
                              //  UserDefaults.standard.setValue(otp, forKey: "Otp")
                                //print("\(otp)")
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
