//
//  AddWantedCategoriesViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 10/08/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class AddWantedCategoriesViewCtrl: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var categoryTableView: UITableView!
    var categoryDataArray: NSMutableArray = NSMutableArray()
    var countArray: NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GetCategoryData()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupUI() {
        categoryTableView.estimatedRowHeight = 100
        categoryTableView.rowHeight = UITableViewAutomaticDimension
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func GetCategoryData(){
        //get_high_score.php?from=1472409001482&number=10&to=1493657787867
        EZLoadingActivity.show("Loading...", disableUI: false)
        
        DispatchQueue.global(qos: .background).async {
            
            let myUrl = URL(string: GlobleUrl.BASEURL + "category.php");
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "GET"
            
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
                                
                                self.categoryDataArray =  parseJSON["data"] as! NSMutableArray
                                print(self.categoryDataArray)
                                
                                let teamp = self.categoryDataArray .value(forKey: "name") as AnyObject
                                print("\(teamp)")
                                self.countArray.setArray(teamp as! [Any])
                                
                                //let subCatStatus = self.data .value(forKey: "sub_status") as AnyObject
                               // print("\(subCatStatus)")
                                
                               // print("\(self.headerTitlesNew)")
                                
                                
                                self.categoryTableView.reloadData()
                                
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mycell:AddwantedtCategoriesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddwantedtCategoriesTableViewCell
        //if(categoryDataArray.count > 0){
          let categoryName = categoryDataArray.value(forKey: "name") as? [String]
            mycell.categoryName?.text = categoryName?[indexPath.row]
            if let strImage = categoryDataArray.value(forKey: "image") as? String{
                // ... your strImage is String  ...
                // let imgstr = strImage[indexPath .row]
                if let data = NSData(contentsOf: NSURL(string:strImage ) as! URL) {
                    mycell.categoryImage.image = UIImage(data: data as Data)
         
                }
            }
        //}
        
        return mycell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
    }



}
