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
    public var coordinate : CLLocationCoordinate2D
    var title : String?
    var subtitle: String?
    
   // let location = CLLocationCoordinate2D(latitude: 51.4416, longitude: 5.4697)
    //let loc = CLLocationCoordinate2D(latitude: 51.4430, longitude: 5.4625)
    
    init?(pinTitle:String?,pinSubTitle:String?,pinLocation:CLLocationCoordinate2D)
    {
        self.coordinate = pinLocation
       // self.coordinate = location
        self.title = pinTitle
        self.subtitle = pinSubTitle
    }
    
    
    
    
  
    
  
}
