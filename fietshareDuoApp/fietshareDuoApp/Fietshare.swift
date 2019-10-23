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
        
        stands.append(Stand(id:101, nrOfSpots:15))
       // stands.append(Stand(id:102, nrOfSpots:15))
       // stands.append(Stand(id:103, nrOfSpots:15))
     //   stands.append(Stand(id:104, nrOfSpots:15))
       // stands.append(Stand(id:105, nrOfSpots:15))
      //  stands.append(Stand(id:106, nrOfSpots:15))
    
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

        let img = UIImage(named: "bikes")
            for s in stands {
                for bike in s.bikes {

                    let str = String("\(bike.distance) M")
                    let availbleBikes = String(s.nrOfAvailableBikes)
                    let bikePin  = CustomAnnotation(pinTitle: "", pinSubTitle: "", pinLocation: bike.location ) // image:img)
                    
                   // let bikeAvailablePin = CustomAnnotation(pinTitle: b.getNrOfAvailableBikes.toString, pinSubTitle: "100m", pinLocation: bike.location)
               // print(bikePin?.title ?? "Bike")
                     // bikePin.canShowCallout = true;
                mapView.addAnnotation(bikePin)
                    mapView.selectAnnotation(bikePin, animated: true)
                }

            }
        }
}
