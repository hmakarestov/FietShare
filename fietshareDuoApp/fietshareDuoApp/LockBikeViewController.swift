//
//  LockBikeViewController.swift
//  fietshareDuoApp
//
//  Created by Student on 24/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class LockBikeViewController: UIViewController {

    @IBOutlet weak var lockBikeIdInput: UITextField!
    
    var fiets = Fietshare()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let helpButton = UIButton(type: .infoLight)
        helpButton.tintColor = UIColor.white
        let rightBarButton = UIBarButtonItem(customView: helpButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        // to me improved according to logic
        lockBikeIdInput.delegate = self
        
        // self.lockBikeIdInput.keyboardType = .numberPad

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendNumberOfBike(_ sender: Any) {
        
        // if not null and also should be equal to a bike ID
        // to be made to check if bike is available or not, bikes that are used, only they can be locked, nikes in the stand should not be locked
        //also catch possivble exceptions and give good info to user about them
        
        for s in fiets.stands{
            for b in s.bikes {
                if(lockBikeIdInput.text != "" && lockBikeIdInput.text == String(b.id)) {
                    self.navigationController?.popViewController(animated: true)
                    
                    
                    
                   
                    
                    let alertController = UIAlertController(title: "Your bike is locked", message: "You have managed to lock your bike! ", preferredStyle: .alert)
                    
                    let actionOk = UIAlertAction(title: "OK",
                                                 style: .default,
                                                 handler : {a in self.performSegue(withIdentifier: "goToMap", sender: self)})
                    
                                            //     handler: { a in self.dismiss(animated: true) {
                                                    
                                                 //   }
                   // })//You can use a block here to handle a press on this buttonblock here to handle a press on this button
                    
                    //{(alert: UIAlertAction!) in self.performSegue(withIdentifier: "bikeList", sender: self)}
                    alertController.addAction(actionOk)
                    fiets.sessionActive = false
                    //  actionOk.addTarget(self, action: #selector(ViewController.getListOfbikes()), for: .touchDown)
                    
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    //find a beter way
                    navigationController?.pushViewController(alertController, animated: true)
                    
                }
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lockBikeIdInput.resignFirstResponder()
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
extension LockBikeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
