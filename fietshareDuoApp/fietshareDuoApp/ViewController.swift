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
    @IBOutlet weak var pinView: PinView!
    
    //let customAnnotation = CustomAnnotation(pinTitle: "", pinSubTitle: "")
    
    let fietshare = Fietshare ()
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
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
        
       
        //IMPORTANT
          //pin?.canShowCallout = true; // this one is the default pop up of a callOut, currently a customized one is in work
        
        //pin?.image =  UIImage(named: "bike")
        
        // Resize image
        let pinImage = UIImage(named: "bikes")
        let size = CGSize(width: 35, height: 25)
        UIGraphicsBeginImageContext(size)
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        pin?.image = resizedImage
      
     
//      pinView.distanceLabel.text = "50"
    
        //pin?.pintTintColor
        //pin?.tintColor = redPinColor()
       
//        if(pin?.isSelected==true){
//            pin?.isHighlighted=true
//        }
//
       
        return pin
    }
//    func redPinColor() -> UIColor {
//        return UIColor.red
//    }
    
    func configureDetailView(annotationView: MKAnnotationView, bikePin: CustomAnnotation) {
        
        let width = 250
        let widthImage = 200
        let heightImage = 230
        let height = 250
        
        let snapshotView = UIView()
        let views = ["snapshotView": snapshotView]
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[snapshotView(280)]", options: [], metrics: nil, views: views))
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[snapshotView(250)]", options: [], metrics: nil, views: views))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: widthImage, height: heightImage - 40))
        
        // configure button1
        let button1 = UIButton(frame: CGRect(x: 20, y: height - 25, width: width / 1 - 5, height:30)) // original 35, x moves the buttom from left to right and vice versa
        button1.setTitle("Reserve", for: .normal)
    
        button1.backgroundColor = UIColor.green
        button1.layer.cornerRadius = 10
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.black.cgColor
        button1.addTarget(self, action: #selector(ViewController.goToListWithBikes), for: .touchDown)
        
        
        let lbAvailable = UILabel(frame: CGRect(x: 80, y: 1, width: 180, height: 13))
        
       // lbAvailable.text = bikePin.title
      
        lbAvailable.textColor = .black
        
       let nrOfAvailable = UILabel(frame: CGRect(x: 240, y: 60, width: 50, height: 13))
        for s in fietshare.stands{
            for b in s.bikes {
                lbAvailable.text = "Available Bikes: " + String(s.getNrOfAvailableBikes()) // shows too big numbers
          nrOfAvailable.text =  String(b.distance) + "M"
        
            }
            
        }
      
        let btnClose = UIButton(frame: CGRect(x:0 , y:0 , width: 30, height: 25))
        btnClose.setTitle("X", for: .normal)
        btnClose.backgroundColor = UIColor.darkGray
        btnClose.addTarget(self, action: #selector(ViewController.close), for: .touchDown)
        // configure button2
//        let button2 = UIButton(frame: CGRect(x: width / 2 + 5, y: height - 35, width: width / 2, height: 35))
//        button2.setTitle("Posts", for: .normal)
//        button2.backgroundColor = UIColor.darkGray
//        button2.layer.cornerRadius = 5
//        button2.layer.borderWidth = 1
//        button2.layer.borderColor = UIColor.black.cgColor
//        button2.addTarget(self, action: #selector(ViewController.goToPosts), for: .touchDown)
        
        let label1 = UILabel(frame: CGRect(x: 30, y: 10, width: 60, height: 15))
        label1.text = "Bikes"
        // configure image
        let image = UIImage(named: "bikeAvatar")
        imageView.image = image // implement your own logic
        imageView.layer.cornerRadius = imageView.frame.size.height / 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        // adding it to view
        snapshotView.addSubview(imageView)
        snapshotView.addSubview(button1)
        snapshotView.addSubview(lbAvailable)
        snapshotView.addSubview(nrOfAvailable)
        snapshotView.addSubview(btnClose)
        // snapshotView.addSubview(button2)
        
        annotationView.detailCalloutAccessoryView = snapshotView
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
                                     handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "bikeList", sender: self)})//You can use a block here to handle a press on this button
      
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
       // bikePin.title = "Avaiable Bikes"
       // self.spotDetailsForSendToPostsStripController = bikePin.spotDetailsItem
        configureDetailView(annotationView: view, bikePin: bikePin) // adding the proper pop up
        //
       print("The anotation tit.e was selected!: \(String(describing: view.annotation?.title))")
            //  print("The anotation was selected!: \(String(describing: pin?.title))")
        
         print("The anotation subTitle was selected!: \(String(describing: view.annotation?.subtitle))")
         print("The anotation coordinate was selected!: \(String(describing: view.annotation?.coordinate))")
    
    }
}

class CustomAnnotationView: MKPinAnnotationView {  // or nowadays, you might use MKMarkerAnnotationView
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
       // let button : UIButton = UIButton
        canShowCallout = true
        //rightCalloutAccessoryView =  UIButton(type: .contactAdd)//UIButton(type: .custom)
        //
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension ViewController: ExampleCalloutViewDelegate {
    func mapView(_ mapView: MKMapView, didTapDetailsButton button: UIButton, for annotation: MKAnnotation) {
        print("mapView(_:didTapDetailsButton:for:)")
    }
}


