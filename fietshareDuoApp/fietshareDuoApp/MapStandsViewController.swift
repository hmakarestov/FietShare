//
//  MapStandsViewController.swift
//  fietshareDuoApp
//
//  Created by Student on 07/11/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import MapKit //second
import CoreLocation

class MapStandsViewController: UIViewController,UITabBarDelegate,UINavigationBarDelegate {

    @IBOutlet weak var mapView: MKMapView!
     var bikes = [Bike] ()
    let fietshare = Fietshare ()
    let locationManager = CLLocationManager()
    let regionInMeters: CLLocationDistance = 1000.0
    var previousLocation: CLLocation?
    
    let geoCoder = CLGeocoder()
    var directionsArray : [ MKDirections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        fietshare.sessionActive = true
        fietshare.addAnnotation(mapView: mapView)
        
        // Do any additional setup after loading the view.
    }
    func navigationBar(_ navigationBar: UINavigationBar,
                       didPop item: UINavigationItem){
        if item.title == "Stands" {
            print("Going back")
            
            
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.title == "Map" {
         //   performSegue(withIdentifier: "mapStands", sender: self)
          //  fietsshare.sessionActive=true
            print("BACK TO MAP")
            
        }
          else if(item.title=="Profile")
            {
                print("PROFILE")
            }
        }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        //        let me = CLLocationCoordinate2D(latitude: 51.4416, longitude: 5.4697)
        //        if let location = locationManager.location?.coordinate {
        //            let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)) //MKCoordinateRegion.init(center: me, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        //            mapView.setRegion(region, animated: true)
        //            mapView.delegate = self
        //        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            centerViewOnUserLocation()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapStandsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MapStandsViewController: MKMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // let me = CLLocationCoordinate2D(latitude: 51.2416, longitude: 5.4697)
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            
            self.mapView.setRegion(region, animated: true)
        }
    }
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("rendering map")
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard self != nil else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard (placemarks?.first) != nil else {
                //TODO: Show alert informing the user
                return
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
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        let identifier = "AnnotationView"
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if pin == nil  {
            pin = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier) // CustomAnnotationView
            pin!.image = UIImage(named: "bikes")
            
        }
        else {
            pin!.annotation = annotation
        }
        
        let btn = UIButton()
        btn.setTitle("Parking", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.frame = CGRect(x: 0, y: 0, width: 90, height: 50)
        pin!.rightCalloutAccessoryView = btn
        // btn.addTarget(self, action: #selector(ViewController.goToListWithBikes), for: .touchDown)
       // btn.addTarget(self, action: #selector(MapStandsViewController.goToListWithBikes), for: .touchDown)
        
        
        //IMPORTANT
        //pin?.canShowCallout = true; // this one is the default pop up of a callOut, currently a customized one is in work
        
        //pin?.image =  UIImage(named: "bike")
        
        // Resize image
        let pinImage = UIImage(named: "bikeparking")
        let size = CGSize(width: 35, height: 25)
        UIGraphicsBeginImageContext(size)
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        pin?.image = resizedImage
        
        return pin
    }
    
    
   
    @objc func close() {
        print("Annotation callOut closed") // your implementation(segues and etc)
        
        for annotation in self.mapView.selectedAnnotations
        {
            self.mapView.deselectAnnotation(annotation, animated: true)
        }
        
    }
    
    @objc func getListOfbikes() {
        print("list with bikes") // your implementation(segues and etc)
        //performSegue(withIdentifier: "bikeList", sender: self)}
        
    }
    
    @objc func goToListWithBikes() {
        print("A list of bikes") // your implementation(segues and etc)
        
        
        let alertController = UIAlertController(title: "You are about to reserve a bike", message: "You have 15 min to reach the bike and unclock it. After 15 minutes the reservation will expire.", preferredStyle: .actionSheet)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionCancel = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: {(alert: UIAlertAction!) in self.close()}) //You can use a block here to ha
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "bikesTableList", sender: self)})//You can use a block here to handle a press on this button
        
        alertController.addAction(actionCancel)
        alertController.addAction(actionOk)
        
        //  actionOk.addTarget(self, action: #selector(ViewController.getListOfbikes()), for: .touchDown)
        
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("mapView(_:annotationView:calloutAccessoryControlTapped)")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let bikePin = view.annotation as! CustomAnnotation
        
        self.bikes = bikePin.bikes
       
        print("The anotation tit.e was selected!: \(String(describing: view.annotation?.title))")
        //  print("The anotation was selected!: \(String(describing: pin?.title))")
        
        print("The anotation subTitle was selected!: \(String(describing: view.annotation?.subtitle))")
        print("The anotation coordinate was selected!: \(String(describing: view.annotation?.coordinate))")
        
    }
   
}

extension MapStandsViewController: ExampleCalloutViewDelegate {
    func mapView(_ mapView: MKMapView, didTapDetailsButton button: UIButton, for annotation: MKAnnotation) {
        print("mapView(_:didTapDetailsButton:for:)")
    }
    
    
}



