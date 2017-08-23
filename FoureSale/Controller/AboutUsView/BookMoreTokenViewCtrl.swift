//
//  BookMoreTokenViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 29/07/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class BookMoreTokenViewCtrl: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var bookTokenTableView: UITableView!
    
    var data:NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        GetLeaderboardData()

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
   // MARK: - Button Action Method
    @IBAction func backButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "moreItemViewCtrlID") as! moreItemViewCtrl
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    // MARK: - TableView Deleget Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let mycell:BookTokenTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BookTokenTableViewCell
        
     //  mycell.amount.text = (self.data[indexPath.row]["amount"] as? String)!
         let data:NSMutableDictionary = self.data[indexPath.row] as! NSMutableDictionary
        NSLog("%@", data["amount"] as! String);
        
        
       mycell.amount.text = data["amount"] as! String
    mycell.desc.text = data["desc"] as! String
        mycell.title.text = data["name"] as! String
        mycell.point.text = data["point"] as! String
        
        return mycell
    }
    func GetLeaderboardData(){
        //get_high_score.php?from=1472409001482&number=10&to=1493657787867
        EZLoadingActivity.show("Loading...", disableUI: false)
        
        DispatchQueue.global(qos: .background).async {
            
            let myUrl = URL(string: GlobleUrl.BASEURL + "packages.php");
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
                                
                                self.data =  parseJSON["data"] as! NSMutableArray
                                print(self.data)
                                
                                
                                
                                self.bookTokenTableView.reloadData()
                                
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

