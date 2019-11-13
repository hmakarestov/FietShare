//
//  BikesListTableViewController.swift
//  fietshareDuoApp
//
//  Created by Student on 07/11/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class BikesListTableViewController: UITableViewController {

    //array of Pirates
    var bikes = [Bike]()
    var id  = String ()
    private var childContainerController:ActiveSessionViewController?
    var fietshare = Fietshare ()
    override func viewDidLoad() {
        super.viewDidLoad()
        let helpButton = UIButton(type: .infoLight)
        helpButton.tintColor = UIColor.white
        let rightBarButton = UIBarButtonItem(customView: helpButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        helpButton.addTarget(self, action: #selector(ViewController.goToHelpPage), for: .touchDown)
        ///fetch the pirate
        tableView.dataSource = self 
        
}

    // MARK: - Table view data source
    @objc func goToHelpPage() {
        performSegue(withIdentifier: "goToHelp", sender: self)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.bikes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bikeCell", for: indexPath)

      //   Configure the cell...
        
        for b in bikes {
            self.id = String(b.id)
        }
        cell.textLabel?.text = " Bike ID: \(String(self.bikes[indexPath.row].id))"
        
        cell.detailTextLabel?.text = self.bikes[indexPath.row].name
       // cell.accessoryType = .checkmark
        let btn = UIButton()
        btn.setTitle("Reserve bike", for: .normal)
        btn.titleLabel!.textAlignment = .center
        btn.backgroundColor = UIColor.green
        btn.frame = CGRect(x: 290, y: 0, width: 130, height: 60)
        btn.addTarget(self, action: #selector(BikesListTableViewController.goToListWithBikes), for: .touchDown)
      //  btn.
        cell.addSubview(btn)
        
        return cell
    }
 
    @objc func goToListWithBikes() {
        print("A list of bikes") // your implementation(segues and etc)
        
        
        let alertController = UIAlertController(title: "Bike is reserved", message: "You have successfully reserved this bike.", preferredStyle: .actionSheet)
        //We add buttons to the alert controller by creating UIAlertActions:
      
        
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "activeSession", sender: self)})//You can use a block here to handle a press on this button
        
        alertController.addAction(actionOk)
        
        fietshare.sessionActive = true
        //  actionOk.addTarget(self, action: #selector(ViewController.getListOfbikes()), for: .touchDown)
        
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "activeSession"){
            self.childContainerController = segue.destination as? ActiveSessionViewController
            self.childContainerController!.id = self.id
            self.childContainerController!.fietsshare.sessionActive = self.fietshare.sessionActive
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
