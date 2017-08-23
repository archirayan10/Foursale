//
//  WantedItemViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 31/07/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class WantedItemViewCtrl: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var wantedItemListTableVIew: UITableView!
    var categoryNameArray: NSMutableArray = NSMutableArray()
    var idString: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(UserDefaults.standard.value(forKey: "checkStr") as? String == "Yes"){
                           let str = UserDefaults.standard.value(forKey: "Category") as? String
              //  categoryNameArray .add(str!)
                let array: NSMutableArray = NSMutableArray()
                array .addObjects(from: categoryNameArray as? Any as! [Any])
            for i in 0..<categoryNameArray.count{
                categoryNameArray[i] = str
            }
           
                print("\(array)")
                // categoryNameArray = [(UserDefaults.standard.value(forKey: "Category") as AnyObject)]
                print("\(categoryNameArray)")
            
            wantedItemListTableVIew .reloadData()
             GetLeaderboardData()
        }
        
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
    // MARK: - Button Action Method
    
    @IBAction func BackButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "moreItemViewCtrlID") as! moreItemViewCtrl
        navigationController?.pushViewController(myVC, animated: true)

    }
    @IBAction func addButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "AddWantedItemViewCtrlID") as! AddWantedItemViewCtrl
        navigationController?.pushViewController(myVC, animated: true)

    }
    
    // Delete Category in table view
    func DeleteButtonClicked(sender: AnyObject) {
    
        let button = sender as! UIButton
        _ = button.tag
        let teamp = categoryNameArray .value(forKey: "item_id") as AnyObject

        for i in 0..<categoryNameArray.count{
            if(button.tag == i){
                //categoryNameArray.removeObject(at: i)
                               // idString = categoryNameArray .value(forKey: "item_id") as! String
                print("\(teamp)")
                idString = (teamp .object(at: i) as? String)!
                    // idString = i.categoryNameArray .value(forKey: "item_id") as! String
                print("\(idString)")
                DeleteWantedItem()
            }
        }
        wantedItemListTableVIew.reloadData()
    }

    // Mark: - TableView Deleget Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categoryNameArray.count
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mycell:WantedItemTableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WantedItemTableCell
        
        let categoryName = categoryNameArray.value(forKey: "item_name") as? [String]
        mycell.categoryNameLabel?.text = categoryName?[indexPath.row]
        mycell.deleteButton .tag = indexPath.row
        let expiryDate = categoryNameArray.value(forKeyPath: "expiry_date") as? [String]
       
        mycell.expiryDateLabel?.text = expiryDate?[indexPath.row]
        
        mycell.deleteButton.addTarget(self, action:#selector(DeleteButtonClicked), for: UIControlEvents.touchUpInside)
        return mycell
    }
    
     func GetLeaderboardData(){
        //get_high_score.php?from=1472409001482&number=10&to=1493657787867
        EZLoadingActivity.show("Loading...", disableUI: false)
     
        DispatchQueue.global(qos: .background).async {
     
            let myUrl = URL(string: GlobleUrl.BASEURL + "get_item1.php");
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "GET"
     
            // let fromvalue = 1472409001482
            // let numbervalue = 10
            // let tovalue = 1493657787867
            let postString = ""//"from=" + fromvalue + "&" + "number=" + numbervalue + "&" + "to=" + tovalue
     
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
     
                            print(parseJSON)
                            let status =   parseJSON["status"] as! String
     
                            if status == "true"{
     
                                EZLoadingActivity.hide(true, animated: false)
     
                                self.categoryNameArray =  parseJSON["items_detail"] as! NSMutableArray
                                print("\(data)")
                                //  let teamp = self.data .value(forKey: "name") as AnyObject
                                // print("\(teamp)")
                                //  self.categoryNameArray.setArray(teamp as! [Any])
     
     
                                self.wantedItemListTableVIew.reloadData()
                                //   self.tblscoreList.reloadData()
     
                            }else{
                                EZLoadingActivity.hide(false, animated: true)
                            }
     
                        }
                    }
                }
                catch {
                    EZLoadingActivity.hide(false, animated: true)
                    let alert = UIAlertController(title: "", message: "Something going wrong", preferredStyle:     UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(error)
                }
            }
            task.resume()
            }
        }
    
    
    func DeleteWantedItem(){
        //get_high_score.php?from=1472409001482&number=10&to=1493657787867
        EZLoadingActivity.show("Loading...", disableUI: false)
        
        DispatchQueue.global(qos: .background).async {
            
            let myUrl = URL(string: GlobleUrl.BASEURL + "remove_item.php?");
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "Post"
            
            // let fromvalue = 1472409001482
            // let numbervalue = 10
            // let tovalue = 1493657787867
            let postString = "item_id=" + self.idString!
            
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
                            
                            print(parseJSON)
                            let status =   parseJSON["status"] as! String
                            
                            if status == "true"{
                                
                                EZLoadingActivity.hide(true, animated: false)
                                
                               
                                //  let teamp = self.data .value(forKey: "name") as AnyObject
                                // print("\(teamp)")
                                //  self.categoryNameArray.setArray(teamp as! [Any])
                                self.GetLeaderboardData()
                                
                                self.wantedItemListTableVIew.reloadData()
                                //   self.tblscoreList.reloadData()
                                
                            }else{
                                EZLoadingActivity.hide(false, animated: true)
                            }
                            
                        }
                    }
                }
                catch {
                    EZLoadingActivity.hide(false, animated: true)
                    let alert = UIAlertController(title: "", message: "Something going wrong", preferredStyle:     UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(error)
                }
            }
            task.resume()
        }
    }

}
