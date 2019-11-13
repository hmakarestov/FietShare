//
//  HelpViewController.swift
//  Fietshare
//
//  Created by Student on 24/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    
    @IBOutlet var btnReport: UIButton!
    @IBOutlet var btnGeneral: UIButton!
    @IBOutlet var btnPayment: UIButton!
    @IBOutlet var btnBeforeRiding: UIButton!
    @IBOutlet var btnAfterRiding: UIButton!
    @IBOutlet var btnContact: UIButton!
    @IBOutlet var btnTerms: UIButton!
    @IBOutlet var btnFAQ: UIButton!
    
    @IBOutlet var lblGeneral: UILabel!
    @IBOutlet var lblPayment: UILabel!
    @IBOutlet var lblBeforeRiding: UILabel!
    @IBOutlet var lblAfterRiding: UILabel!
    @IBOutlet var lblContact: UILabel!
    @IBOutlet var lblTerms: UILabel!
    @IBOutlet var lblFAQ: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnReport.setTitle("Report Damage", for: .normal)
        btnReport.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        btnReport.backgroundColor=UIColor(red:0.69, green:0.15, blue:0.15, alpha:1.0);
        btnReport.setTitleColor(UIColor.white, for: .normal)
        btnReport.layer.cornerRadius=btnReport.frame.height/2;
        btnReport.layer.shadowColor=UIColor.black.cgColor;
        btnReport.layer.shadowRadius=7;
        btnReport.layer.shadowOpacity=0.5;
        btnReport.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnReport.contentHorizontalAlignment = .center;
        
        btnGeneral.setTitle("   General info", for: .normal)
        btnGeneral.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnGeneral.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnGeneral.setTitleColor(UIColor.black, for: .normal)
        btnGeneral.layer.shadowColor=UIColor.black.cgColor;
        btnGeneral.layer.shadowRadius=7;
        btnGeneral.layer.shadowOpacity=0.5;
        btnGeneral.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnGeneral.contentHorizontalAlignment = .left;
        
        btnPayment.setTitle("   Payment info", for: .normal)
        btnPayment.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnPayment.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnPayment.setTitleColor(UIColor.black, for: .normal)
        btnPayment.layer.shadowColor=UIColor.black.cgColor;
        btnPayment.layer.shadowRadius=7;
        btnPayment.layer.shadowOpacity=0.5;
        btnPayment.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnPayment.contentHorizontalAlignment = .left;
        
        btnBeforeRiding.setTitle("   Before riding", for: .normal)
        btnBeforeRiding.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnBeforeRiding.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnBeforeRiding.setTitleColor(UIColor.black, for: .normal)
        btnBeforeRiding.layer.shadowColor=UIColor.black.cgColor;
        btnBeforeRiding.layer.shadowRadius=7;
        btnBeforeRiding.layer.shadowOpacity=0.5;
        btnBeforeRiding.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnBeforeRiding.contentHorizontalAlignment = .left;
        
        
        btnAfterRiding.setTitle("   After riding", for: .normal)
        btnAfterRiding.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnAfterRiding.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnAfterRiding.setTitleColor(UIColor.black, for: .normal)
        btnAfterRiding.layer.shadowColor=UIColor.black.cgColor;
        btnAfterRiding.layer.shadowRadius=7;
        btnAfterRiding.layer.shadowOpacity=0.5;
        btnAfterRiding.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnAfterRiding.contentHorizontalAlignment = .left;
        
        btnContact.setTitle("   Contact info", for: .normal)
        btnContact.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnContact.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnContact.setTitleColor(UIColor.black, for: .normal)
        btnContact.layer.shadowColor=UIColor.black.cgColor;
        btnContact.layer.shadowRadius=7;
        btnContact.layer.shadowOpacity=0.5;
        btnContact.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnContact.contentHorizontalAlignment = .left;
        
        btnTerms.setTitle("   Terms and conditions", for: .normal)
        btnTerms.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnTerms.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnTerms.setTitleColor(UIColor.black, for: .normal)
        btnTerms.layer.shadowColor=UIColor.black.cgColor;
        btnTerms.layer.shadowRadius=7;
        btnTerms.layer.shadowOpacity=0.5;
        btnTerms.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnTerms.contentHorizontalAlignment = .left;
        
        btnFAQ.setTitle("   FAQ", for: .normal)
        btnFAQ.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnFAQ.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnFAQ.setTitleColor(UIColor.black, for: .normal)
        btnFAQ.layer.shadowColor=UIColor.black.cgColor;
        btnFAQ.layer.shadowRadius=7;
        btnFAQ.layer.shadowOpacity=0.5;
        btnFAQ.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnFAQ.contentHorizontalAlignment = .left;
        
        
        lblGeneral.isHidden=true;
        lblPayment.isHidden=true;
        lblBeforeRiding.isHidden=true;
        lblContact.isHidden=true;
        lblAfterRiding.isHidden=true;
        lblTerms.isHidden=true;
        lblFAQ.isHidden=true;
        
        
        lblGeneral.text="This is an application that allow you to easily rent a bike from any of our stands that you find closer to your location."
        lblPayment.text="There are 2 options for payment Fietshare: via Ideal or using your Visa or Mastercard credit and debit cards. Unfortunately PayPal is still not accepted. You can enter your payment details, when you go to Profile -> Payment details. When you fill in the details you have to complete the process of verification. "
        lblBeforeRiding.text="Check the bicycle for any visible damage or missing elements. Are the lights and brakes working? In case you find anything, click on the Report damage. If the bicycle doesen't unlock when you start the session, please contact our callcentre."
        lblContact.text="+31689765432 via call, WhatsApp or Viber, support@fietshare.nl. You can also contact us on Facebook and Instagram: facebook.com/fietshare  instagram.com/fietshare. We are available Mo-Fr 08:00 - 21:00, Sa-Su 10:00 - 19:00"
        lblAfterRiding.text="Is the bike locked at the stand? Did you sucessfully end the session on the application? Did you experience any problems with the bike during your ride? In such case please tell us using the Report Damage option."
        lblTerms.text="These Website Standard Terms and Conditions written on this webpage shall manage your use of our website, Webiste Name accessible at Website.comThese Terms will be applied fully and affect to your use of this Website. By using this Website, you agreed to accept all terms and conditions written in here. You must not use this Website if you disagree with any of these Website Standard Terms and Conditions."
        lblFAQ.text=" - How much does a bike cost to rent? : Our bikes can be rented for a price of €0.19 per minute."
        
        
        lblGeneral.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0);
        lblPayment.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0);
        lblBeforeRiding.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0);
        lblContact.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0);
        lblAfterRiding.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0);
        lblTerms.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0);
        lblFAQ.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0);
        
    }
    
    @IBAction func onClickReportDamage(_ sender: Any) {
        performSegue(withIdentifier: "repDamage", sender: nil)
    }
    
    @IBAction func onClickGeneral(_ sender: Any) {
        if lblGeneral.isHidden
        {
            animate(toggle: true, type: btnGeneral);
        }
        else
        {
            animate(toggle: false, type: btnGeneral);
        }

    }
    
    @IBAction func onClickPayment(_ sender: Any) {
        if lblPayment.isHidden
        {
            animate(toggle: true, type: btnPayment);
        }
        else
        {
            animate(toggle: false, type: btnPayment);
        }

    }
    
    @IBAction func onClickBeforeRiding(_ sender: Any) {
        if lblBeforeRiding.isHidden
        {
            animate(toggle: true, type: btnBeforeRiding);
        }
        else
        {
            animate(toggle: false, type: btnBeforeRiding);
        }

    }
    
    @IBAction func onClickAfterRiding(_ sender: Any) {
        if lblAfterRiding.isHidden
        {
            animate(toggle: true, type: btnAfterRiding);
        }
        else
        {
            animate(toggle: false, type: btnAfterRiding);
        }

    }
    
    @IBAction func onClickContact(_ sender: Any) {
        if lblContact.isHidden
        {
            animate(toggle: true, type: btnContact);
        }
        else
        {
            animate(toggle: false, type: btnContact);
        }

    }
    
    @IBAction func onClickTerms(_ sender: Any) {
        if lblTerms.isHidden
        {
            animate(toggle: true, type: btnTerms);
        }
        else
        {
            animate(toggle: false, type: btnTerms);
        }

    }
    
    @IBAction func onClickFAQ(_ sender: Any) {
        if lblFAQ.isHidden
        {
            animate(toggle: true, type: btnFAQ);
        }
        else
        {
            animate(toggle: false, type: btnFAQ);
        }

    }
    
    func animate(toggle: Bool, type: UIButton)
    {
        if type == btnGeneral
        {
            if toggle
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblGeneral.isHidden=false;
                }
            }
            else
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblGeneral.isHidden=true;
                }
            }
        }
        if type == btnPayment
        {
            if toggle
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblPayment.isHidden=false;
                }
            }
            else
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblPayment.isHidden=true;
                }
            }
        }
        if type == btnBeforeRiding
        {
            if toggle
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblBeforeRiding.isHidden=false;
                }
            }
            else
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblBeforeRiding.isHidden=true;
                }
            }
        }
        if type == btnContact
        {
            if toggle
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblContact.isHidden=false;
                }
            }
            else
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblContact.isHidden=true;
                }
            }
        }
        if type == btnAfterRiding
        {
            if toggle
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblAfterRiding.isHidden=false;
                }
            }
            else
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblAfterRiding.isHidden=true;
                }
            }
        }
        if type == btnTerms
        {
            if toggle
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblTerms.isHidden=false;
                }
            }
            else
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblTerms.isHidden=true;
                }
            }
        }
        if type == btnFAQ
        {
            if toggle
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblFAQ.isHidden=false;
                }
            }
            else
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.lblFAQ.isHidden=true;
                }
            }
        }
        
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
