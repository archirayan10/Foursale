//
//  SupportViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 28/07/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class SupportViewCtrl: UIViewController {

    
    @IBOutlet var faqsButton: UIButton!
    @IBOutlet var myTicketsButton: UIButton!
    @IBOutlet var createTicketsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //hide tab bar
        self.tabBarController?.tabBar.isHidden = true
      
        faqsButton.layer.cornerRadius=5
        myTicketsButton.layer.cornerRadius=5
        createTicketsButton.layer.cornerRadius=5
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
    @IBAction func faqsButtonClicked(_ sender: Any) {
    }
    @IBAction func myTicketButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "MyTicketsViewCtrlID") as! MyTicketsViewCtrl
        navigationController?.pushViewController(myVC, animated: true)
    }
    @IBAction func createTicketButtonClicked(_ sender: Any) {
    }
    @IBAction func liveSupportButtonClicked(_ sender: Any) {
    }
    @IBAction func callUsButtonClicked(_ sender: Any) {
    }
    
   

}
