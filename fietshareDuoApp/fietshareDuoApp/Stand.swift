//
//  Stand.swift
//  fietshareDuoApp
//
//  Created by Student on 21/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public class Stand {
    
    let id : Int
    let nrOfSpots : Int // total spots in a stand
    var nrOfAvailableSpots : Int // total available spots to park a bike in at a specific moment
    var nrOfAvailableBikes : Int // total available bikes in a stand
    
    var bikes = [Bike] ()
    
    init(id:Int, nrOfSpots: Int) {
        
        self.id = id
        self.nrOfSpots = nrOfSpots
       // self.nrOfAvailableSpots = nrOfAvailableSpots
        self.nrOfAvailableBikes = 0
        self.nrOfAvailableSpots =  self.nrOfSpots - self.nrOfAvailableBikes
        //hardcoded bikes
        bikes.append(Bike(id:1,name:"BikeToHeaven",latitude:51.4416,longtitude:5.4697,available:true))
        bikes.append(Bike(id:2,name:"BikeToHell",latitude:51.4616,longtitude:5.4997,available:true))
        bikes.append(Bike(id:3,name:"BikeToBulgaria",latitude:51.4345,longtitude:5.4397,available:true))
        bikes.append(Bike(id:4,name:"Sparta",latitude:51.4316,longtitude:5.4697,available:false))
        bikes.append(Bike(id:5,name:"Athene",latitude:51.4116,longtitude:5.4997,available:true))
        bikes.append(Bike(id:6,name:"Loner",latitude:51.4945,longtitude:5.4397,available:true))
        bikes.append(Bike(id:7,name:"Wolf",latitude:51.4216,longtitude:5.4597,available:false))
        bikes.append(Bike(id:8,name:"De circel",latitude:51.4466,longtitude:5.4797,available:true))
        bikes.append(Bike(id:9,name:"Het vierkant",latitude:51.4445,longtitude:5.4327,available:true))
        bikes.append(Bike(id:10,name:"De driehoek",latitude:51.4716,longtitude:5.4637,available:true))
        bikes.append(Bike(id:11,name:"De baas ",latitude:51.4696,longtitude:5.4957,available:true))
        bikes.append(Bike(id:12,name:"St Zag",latitude:51.4375,longtitude:5.4367,available:true))

    }
    public func assigntBikesToStand() {
        
    }
    public func getNrOfAvailableBikes () -> Int {
//        for b in bikes {
//            if(b.available==true) {
//                self.nrOfAvailableBikes=self.nrOfAvailableBikes+1
//            }
//
//        }
       
        for i in 0...bikes.count { // here comes the problem with the too many shown available bikes 
            nrOfAvailableBikes += 1
        }
        return nrOfAvailableBikes
    }
    
    public func getNrOfAvailableSpots () -> Int {
        
        return  self.nrOfAvailableSpots 
    }
    
    public func getNrOfTotalSpots () -> Int {
        return self.nrOfSpots
    }
    
   
    
    
}
