//
//  ProfileViewController.swift
//  Fietshare
//
//  Created by Student on 24/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var btnBonus: UIButton!
    
    @IBOutlet var btnSignOut: UIButton!
    @IBOutlet var btnPayment: UIButton!
    @IBOutlet var btnInvoice: UIButton!
    @IBOutlet var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn.setTitle("Help", for: .normal);

        // Do any additional setup after loading the view.
        btn.setTitle("   My reservations", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btn.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.shadowColor=UIColor.black.cgColor;
        btn.layer.shadowRadius=7;
        btn.layer.shadowOpacity=0.5;
        btn.layer.shadowOffset=CGSize(width: 0, height: 0);
        btn.contentHorizontalAlignment = .left;
        
        btnInvoice.setTitle("   My invoices", for: .normal)
        btnInvoice.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnInvoice.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnInvoice.setTitleColor(UIColor.black, for: .normal)
        btnInvoice.layer.shadowColor=UIColor.black.cgColor;
        btnInvoice.layer.shadowRadius=7;
        btnInvoice.layer.shadowOpacity=0.5;
        btnInvoice.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnInvoice.contentHorizontalAlignment = .left;
        
        btnBonus.setTitle("   Bonuses", for: .normal)
        btnBonus.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnBonus.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnBonus.setTitleColor(UIColor.black, for: .normal)
        btnBonus.layer.shadowColor=UIColor.black.cgColor;
        btnBonus.layer.shadowRadius=7;
        btnBonus.layer.shadowOpacity=0.5;
        btnBonus.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnBonus.contentHorizontalAlignment = .left;
        
        btnPayment.setTitle("   Payment methods", for: .normal)
        btnPayment.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnPayment.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnPayment.setTitleColor(UIColor.black, for: .normal)
        btnPayment.layer.shadowColor=UIColor.black.cgColor;
        btnPayment.layer.shadowRadius=7;
        btnPayment.layer.shadowOpacity=0.5;
        btnPayment.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnPayment.contentHorizontalAlignment = .left;
        
        btnSignOut.setTitle("   Sign out", for: .normal)
        btnSignOut.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnSignOut.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnSignOut.setTitleColor(UIColor.black, for: .normal)
        btnSignOut.layer.shadowColor=UIColor.black.cgColor;
        btnSignOut.layer.shadowRadius=7;
        btnSignOut.layer.shadowOpacity=0.5;
        btnSignOut.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnSignOut.contentHorizontalAlignment = .left;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
