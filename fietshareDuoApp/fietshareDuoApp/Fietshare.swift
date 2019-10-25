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
        
        
        //stands.append(stand)
        stand101.addBikeToStand(bike: Bike(id:1,name:"BikeToHeaven",latitude:51.4416,longtitude:5.4697,available:true))
         stand101.addBikeToStand(bike: Bike(id:2,name:"BikeToHell",latitude:51.4616,longtitude:5.4997,available:true))
         stands.append(stand101)
        
        stand102.addBikeToStand(bike:Bike(id:3,name:"BikeToBulgaria",latitude:51.4345,longtitude:5.4397,available:true))
           stands.append(stand102)
        stand103.addBikeToStand(bike: Bike(id:4,name:"Sparta",latitude:51.4316,longtitude:5.4697,available:false))
        stand103.addBikeToStand(bike: Bike(id:5,name:"Athene",latitude:51.4116,longtitude:5.4997,available:true))
         stands.append(stand103)
        stand104.addBikeToStand(bike: Bike(id:6,name:"Loner",latitude:51.4945,longtitude:5.4397,available:true))
         stands.append(stand104)
        stand105.addBikeToStand(bike:Bike(id:7,name:"Wolf",latitude:51.4216,longtitude:5.4597,available:false))
        stand105.addBikeToStand(bike:Bike(id:8,name:"De circel",latitude:51.4466,longtitude:5.4797,available:true))
        stand105.addBikeToStand(bike: Bike(id:9,name:"Het vierkant",latitude:51.4445,longtitude:5.4327,available:true))
         stands.append(stand105)
        stand106.addBikeToStand(bike: Bike(id:10,name:"De driehoek",latitude:51.4716,longtitude:5.4637,available:true))
         stands.append(stand106)
        stand107.addBikeToStand(bike: Bike(id:11,name:"De baas ",latitude:51.4696,longtitude:5.4957,available:true))
          stands.append(stand107)
        stand108.addBikeToStand(bike: Bike(id:12,name:"St Zag",latitude:51.4375,longtitude:5.4367,available:true))
         stands.append(stand108)
       
     
       
       
       
       
      
       
        stands.append(stand109)
        stands.append(stand110)
        stands.append(stand111)
        
        for s in stands{
            s.availableBikes()
        }
       
        
    }
 
 
    
    public func addAnnotation(mapView: MKMapView){

        let img = UIImage(named: "bikes")
            for s in stands {
                for bike in s.bikes {

                    let str = String("\(bike.distance) M")
                    let availbleBikes = String(s.getNrOfAvailableBikes())
                    let bikePin  = CustomAnnotation(pinTitle: "", pinSubTitle: "", pinLocation: s.location ) // image:img)
                    print( s.getNrOfAvailableBikes())
                   // let bikeAvailablePin = CustomAnnotation(pinTitle: b.getNrOfAvailableBikes.toString, pinSubTitle: "100m", pinLocation: bike.location)
               // print(bikePin?.title ?? "Bike")
                     // bikePin.canShowCallout = true;
                mapView.addAnnotation(bikePin)
                    mapView.selectAnnotation(bikePin, animated: true)
                }

            }
        }
}
