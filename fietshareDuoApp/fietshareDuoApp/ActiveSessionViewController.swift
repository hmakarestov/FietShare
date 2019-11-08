//
//  ActiveSessionViewController.swift
//  fietshareDuoApp
//
//  Created by Student on 23/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class ActiveSessionViewController: UIViewController,UITabBarControllerDelegate  {
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var btnUnclock: UIButton!
 
    @IBOutlet weak var mapBackBtn: UITabBarItem!
    @IBOutlet weak var bikeId: UILabel!
    @IBOutlet weak var btnLock: UIButton!
     private var childContainerController:ViewController?
    var id = String ()
    let fietsshare = Fietshare()
    var timer:Timer?
    var timer2:Timer?
    var timeLeft = 900
    var timeUnlock = 60
    var timeSession = 0
    var priceSession = 0.00
    override func viewDidLoad() {
        super.viewDidLoad()
       // let helpButton = UIButton()
        let helpButton = UIButton(type: .infoLight)
        helpButton.tintColor = UIColor.white
        let rightBarButton = UIBarButtonItem(customView: helpButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        //to be fixed
        btnLock.isHidden = true
        bikeId.text = String(id)

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        fietsshare.sessionActive=true
        
       //   performSegue(withIdentifier: "goBackToMap", sender: self)
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
      
        if timeLeft >= 0
        {
            timer?.invalidate()
            timer = nil
        }
     timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireSession), userInfo: nil, repeats: true)
        alertUser()
    }
    
    @IBAction func lockBike(_ sender: Any) {
        performSegue(withIdentifier: "lockBikeId", sender: self)
        if(timeSession>=0){
        timer2!.invalidate()
        }
        timer = nil
        
    }
    @objc func fire()
    {
        //find a way to make it countdown from 0 to 60
        print("FIRE!!!")
        timeLeft -= 1
          lbTime.text =  timeString(time: TimeInterval(timeLeft))
        if timeLeft <= 0 {
            timer!.invalidate()
            timer = nil
        }
      
        
    }
    
    @objc func fireSession()
    {
        //find a way to make it countdown from 0 to 60
        print("FIRE SESSION!!!")
        
        timeSession+=1
        lbTime.text = timeString(time: TimeInterval(timeSession))
        if timeSession > 60 {
            priceSession = Double(timeSession)/60 * 0.20
            lbAmount.text = String(format: "%.2f", priceSession) + "€" // shift + option + 2
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
