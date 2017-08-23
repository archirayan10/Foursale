//
//  MyTicketsViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 03/08/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class MyTicketsViewCtrl: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var myTicketTableViewCell: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func canelButtonClicked(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SupportViewCtrlID") as! SupportViewCtrl
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mycell:MyTicketTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyTicketTableViewCell
        
        return mycell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "AppTicketViewCtrlID") as! AppTicketViewCtrl
        navigationController?.pushViewController(myVC, animated: true)
    }

}
