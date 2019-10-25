//
//  ActiveSessionViewController.swift
//  fietshareDuoApp
//
//  Created by Student on 23/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class ActiveSessionViewController: UIViewController {
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var btnUnclock: UIButton!
 
    @IBOutlet weak var bikeId: UILabel!
    @IBOutlet weak var btnLock: UIButton!
    
    let fietsshare = Fietshare()
    var timer:Timer?
    var timeLeft = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let helpButton = UIButton()
        let helpButton = UIButton(type: .infoLight)
        helpButton.tintColor = UIColor.white
        let rightBarButton = UIBarButtonItem(customView: helpButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        //to be fixed
        btnLock.isHidden = true
        
        for s in fietsshare.stands{
            for b in s.bikes {
                bikeId.text = String(b.id)
            }
        }
       
        
        
           // self.lbBikeIdInput.keyboardType = .decimalPad
       
      
        
        //UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: self, action: Selector(""))

        
        //self.navigationItem.rightBarButtonItem = helpButton
        // Do any additional setup after loading the view.
    }
    
    
    func hideButton(){
        // hide/undhide buttons and start timer
       btnUnclock.isHidden=true
        btnLock.isHidden=false
        
    }
    func alertUser(){
        print("A list of bikes") // your implementation(segues and etc)
        let alertController = UIAlertController(title: "You are about to unlock a bike", message: "You can use the bike now. You have one minute before fee starts getting applied. Check your bike for damages. ", preferredStyle: .actionSheet)
     
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: {(alert: UIAlertAction!) in  self.hideButton()})//You can use a block here to handle a press on this button
        
        //{(alert: UIAlertAction!) in self.performSegue(withIdentifier: "bikeList", sender: self)}
        alertController.addAction(actionOk)
        
        //  actionOk.addTarget(self, action: #selector(ViewController.getListOfbikes()), for: .touchDown)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
  
    @IBAction func reserveBike(_ sender: Any) {
     timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        
        alertUser()
    }
    
    @IBAction func lockBike(_ sender: Any) {
        
        //btnLock.isHidden=false
        performSegue(withIdentifier: "lockBikeId", sender: self)
        if(timeLeft>0){
        timer!.invalidate()
        }
        timer = nil
        
    }
    @objc func fire()
    {
        //find a way to make it countdown from 0 to 60
        print("FIRE!!!")
        timeLeft -= 1
        //lbTime.text = "\(timeLeft)"
       //  timeString(time: TimeInterval(timeLeft))
         lbTime.text = String(TimeInterval(timeLeft))
        
        
        if timeLeft <= 0 {
            timer!.invalidate()
            timer = nil
        }
      
        
    }
    
    func timeString(time: TimeInterval) -> String {
       // let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        // return formated string
        return String(format: "%02i:%02i", minute, second)
    }

    /*
     @IBAction func reserveBike(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
