//
//  ShowCategoryImagesPageViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 08/08/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class ShowCategoryImagesPageViewCtrl: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var images: [UIImage] = []
    
    var vivedLabel: [UILabel] = []
    
    var startIndex = 0
    
    var productArray: NSMutableArray = NSMutableArray()
    var productImageArray: NSMutableArray = NSMutableArray()
    var strImage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
       /* images.append(UIImage(named: "Sale-PNG")!)
        images.append(UIImage(named: "smartphone")!)
        images.append(UIImage(named: "seller")!)
         
 
        GetCategoryData()
        // Set the data source to itself
 
        self.dataSource = self
 */
        // Create the first screen
        //vivedLabel.append.
        if let startingViewController = self.getItemController(startIndex) {
            
            setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
            
        }
        self.tabBarController?.tabBar.isHidden = true
 
         GetCategoryData()

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
                                
                                self.productArray =  parseJSON["data"] as! NSMutableArray
                                print("\(self.productArray)")
                                
                                let teamp = self.productArray .value(forKey: "main_image") as AnyObject
                                print("\(teamp)")
                                self.productImageArray.setArray(teamp as! [Any])
                                print("\( self.productImageArray)")
                                
                                for i in 0..<self.productImageArray.count{
                                print("\(self.productImageArray[i])")
                                        let url = NSURL(string: self.productImageArray[i] as! String)
                                        let data = NSData(contentsOf: url! as URL)
                                        self.images.append(UIImage(data: data as! Data)!)
                                }
                                self.dataSource = self
                                
                                // Create the first screen
                                if let startingViewController = self.getItemController(self.startIndex) {
                                    
                                    self.setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
                                    
                                }
                                
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


    
    
    
    
    fileprivate func getItemController(_ itemIndex: Int) -> UIViewController? {
        
        if itemIndex < self.images.count {
            
            let result:SlideController = self.storyboard!.instantiateViewController(withIdentifier: "slideController") as! SlideController
            
            result.itemIndex = itemIndex
            
            result.image = self.images[itemIndex]
            
            return result
        }
        
        return nil
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! SlideController
        
        if itemController.itemIndex+1 < self.images.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
        
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        let itemController = viewController as! SlideController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
        
    }


}
