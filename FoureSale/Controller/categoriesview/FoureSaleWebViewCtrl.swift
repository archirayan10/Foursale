//
//  FoureSaleWebViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 09/08/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class FoureSaleWebViewCtrl: UIViewController, UIActionSheetDelegate, UIWebViewDelegate, UIPopoverControllerDelegate {

    var url = URL (string: "https://www.google.com")
    @IBOutlet var progresView: UIProgressView!
    
    @IBOutlet var foureSaleWebView: UIWebView!
    
    //var timer = Timer()
    //var poseDuration = 0
    //var indexProgressBar = 0
    //var currentPoseIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        progresView.progress = 0.0
               // progresView.progress = 0.0
        // Do any additional setup after loading the view.
        /*progresView.progress = 0.0
        
        getNextPoseData()
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(FoureSaleWebViewCtrl.setProgressBar), userInfo: nil, repeats: true)
        */
       // let requestObj = URLRequest(url: url!)
      //  foureSaleWebView.loadRequest(requestObj)
        let request = NSURLRequest(url: url!)
        foureSaleWebView.loadRequest(request as URLRequest)
        foureSaleWebView.delegate=self
        progresView.progress = 0.3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        

    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.progresView.setProgress(0.6, animated: true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.progresView.setProgress(1.0, animated: true)
        progresView.progress = 0.0
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        self.progresView.setProgress(1.0, animated: true)
    }
    
   /* func getNextPoseData()
    {
        // do next pose stuff
        currentPoseIndex += 1
        print(currentPoseIndex)
    }
    
    func setProgressBar()
    {
        if indexProgressBar == poseDuration
        {
            getNextPoseData()
            
            // reset the progress counter
            indexProgressBar = 0
        }
        
        // update the display
        // use poseDuration - 1 so that you display 20 steps of the the progress bar, from 0...19
        progresView.progress = Float(indexProgressBar) / Float(poseDuration - 1)
        
        // increment the counter
        indexProgressBar += 1
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func CloseButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ShowCategoryImagesPageViewCtrlID") as! ShowCategoryImagesPageViewCtrl
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromBottom;
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(myVC, animated: true)
    }
    @IBAction func reloadButtonClicked(_ sender: Any) {
        foureSaleWebView.reload()
    }
    @IBAction func shareButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Open in Safari", style: .default , handler:{ (UIAlertAction)in
            
            UIApplication.shared.openURL(self.url!)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Copy Link", style: .default , handler:{ (UIAlertAction)in
            //alert.view.tintColor = UIColor.red
           // UIPasteboard.general.string = "https://www.google.com"
            let pasteBoard = UIPasteboard.general
            pasteBoard.string = "https://www.google.com"
        
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default , handler:{ (UIAlertAction)in
            //alert.view.tintColor = UIColor.red
            alert .removeFromParentViewController()
        }))
        //var frame = UIScreen.MainScreen.Bounds
        //var frame = UIScreen.main.bounds
        //frame.Height /= 2;
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 4)
        self.present(alert, animated: true, completion: {
        
        })
      
    }
    

}
