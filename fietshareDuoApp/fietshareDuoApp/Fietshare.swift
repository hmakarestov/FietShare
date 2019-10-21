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
    //var loc : CLLocationCoordinate2D
    //  var loco = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
    init() {
        
        stands.append(Stand(id:101, nrOfSpots:15, nrOfAvailableBikes:8))
        stands.append(Stand(id:102, nrOfSpots:15, nrOfAvailableBikes:10))
        stands.append(Stand(id:103, nrOfSpots:15, nrOfAvailableBikes:8))
        stands.append(Stand(id:104, nrOfSpots:15, nrOfAvailableBikes:12))
        stands.append(Stand(id:105, nrOfSpots:15, nrOfAvailableBikes:10))
        stands.append(Stand(id:106, nrOfSpots:15, nrOfAvailableBikes:4))
    
    }

//    public func Locs () -> CLLocationCoordinate2D {
//        for b in bikes  {
//
//         loc = CLLocationCoordinate2D(latitude: b.getLatitudes(), longitude: b.getLongtitudes())
//        }
//
//        return loc
//    }
    
 
    
    
    public func addAnnotation(mapView: MKMapView){


            for b in stands {
                for bike in b.bikes {

                let bikePin  = CustomAnnotation(pinTitle: bike.name, pinSubTitle: "100m", pinLocation: bike.location)
                   // let bikeAvailablePin = CustomAnnotation(pinTitle: b.getNrOfAvailableBikes.toString, pinSubTitle: "100m", pinLocation: bike.location)
                print(bikePin?.title ?? "Bike")
                mapView.addAnnotation(bikePin!)
                }

            }
    
        
   }
}
