//
//  AddWantedItemViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 31/07/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class AddWantedItemViewCtrl: UIViewController {

    @IBOutlet var addButton: UIButton!
    @IBOutlet var categoryTextField: UITextField!
    var categoryStr: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius=5
        // Do any additional setup after loading the view.
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
    @IBAction func backButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "AddWantedItemViewCtrlID") as! AddWantedItemViewCtrl
        navigationController?.pushViewController(myVC, animated: true)

    }
    @IBAction func chooseCategoryButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "AddWantedCategoriesViewCtrlID") as! AddWantedCategoriesViewCtrl
        navigationController?.pushViewController(myVC, animated: true)
    }
    @IBAction func addButtonClicked(_ sender: Any) {
       // UserDefaults.standard.setValue("Yes", forKey: "checkStr")
       // UserDefaults.standard.setValue(categoryTextField.text, forKey: "Category")
        //let myVC = storyboard?.instantiateViewController(withIdentifier: "WantedItemViewCtrlID") as! WantedItemViewCtrl
      //  navigationController?.pushViewController(myVC, animated: true)
        categoryStr = categoryTextField.text
        addWantedDataToDataBase()
    }
   
    
     func addWantedDataToDataBase(){
     EZLoadingActivity.show("Loading...", disableUI: false)
     
     DispatchQueue.global(qos: .background).async {
     
     let myUrl = URL(string: GlobleUrl.BASEURL + "add_wanted_item.php?");
     var request = URLRequest(url:myUrl!)
     request.httpMethod = "POST"
     
    // let fromvalue = self.categoryStr
     let string = "all category "
        
     let postString = "item_name=" + self.categoryStr! + "&" + "sub_item_name=" + string
     
     
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
                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "WantedItemViewCtrlID") as! WantedItemViewCtrl
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
