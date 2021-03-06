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
    
    var bikes = [Bike] ()
     private var childContainerController:BikesListTableViewController?
    //let customAnnotation = CustomAnnotation(pinTitle: "", pinSubTitle: "")
   //  var stand = Stand(id:101, nrOfSpots:15,latitude:51.4516,longtitude:5.4697)
    
    let fietshare = Fietshare ()
    let locationManager = CLLocationManager()
    let regionInMeters: CLLocationDistance = 1000.0
    var previousLocation: CLLocation?
    
    let geoCoder = CLGeocoder()
    var directionsArray : [ MKDirections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let helpButton = UIButton(type: .infoLight)
        helpButton.tintColor = UIColor.white
        let rightBarButton = UIBarButtonItem(customView: helpButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        helpButton.addTarget(self, action: #selector(ViewController.goToHelpPage), for: .touchDown)
        checkLocationServices()
        fietshare.sessionActive = false
        fietshare.addAnnotation(mapView: mapView)
        
      
       
    }
    
    @objc func goToHelpPage() {
       performSegue(withIdentifier: "goToHelp", sender: self)
    
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
    
}
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension ViewController: MKMapViewDelegate{
    
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
        
        let btn = UIButton()
        btn.setTitle("Reserve", for: .normal)
        btn.backgroundColor = UIColor(red:0.01, green:0.50, blue:0.00, alpha:1.0)
        btn.frame = CGRect(x: 0, y: 0, width: 90, height: 50)
        pin!.rightCalloutAccessoryView = btn
       // btn.addTarget(self, action: #selector(ViewController.goToListWithBikes), for: .touchDown)
        btn.addTarget(self, action: #selector(ViewController.goToListWithBikes), for: .touchDown)
        
       
        //IMPORTANT
          //pin?.canShowCallout = true; // this one is the default pop up of a callOut, currently a customized one is in work
        
        //pin?.image =  UIImage(named: "bike")
        
        // Resize image
        let pinImage = UIImage(named: "bikeAvatar")
        let size = CGSize(width: 35, height: 25)
        UIGraphicsBeginImageContext(size)
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        pin?.image = resizedImage
        
        return pin
    }

    
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
        lbAvailable.textColor = .black
        let nrOfAvailables = UILabel(frame:CGRect(x: 160, y: -30, width: 180, height: 13))
        
        
        
        let queue = DispatchQueue(label: "update")
        
        queue.async {
            for s in self.fietshare.stands{
                print(s.id)
                print("Nr of bikes")
                print(s.bikes.count)
            }
            // UPDATE UI after all calculations have been done
            DispatchQueue.main.async {
                lbAvailable.text = bikePin.title
                nrOfAvailables.text = bikePin.subtitle
            }
            
        }
        let btnClose = UIButton(frame: CGRect(x:0 , y:0 , width: 30, height: 25))
        btnClose.setTitle("X", for: .normal)
        btnClose.backgroundColor = UIColor.darkGray
        btnClose.addTarget(self, action: #selector(ViewController.close), for: .touchDown)
        
        let label1 = UILabel(frame: CGRect(x: 30, y: 10, width: 60, height: 15))
        label1.text = "Bikes"
        // configure image
        let image = UIImage(named: "bikeAvatar")
        imageView.image = image // implement your own logic
        imageView.layer.cornerRadius = imageView.frame.size.height / 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        imageView.contentMode = UIView.ContentMode.scaleToFill
       // imageView.
        
        // adding it to view
        snapshotView.addSubview(imageView)
        snapshotView.addSubview(button1)
       // snapshotView.addSubview(lbAvailable)
        snapshotView.addSubview(nrOfAvailables)
       // snapshotView.addSubview(btnClose)
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
       // bikePin.title = "Avaiable Bikes"
       // self.spotDetailsForSendToPostsStripController = bikePin.spotDetailsItem
        
     //   configureDetailView(annotationView: view, bikePin: bikePin)
      // adding the proper pop up
        //
       print("The anotation tit.e was selected!: \(String(describing: view.annotation?.title))")
            //  print("The anotation was selected!: \(String(describing: pin?.title))")
        
         print("The anotation subTitle was selected!: \(String(describing: view.annotation?.subtitle))")
         print("The anotation coordinate was selected!: \(String(describing: view.annotation?.coordinate))")
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "bikesTableList"){
            
            self.childContainerController = segue.destination as? BikesListTableViewController
            self.childContainerController!.bikes = self.bikes
            self.childContainerController!.fietshare.sessionActive = self.fietshare.sessionActive
        }
    }
}

class CustomAnnotationView: MKPinAnnotationView {  // or nowadays, you might use MKMarkerAnnotationView
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
       // let button : UIButton = UIButton
        canShowCallout = true
        //leftCalloutAccessoryView = UIButton(type: .contactAdd)//UIButton(type: .custom)
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


