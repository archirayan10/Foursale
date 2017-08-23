//
//  CategoriesListViewCtrl.swift
//  FoureSale
//
//  Created by archirayan on 6/22/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class CategoriesListViewCtrl: UIViewController , UITableViewDelegate, UITableViewDataSource{
  
    
    @IBOutlet var CategoriesTableview:UITableView!
    
    var storedOffsets = [Int: CGFloat]()
    var headerTitles = ["Some Data 1", "Kick"]
    var headerTitlesNew: NSMutableArray = NSMutableArray()
    var data:NSMutableArray = NSMutableArray()
    var subCategoryNameArray: NSMutableArray = NSMutableArray()
    var subCategoryArray: NSMutableArray = NSMutableArray()
    var nameArray: NSMutableArray = NSMutableArray()

    
    var IndSection: Int = 0
    
    @IBOutlet weak var menuNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          GetLeaderboardData()
        //  model = generateRandomData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitlesNew.count

    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitlesNew.count {
            print("\(headerTitlesNew)")
            return headerTitlesNew[section] as? String
           
        }
    return nil
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        let subCatStatus = self.data .value(forKey: "sub_status") as! [AnyObject]
        print("\(subCatStatus)")
       
            if((subCatStatus[section] as! Bool) == true){
    
                return 1
            }else{
                return 0
            }
        
    }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mycell:categoriesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! categoriesTableViewCell
    
        return mycell
    
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        guard let tableViewCell = cell as? categoriesTableViewCell else { return }
        
        let subCatStatus = self.data .value(forKey: "sub_status") as! [AnyObject]
        print("\(subCatStatus)")
        
        if((subCatStatus[indexPath.section] as! Bool) == true){
            
            let teamp = (self.data[indexPath.section] as AnyObject) .value(forKey: "sub") as AnyObject
            print("\(teamp)")
            self.subCategoryArray.setArray(teamp as! [Any])
            let name = self.subCategoryArray .value(forKey: "name") as AnyObject
            print("\(name)")
            self.subCategoryNameArray.setArray(name as! [Any])
            let image = self.subCategoryArray .value(forKey: "image") as AnyObject
            print("\(image)")
            self.subCategoryNameArray.setArray(image as! [Any])
          
            
        }

        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.section] ?? 0
       
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? categoriesTableViewCell else { return }
        
        storedOffsets[indexPath.section] = tableViewCell.collectionViewOffset
    }

    func GetLeaderboardData(){
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
                                
                                self.data =  parseJSON["data"] as! NSMutableArray
                                print(self.data)
                                
                              let teamp = self.data .value(forKey: "name") as AnyObject
                                 print("\(teamp)")
                                self.headerTitlesNew.setArray(teamp as! [Any])
                                
                                let subCatStatus = self.data .value(forKey: "sub_status") as AnyObject
                                print("\(subCatStatus)")
                       
                                
                                 print("\(self.headerTitlesNew)")
                               
                                
                                self.CategoriesTableview.reloadData()
                                
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
extension CategoriesListViewCtrl: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        let subCatStatus = self.data .value(forKey: "sub_status") as! [AnyObject]
        print("\(subCatStatus)")
        
        if((subCatStatus[collectionView.tag] as! Bool) == true){
        
               return ((self.data[collectionView.tag] as AnyObject) .value(forKey: "sub") as AnyObject ).count
        }else{
        
            return 0
        }
            
     
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! categoriesCollectionViewCell
        
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
         cell.categoriesimageview.clipsToBounds=true
        cell.categoriesimageview.layer.cornerRadius=cell.frame.size.width/2
        
        
        cell.categoriesimageview.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        

        let subCatStatus = self.data .value(forKey: "sub_status") as! [AnyObject]
        print("\(subCatStatus)")
        
        if((subCatStatus[collectionView.tag] as! Bool) == true){
            
            let teamp = (self.data[collectionView.tag] as AnyObject) .value(forKey: "sub") as AnyObject
            print("\(teamp)")
            self.subCategoryArray.setArray(teamp as! [Any])
            let name = self.subCategoryArray .value(forKey: "name") as AnyObject
            print("\(name)")
            self.subCategoryNameArray.setArray(name as! [Any])
            let image = self.subCategoryArray .value(forKey: "image") as AnyObject
            print("\(image)")
            self.subCategoryNameArray.setArray(image as! [Any])
            
            
         // cell.categoriesNameLabel.text = ((self.data[collectionView.tag] as AnyObject) .value(forKey: "sub") as AnyObject ) .object(at: indexPath.row) .val
            
            let labelContent = subCategoryArray .value(forKey: "name") as? [String]
            cell.categoriesNameLabel.text=labelContent?[indexPath.row]
            if(subCategoryNameArray.count > 0){
                if let strImage = subCategoryNameArray[indexPath .row] as? String{
                    // ... your strImage is String  ...
                    // let imgstr = strImage[indexPath .row]
                    if let data = NSData(contentsOf: NSURL(string:strImage ) as! URL) {
                        cell.categoriesimageview.image = UIImage(data: data as Data)
                        
                    }
                }
            }
            
        
            
            
        }

    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let subCatStatus = self.data .value(forKey: "sub_status") as! [AnyObject]
        print("\(subCatStatus)")
         let categoryname = self.data .value(forKey: "name") as! [AnyObject]
        
        if((subCatStatus[collectionView.tag] as! Bool) == true){
            
            
            let teamp = (self.data[collectionView.tag] as AnyObject) .value(forKey: "sub") as AnyObject
            print("\(teamp)")
            
            let subCatStatusinside = teamp .value(forKey: "sub_status") as! [AnyObject]
            print("\(subCatStatusinside)")
             let categoryname = teamp .value(forKey: "name") as! [AnyObject]
            
            
            if((subCatStatusinside[indexPath.row] as! Bool) == true){
                
                let teamp1 = (((self.data[collectionView.tag] as AnyObject) .value(forKey: "sub") as AnyObject) .object(at: indexPath.row) as AnyObject) .value(forKey: "sub") as AnyObject
                print("\(teamp1)")
            let myVC = storyboard?.instantiateViewController(withIdentifier: "subcategoryview") as! subcategoriesListviewCtrl
                myVC.subcategoryarray = teamp1 as! NSMutableArray
                myVC.titlestring = categoryname[indexPath.row] as! String
                navigationController?.pushViewController(myVC, animated: true)
                
            }
            
            
        
        
        }
    

        
   
        
       // performSegue(withIdentifier: "subcategories", sender: nil)
        
    }
}
