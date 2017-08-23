//
//  AllCategoryViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 04/08/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class AllCategoryViewCtrl: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate {

    var buttonArray: NSMutableArray = NSMutableArray()
    var buttonImageArray: NSMutableArray = NSMutableArray()
    var categoryDataArray: NSMutableArray = NSMutableArray()
    var categoryImageArray: NSMutableArray = NSMutableArray()
    var storedOffsets = [Int: CGFloat]()
    
    @IBOutlet var buttonScrollView: UIScrollView!
    
    @IBOutlet var allcategoryTableViewCell: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false
        buttonArray = ["All","Motors","Property","General Contracting","Satellite","Electronics","Miscellaneous","Foods","Bugs Exterminator","4Sale","Travel and Tourism"]
        buttonImageArray = [#imageLiteral(resourceName: "checked"),#imageLiteral(resourceName: "car"),#imageLiteral(resourceName: "home (4)"),#imageLiteral(resourceName: "saw-hand-drawn-electrical-cutting-tool"),#imageLiteral(resourceName: "radar"),#imageLiteral(resourceName: "computer-processor"),#imageLiteral(resourceName: "army-dog-tag"),#imageLiteral(resourceName: "groceries"),#imageLiteral(resourceName: "tarantula"),#imageLiteral(resourceName: "percentage"),#imageLiteral(resourceName: "aeroplane")]
        // Do any additional setup after loading the view.
        
        var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
        
        buttonScrollView.delegate = self
        buttonScrollView.isPagingEnabled = true
       
        for index in 0..<buttonArray.count {
            
            frame.origin.x = self.buttonScrollView.frame.size.width * CGFloat(index)
          //  frame.size = self.buttonScrollView.frame.size
            
            let frame1 = CGRect(x: 1 + (index * 210), y: 15 , width: 200, height: 40 )
            let button = UIButton(frame: frame1)
            var str: String?
            str = buttonArray .object(at: index) as? String
            button.setTitle(str, for: UIControlState .normal)
           // button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.textAlignment = NSTextAlignment.center
            
            button.titleLabel?.numberOfLines = 2
            button.setTitleColor(UIColor .lightGray, for: UIControlState .normal)
            var image: UIImage?
            image = buttonImageArray .object(at: index) as? UIImage
            button.setImage(image, for: UIControlState .normal)
            //button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 130);
            button.backgroundColor = UIColor.clear
            self.buttonScrollView.addSubview(button)
            button .tag = index
            button.addTarget(self, action: #selector(buttonClicke), for: UIControlEvents .touchUpInside)
        }
         if UIDevice.current.userInterfaceIdiom == .pad {
            self.buttonScrollView.contentSize = CGSize(width:self.buttonScrollView.frame.size.width * 3,height: 0)
         }
         else{
        self.buttonScrollView.contentSize = CGSize(width:self.buttonScrollView.frame.size.width * 5.6,height: 0)
        }
        GetCategoryData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonClicke(sender: AnyObject) {
        let button = sender as! UIButton
        _ = button.tag
        for i in 0..<buttonArray.count{
            if(button.tag == i){
                button.backgroundColor = UIColor(red: 0.0/255.0, green: 181.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            }
        }
    }
    
   /* func buttonClicke(sender: AnyObject) {
        let button = sender as! UIButton
        _ = button.tag
        button.backgroundColor = UIColor(red: 0.0/255.0, green: 181.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        for i in 0..<buttonArray.count{
            if(button.tag == i){
               // (sender.button[i] as! UIButton).backgroundColor = UIColor .redColor()
               // (button[i] as! Int).backgroundColor = UIColor .red
            }
            else
            {
                for view in self.buttonScrollView.subviews as [UIView] {
                    if let btn = view as? UIButton {
                        btn.backgroundColor = UIColor .clear
                    }
                }
               // button .backgroundColor = UIColor .clear
            }
            
        }
    }*/

   /* func handleTap(sender: UIButton) {
        let button = sender as! UIButton
        _ = button.tag
        for i in 0..<buttonArray.count{
            if(button.tag == i){
                if sender.tag == button.tag {
                    sender.backgroundColor = UIColor.blue
                } else {
                    sender.backgroundColor = UIColor.white
                }
            }
        }
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return categoryDataArray.count/2
        }
        else{
            return categoryDataArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mycell:AllCategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AllCategoryTableViewCell
        
            return mycell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? AllCategoryTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? AllCategoryTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }


    
    
    func GetCategoryData(){
        //get_high_score.php?from=1472409001482&number=10&to=1493657787867
        EZLoadingActivity.show("Loading...", disableUI: false)
        
        DispatchQueue.global(qos: .background).async {
            
            let myUrl = URL(string: GlobleUrl.BASEURL + "products.php");
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
                            let status =   parseJSON["status"] as! Bool
                            
                            if status == true{
                                
                                EZLoadingActivity.hide(true, animated: false)
                                
                                self.categoryDataArray =  parseJSON["data"] as! NSMutableArray
                                print("\(self.categoryDataArray)")
                                
                                let teamp = self.categoryDataArray .value(forKey: "main_image") as AnyObject
                                print("\(teamp)")
                                self.categoryImageArray.setArray(teamp as! [Any])
                                print("\( self.categoryImageArray)")

                                //  let teamp = self.data .value(forKey: "name") as AnyObject
                                // print("\(teamp)")
                                //  self.categoryNameArray.setArray(teamp as! [Any])
                                
                                
                                self.allcategoryTableViewCell.reloadData()
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

extension AllCategoryViewCtrl: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 2
        }
        else{
            return 1
        }

    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! AllCategoryCollectionViewCell
               
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
     //   cell.allcategoryImageView.clipsToBounds=true
   //     cell.allcategoryImageView.layer.cornerRadius=cell.frame.size.width/2
        
        
        cell.allcategoryImageView.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        
        
        //let imagecontent = categoryDataArray.value(forKey: "main_image") as? UIImage
   //     cell.allcategoryImageView.image = imagecontent?[indexPath.row]
        
        if let strImage = categoryImageArray[indexPath .row] as? String{
            // ... your strImage is String  ...
           // let imgstr = strImage[indexPath .row]
            if let data = NSData(contentsOf: NSURL(string:strImage ) as! URL) {
                cell.allcategoryImageView.image = UIImage(data: data as Data)
            
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
        
   /*    // performSegue(withIdentifier: "subcategories", sender: nil)
        let popoverContent = (self.storyboard?.instantiateViewController(withIdentifier: "ShowCategoryImagesPageViewCtrlID"))! as UIViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
       // popoverContent.preferredContentSize = CGSizeMake(500,600)
     //   popover?.delegate = self
        popover?.sourceView = self.view
       // popover.sourceRect = CGRectMake(100,100,0,0)
        
        self.present(nav, animated: true, completion: nil)
        */
      //  performSegue(withIdentifier: "AllCategoryView", sender: nil)
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ShowCategoryImagesPageViewCtrlID") as! ShowCategoryImagesPageViewCtrl
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(myVC, animated: true)
    }
}
