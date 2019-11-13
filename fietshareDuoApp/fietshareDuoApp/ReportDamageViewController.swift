//
//  ReportDamageViewController.swift
//  Fietshare
//
//  Created by Student on 31/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class ReportDamageViewController: UIViewController {

    @IBOutlet var tbOther: UITextField!
    @IBOutlet var lblExplain: UILabel!
    
    @IBOutlet var lblPicture: UILabel!
    
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var btnTakePicture: UIButton!
    @IBOutlet var btnFlatTire: UIButton!
    @IBOutlet var btnOther: UIButton!
    @IBOutlet var btnStolen: UIButton!
    @IBOutlet var btnSaddle: UIButton!
    @IBOutlet var btnUnlock: UIButton!
    @IBOutlet var btnLock: UIButton!
    @IBOutlet var btnBrakes: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tbOther.isHidden=true;
        lblPicture.isHidden=true;
        lblPicture.text="Picture uploaded";
        
        btnFlatTire.setTitle("   Flat tire", for: .normal)
        btnFlatTire.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnFlatTire.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnFlatTire.setTitleColor(UIColor.black, for: .normal)
        btnFlatTire.layer.shadowColor=UIColor.black.cgColor;
        btnFlatTire.layer.shadowRadius=7;
        btnFlatTire.layer.shadowOpacity=0.5;
        btnFlatTire.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnFlatTire.contentHorizontalAlignment = .left;
        
        btnBrakes.setTitle("   Brakes don't work", for: .normal)
        btnBrakes.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnBrakes.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnBrakes.setTitleColor(UIColor.black, for: .normal)
        btnBrakes.layer.shadowColor=UIColor.black.cgColor;
        btnBrakes.layer.shadowRadius=7;
        btnBrakes.layer.shadowOpacity=0.5;
        btnBrakes.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnBrakes.contentHorizontalAlignment = .left;
        
        
        btnLock.setTitle("   The bike is not locking", for: .normal)
        btnLock.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnLock.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnLock.setTitleColor(UIColor.black, for: .normal)
        btnLock.layer.shadowColor=UIColor.black.cgColor;
        btnLock.layer.shadowRadius=7;
        btnLock.layer.shadowOpacity=0.5;
        btnLock.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnLock.contentHorizontalAlignment = .left;
        
        btnUnlock.setTitle("   The bike is not unlocking", for: .normal)
        btnUnlock.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnUnlock.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnUnlock.setTitleColor(UIColor.black, for: .normal)
        btnUnlock.layer.shadowColor=UIColor.black.cgColor;
        btnUnlock.layer.shadowRadius=7;
        btnUnlock.layer.shadowOpacity=0.5;
        btnUnlock.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnUnlock.contentHorizontalAlignment = .left;
        
        btnSaddle.setTitle("   The saddle is not adjustable", for: .normal)
        btnSaddle.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnSaddle.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnSaddle.setTitleColor(UIColor.black, for: .normal)
        btnSaddle.layer.shadowColor=UIColor.black.cgColor;
        btnSaddle.layer.shadowRadius=7;
        btnSaddle.layer.shadowOpacity=0.5;
        btnSaddle.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnSaddle.contentHorizontalAlignment = .left;
        
        btnStolen.setTitle("   The bike is stolen", for: .normal)
        btnStolen.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnStolen.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnStolen.setTitleColor(UIColor.black, for: .normal)
        btnStolen.layer.shadowColor=UIColor.black.cgColor;
        btnStolen.layer.shadowRadius=7;
        btnStolen.layer.shadowOpacity=0.5;
        btnStolen.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnStolen.contentHorizontalAlignment = .left;
        
        btnOther.setTitle("   Other", for: .normal)
        btnOther.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btnOther.backgroundColor=UIColor.init(red: 0xc4, green: 0xc3, blue: 0xc2, alpha: 1.0);
        btnOther.setTitleColor(UIColor.black, for: .normal)
        btnOther.layer.shadowColor=UIColor.black.cgColor;
        btnOther.layer.shadowRadius=7;
        btnOther.layer.shadowOpacity=0.5;
        btnOther.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnOther.contentHorizontalAlignment = .left;
        
        btnTakePicture.setTitle("Take picture", for: .normal)
        btnTakePicture.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        btnTakePicture.backgroundColor=UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.0)
        btnTakePicture.setTitleColor(UIColor.white, for: .normal)
        btnTakePicture.layer.cornerRadius=btnTakePicture.frame.height/2;
        btnTakePicture.layer.shadowColor=UIColor.black.cgColor;
        btnTakePicture.layer.shadowRadius=7;
        btnTakePicture.layer.shadowOpacity=0.5;
        btnTakePicture.layer.shadowOffset=CGSize(width: 0, height: 0);
        btnTakePicture.contentHorizontalAlignment = .center;
        
        btnSubmit.setTitle("Submit", for: .normal)
        
//        btnSubmit.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        btnSubmit.backgroundColor=UIColor(red:0.69, green:0.15, blue:0.15, alpha:1.0);
//        btnSubmit.setTitleColor(UIColor.white, for: .normal)
//        btnSubmit.layer.cornerRadius=btnSubmit.frame.height/2;
//        btnSubmit.layer.shadowColor=UIColor.black.cgColor;
//        btnSubmit.layer.shadowRadius=7;
//        btnSubmit.layer.shadowOpacity=0.5;
//        btnSubmit.layer.shadowOffset=CGSize(width: 0, height: 0);
//        btnSubmit.contentHorizontalAlignment = .center;
    
        lblExplain.text="Select one or more problems that occured with your bike during the session:";
    }
    
    @IBAction func onClickFlatTire(_ sender: Any) {
        if btnFlatTire.isSelected
        {
            btnFlatTire.isSelected=false;
        }
        else
        {
            btnFlatTire.isSelected=true;
        }
    }
    
    @IBAction func onClickBrakes(_ sender: Any) {
        if btnBrakes.isSelected
        {
            btnBrakes.isSelected=false;
        }
        else
        {
            btnBrakes.isSelected=true;
        }
    }
    
    @IBAction func onClickLock(_ sender: Any) {
        if btnLock.isSelected
        {
            btnLock.isSelected=false;
        }
        else
        {
            btnLock.isSelected=true;
        }
    }
    
    @IBAction func onClickUnlock(_ sender: Any) {
        if btnUnlock.isSelected
        {
            btnUnlock.isSelected=false;
        }
        else
        {
            btnUnlock.isSelected=true;
        }
    }
    
    @IBAction func onClickSaddle(_ sender: Any) {
        if btnSaddle.isSelected
        {
            btnSaddle.isSelected=false;
        }
        else
        {
            btnSaddle.isSelected=true;
        }
    }
    
    @IBAction func onClickStolen(_ sender: Any) {
        
        if btnStolen.isSelected
        {
            btnStolen.isSelected=false;
        }
        else
        {
            btnStolen.isSelected=true;
        }
    }
    @IBAction func onClickOther(_ sender: Any) {
        
        if btnOther.isSelected
        {
            btnOther.isSelected=false;
            tbOther.isHidden=true;
        }
        else
        {
            btnOther.isSelected=true;
            tbOther.isHidden=false;
        }
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        let alertController = UIAlertController(title: "Your report has been submitted.", message: "We received your damage report and will try to fix it as soon as possible.", preferredStyle: .actionSheet)
        
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "submitSegue", sender: self)})//You can use a block here to handle a press on this button
        
        alertController.addAction(actionOk)
        
      
        
        
        self.present(alertController, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil);
    }
    
    @IBAction func onClickTakePicture(_ sender: Any) {
        performSegue(withIdentifier: "cameraSegue", sender: nil);
        lblPicture.isHidden=false;
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
