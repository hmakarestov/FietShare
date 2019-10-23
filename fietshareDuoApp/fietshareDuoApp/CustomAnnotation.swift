//
//  CustomAnnotation.swift
//  fietshareDuoApp
//
//  Created by Student on 20/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation


public class CustomAnnotation : NSObject, MKAnnotation {
    public var coordinate : CLLocationCoordinate2D  // should be public otherwise it does not work
   public var title : String? // should be public otherwise it does not work
    public var subtitle: String?  // should be public otherwise it does not work
   // public var image : UIImage
    
    
   // let location = CLLocationCoordinate2D(latitude: 51.4416, longitude: 5.4697)
    //let loc = CLLocationCoordinate2D(latitude: 51.4430, longitude: 5.4625)
    
    init(pinTitle:String,pinSubTitle:String,pinLocation:CLLocationCoordinate2D)//, image: UIImage)
    {
        self.coordinate = pinLocation
       // self.coordinate = location
        self.title = pinTitle // NSLocalizedString( pinTitle, comment: "Yes")
        self.subtitle = pinSubTitle
       // self.image = image
    }
    
    
    
    
  
    
  
}
