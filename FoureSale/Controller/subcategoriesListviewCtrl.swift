//
//  subcategoriesListviewCtrl.swift
//  FoureSale
//
//  Created by archirayan on 6/29/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit


class subcategoriesListviewCtrl: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource{
 
    @IBOutlet var SubCategoriescollectionview:UICollectionView!
    @IBOutlet var BackButton:UIButton!
    var maincategorarray : NSMutableArray = NSMutableArray()
    var maincategoryName : String = String()
    var indexpatharray : NSMutableArray = NSMutableArray()
    
    var countinsubcatyegory = 0
    
    @IBOutlet var titleLable: UILabel!
    
    var subcategoryarray:NSMutableArray = NSMutableArray()
    var titlestring : String = String()
    
    
    var headerTitles = ["Some Data 1", "Kick"]
     var datarespons:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
   
            print("*****This is the data 4: \(datarespons)")

        titleLable.text = titlestring
        maincategorarray = subcategoryarray.mutableCopy() as! NSMutableArray
        maincategoryName = titlestring
    }
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcategoryarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! categoriesCollectionViewCell
        
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        cell.categoriesimageview.clipsToBounds=true
        cell.categoriesimageview.layer.cornerRadius=cell.frame.size.width/2
        
        
        let labelContent = subcategoryarray  .value(forKey: "name") as! NSArray
        print("asdsa \(labelContent)")
        cell.categoriesNameLabel.text = labelContent[indexPath.row] as? String
        
        let labelContentimahe = subcategoryarray  .value(forKey: "image") as! NSArray
        print("asdsa \(labelContentimahe)")
        if let strImage = labelContentimahe[indexPath .row] as? String{
            if let data = NSData(contentsOf: NSURL(string:strImage ) as! URL) {
                cell.categoriesimageview.image = UIImage(data: data as Data)
                
            }
        }
        cell.categoriesimageview.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
        
        
        let subCatStatus = subcategoryarray .value(forKey: "sub_status") as! [AnyObject]
        print("\(subCatStatus)")
        
        if((subCatStatus[indexPath.row] as! Bool) == true){
            
            titleLable.text = ((subcategoryarray[indexPath.row] as AnyObject) .value(forKey: "name") as AnyObject) as? String
            
            let teamp = (subcategoryarray[indexPath.row] as AnyObject) .value(forKey: "sub") as AnyObject
            print("\(teamp)")
            subcategoryarray = teamp as! NSMutableArray
            SubCategoriescollectionview.reloadData()
            countinsubcatyegory += 1
          indexpatharray .add(indexPath)
            
            
        }

        
    }
    
    @IBAction func BackButtonClick(_ sender: Any) {
        
        if countinsubcatyegory >= 1 {
                   var temparray2 : NSMutableArray = NSMutableArray ()
//            
            var temparray = maincategorarray.mutableCopy() as! NSMutableArray
            
//            
            for index in 0..<indexpatharray.count{
//            
                
                
                let subCatStatus = temparray[(indexpatharray[index] as! NSIndexPath).row] as! NSMutableDictionary
                
                
                print("\(subCatStatus)")
//                
                if((subCatStatus .value(forKey: "sub_status") as! Bool) == true){
//                
//                    
                    temparray2 = subCatStatus .value(forKey: "sub") as! NSMutableArray
                    
                    let temparray3 = temparray2.mutableCopy() as! NSMutableArray
                    
//                    let subCatStatus = temparray2 .value(forKey: "sub_status")  as! [AnyObject]
//                    print("\(subCatStatus)")
//                    
//                    if((subCatStatus[(indexpatharray[index] as! NSIndexPath).row] as! Bool) == true){
//                    
//                        print((indexpatharray[index] as! NSIndexPath).row )
//                        temparray = temparray2[(indexpatharray[index] as! NSIndexPath).row] as! NSMutableDictionary
                }else{
                    
                   // temparray = temparray2.mutableCopy() as! NSMutableArray
                
                }
           }
//            
//            
            indexpatharray .removeLastObject()
            print("\(temparray)")
            subcategoryarray = temparray.mutableCopy() as! NSMutableArray
            
             countinsubcatyegory -= 1
             SubCategoriescollectionview.reloadData()
           // temparray = maincategorarray.mutableCopy() as! NSMutableArray
 
        }else{
        
         _ = self.navigationController?.popViewController(animated: true)
        }
       
    }
    

}
