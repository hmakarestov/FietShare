//
//  Bike.swift
//  fietshareDuoApp
//
//  Created by Student on 20/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import MapKit

public class Bike {
    let id : Int
    let name : String
    var location : CLLocationCoordinate2D
    var latitude : Double
    var longtitude : Double
    
    
    let distance : Int // distance from user location..to be implemented
   let available : Bool // whether a bike is available or not 
   // let nrOfAvailable: Int
    
    init(id:Int,name:String, latitude: Double, longtitude: Double,available:Bool) {
        self.id = id
        self.name = name
        self.latitude=latitude
        self.longtitude = longtitude
        
        self.available = available
        self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        self.distance = 50; // to be assigned according to user's location distance to bike
    
    }
    
    
}

