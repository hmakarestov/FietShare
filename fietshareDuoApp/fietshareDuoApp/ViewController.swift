//
//  ViewController.swift
//  fietshareDuoApp
//
//  Created by Student on 17/10/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import MapKit //second
import CoreLocation


class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
 
    //let customAnnotation = CustomAnnotation(pinTitle: "", pinSubTitle: "")
    
    let fietshare = Fietshare ()
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    
    let geoCoder = CLGeocoder()
    var directionsArray : [ MKDirections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        fietshare.addAnnotation(mapView: mapView)
        
       
    }
    
    
//    public func addAnnotation(){
//
//
//
//        for b in fietshare.bikes {
//
//
//
//            let pin  = CustomAnnotation(pinTitle: b.name, pinSubTitle: "100m", pinLocation: b.location)
//            print(pin?.title ?? "Bike")
//            mapView.addAnnotation(pin!)
//
//        }
//    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 0.005, longitudinalMeters: 0.005)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    


    func getDirections () {
        //we need user's location so we can give directions
        guard let location = locationManager.location?.coordinate else {
            //to inform we don't have user's location
            
            return
        }
        
        let request = createDirectionsRequest(from: location)
        
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate {[unowned self] (responce,error) in
            //handle errors if needed
            guard let responce = responce  else {return} // show responce not available in alert
            
            for route in responce.routes{
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func createDirectionsRequest(from coordinate:CLLocationCoordinate2D) -> MKDirections.Request{
        let destinationCoordinate = getCenterLocation(for: mapView).coordinate
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .automobile//.walking
        request.requestsAlternateRoutes = true
        
        return request
        
    }
    
    func resetMapView(withNew directions:MKDirections){
        
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(directions)
        
        let _ = directionsArray.map { $0.cancel() }
        
    }
    @IBAction func goButtonTapped(_sender:UIButton){
        getDirections()
    }
}
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
         //   guard let self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            
          //  let streetNumber = placemark.subThoroughfare ?? ""
        //    let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
               // self.addressLabel.text = "\(streetNumber) \(streetName)"
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        
        return renderer
        
    }
    
    // anotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
      var pin = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if pin == nil  {
            pin = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        //pin?.image =  UIImage(named: "bike")
        
        // Resize image
        let pinImage = UIImage(named: "bike")
        let size = CGSize(width: 35, height: 25)
        UIGraphicsBeginImageContext(size)
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        pin?.image = resizedImage
      
        
        pin?.canShowCallout = false; // should be false otherwise crashing 
        
        return pin
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The anotation was selected!: \(String(describing: view.annotation?.title))")
    }
}

//extension ViewController : MKMapViewDelegate {
   
//}


