//
//  Fietshare.swift
//  fietshareDuoApp
//
//  Created by Student on 20/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import MapKit

public class Fietshare{
    
    var sessionActive = Bool ()
    var bikesIn = [Bike] ()
    var stands = [Stand] ()
    var stand101 = Stand(id:101, nrOfSpots:15,latitude:51.4516,longtitude:5.4697)
    var stand102 = Stand(id:102, nrOfSpots:15,latitude:51.4616,longtitude:5.4997)
    var stand103 = Stand(id:103, nrOfSpots:15,latitude:51.4345,longtitude:5.4397)
    var stand104 = Stand(id:104, nrOfSpots:15,latitude:51.4316,longtitude:5.4697)
    var stand105 = Stand(id:105, nrOfSpots:15,latitude:51.4116,longtitude:5.4997)
    var stand106 = Stand(id:106, nrOfSpots:15,latitude:51.4945,longtitude:5.4397)
    var stand107 = Stand(id:107, nrOfSpots:15,latitude:51.4716,longtitude:5.4597)
    var stand108 = Stand(id:108, nrOfSpots:15,latitude:51.4516,longtitude:5.4697)
    var stand109 = Stand(id:109, nrOfSpots:15,latitude:51.4616,longtitude:5.4897)
    var stand110 = Stand(id:110, nrOfSpots:15,latitude:51.4345,longtitude:5.4497)
    var stand111 = Stand(id:111, nrOfSpots:15,latitude:51.4116,longtitude:5.4497)
    var stand112 = Stand(id:112, nrOfSpots:15,latitude:51.4945,longtitude:5.4597)

    
    //var loc : CLLocationCoordinate2D
    //  var loco = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
    init() {
        stands.append(stand101)
        stands.append(stand109)
         stands.append(stand102)
         stands.append(stand103)
        stands.append(stand104)
        stands.append(stand105)
        stands.append(stand106)
         stands.append(stand107)
        stands.append(stand108)
        stands.append(stand110)
        stands.append(stand111)
        stands.append(stand112)
        let number = Int.random(in: 0 ..< 100)
        for s in stands {
            s.addBikeToStand(bike:Bike(id:number,name:"  0.20€/per minute",latitude:s.latitude,longtitude:s.longtitude,available:true))
        }
        
        stand101.addBikeToStand(bike: Bike(id:1,name:"  0.20€/per minute",latitude:51.4416,longtitude:5.4697,available:true))
        stand101.addBikeToStand(bike: Bike(id:2,name:"  0.20€/per minute",latitude:51.4616,longtitude:5.4997,available:true))


        stand102.addBikeToStand(bike:Bike(id:3,name:"  0.20€/per minute",latitude:51.4345,longtitude:5.4397,available:true))
       
        stand103.addBikeToStand(bike: Bike(id:4,name:"  0.20€/per minute",latitude:51.4316,longtitude:5.4697,available:false))
        stand103.addBikeToStand(bike: Bike(id:5,name:"  0.20€/per minute",latitude:51.4116,longtitude:5.4997,available:true))
       
        stand104.addBikeToStand(bike: Bike(id:6,name:"  0.20€/per minute",latitude:51.4945,longtitude:5.4397,available:true))
        
        stand105.addBikeToStand(bike:Bike(id:7,name:"  0.20€/per minute",latitude:51.4216,longtitude:5.4597,available:false))
        stand105.addBikeToStand(bike:Bike(id:8,name:"  0.20€/per minute",latitude:51.4466,longtitude:5.4797,available:true))
        stand105.addBikeToStand(bike: Bike(id:9,name:"  0.20€/per minute",latitude:51.4445,longtitude:5.4327,available:true))
        
        stand106.addBikeToStand(bike: Bike(id:10,name:"  0.20€/per minute",latitude:51.4716,longtitude:5.4637,available:true))
        
        stand107.addBikeToStand(bike: Bike(id:11,name:"  0.20€/per minute",latitude:51.4696,longtitude:5.4957,available:true))
       
        stand108.addBikeToStand(bike: Bike(id:12,name:"0.20€/per minute",latitude:51.4375,longtitude:5.4367,available:true))
       


       
        
    }
 
 
    
    public func addAnnotation(mapView: MKMapView){
        var bikePin : MKAnnotation
            for s in stands {
                if sessionActive {
                    bikePin  = CustomAnnotation(pinTitle:" Available Spots: \(String(s.getNrOfAvailableSpots()))", pinSubTitle:" Distance: \(String(s.distance))M" , pinLocation: s.location, bikes:s.bikes)
                    
                }
                else {
                    bikePin  = CustomAnnotation(pinTitle:" Available Bikes: \(String(s.bikes.count))", pinSubTitle:" Distance: \(String(s.distance))M" , pinLocation: s.location, bikes:s.bikes)
                    
                }
               
             
              //  bikePin.title.
                mapView.addAnnotation(bikePin)
                mapView.selectAnnotation(bikePin, animated: true)
                
            }
        }
}
