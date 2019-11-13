//
//  TabBarController.swift
//  fietshareDuoApp
//
//  Created by Student on 13/11/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var fiets = Fietshare()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        

        // Do any additional setup after loading the view.
    }
   override  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 2 {
          //  performSegue(withIdentifier: "mapActive", sender: self)
           // fietsshare.sessionActive=true
            print("BACK TO MAP")
        }
    }
    
   // override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item.title == "Session"{
//            // show my account
//            //activeSessionID
//            if fiets.sessionActive==true {
//            let destinationController = storyboard?.instantiateViewController(withIdentifier: "activeSessionID")
//            present(destinationController!, animated: true, completion: nil)
//            }
//            else  {
//                 let destinationControllerNot = storyboard?.instantiateViewController(withIdentifier: "notActiveSessionID")
//                  present(destinationControllerNot!, animated: true, completion: nil)
//            }
            // let destinationControllerNot = storyboard?.instantiateViewController(withIdentifier: "notActiveSessionID")
            //notActiveSessionID
        //}
//            else if item == accountItem {
//                // show login
//            }
     //   }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
