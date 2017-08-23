//
//  MyProfileViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 29/07/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class MyProfileViewCtrl: UIViewController {

    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var editProfileButton: UIButton!
    @IBOutlet var editImageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Do any additional setup after loading the view.
        if UIDevice.current.userInterfaceIdiom == .pad {
           userImageView.layer.cornerRadius=35
            editImageButton.layer.cornerRadius=35
       }else{
        userImageView.layer.cornerRadius=self.userImageView.frame.width/2
            editImageButton.layer.cornerRadius=self.editImageButton.frame.width/2
        }
        editProfileButton.layer.cornerRadius=5
        
        
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
    //Mark:- Button Action Method
    
    @IBAction func backButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "moreItemViewCtrlID") as! moreItemViewCtrl
        navigationController?.pushViewController(myVC, animated: true)

    }
    @IBOutlet var editProfileButtonClicked: UIButton!
    
    @IBAction func EditImageButtonClicked(_ sender: Any) {
    }

    @IBAction func editImageButtonClicked(_ sender: Any) {
    }
}
