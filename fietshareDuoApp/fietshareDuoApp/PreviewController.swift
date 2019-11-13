//
//  PreviewController.swift
//  Fietshare
//
//  Created by Student on 07/11/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class PreviewController: UIViewController {

    @IBOutlet var photo: UIImageView!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image;
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func cancelButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    @IBAction func saveButton_TouchUpInside(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        dismiss(animated: true, completion: nil);
        
    }
}
