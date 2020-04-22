//
//  ViewController.swift
//  Part_3
//
//  Created by catie on 4/20/20.
//  Copyright © 2020 cmp5987. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    
    //IBOUtlet Variables
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var viewSegment: UISegmentedControl!
    @IBOutlet weak var zoomStepper: UIStepper!
    
    
    //other variables
    let locationManager = CLLocationManager()
    let  geoCoder = CLGeocoder()
    
    var currentCoordinate : CLLocationCoordinate2D?
    
    var regionInMeters:Double?
    var allParks = Parks()
    var parks: [Park] {
        get{
            return self.allParks.parkList
        }
        set(value){
            self.allParks.parkList = value
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        locationManager.delegate = self
        
        
        for park:Park in parks{
            //print("in park for \(park)")
            mapView.addAnnotation(park)
            //mapView.addAnnotation(park)
        }
        
        
        configureLocationService()
        

        
    }

    
    //Code for Action Listeners
    @IBAction func viewSegmentSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
   
    @IBAction func refreshButtonSelected(_ sender: UIBarButtonItem) {
        beginLocationUpdates()
    }
    @IBAction func stepperSelected(_ sender: UIStepper) {
        let zoomLevel = sender.value
        
        guard let latestLocation = locationManager.location else { return }
        
        if zoomLevel == 0.0 {
            //Zoom Out
            zoomOut(with: latestLocation)
        }
        else if zoomLevel == 1.0 {
            //Zoom In
            zoomIn(with: latestLocation)
            
        }
    }
    
    
    //Suplementary Functions
    
    func configureLocationService(){
        let status = CLLocationManager.authorizationStatus()
        
        if status ==  .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }
        else if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates()
        }
        else{
            //give an alert that services will not work
        }
    }
    
    func beginLocationUpdates(){
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    func zoomIn(with zloc: CLLocation){
        let mkCoordinateRegion = MKCoordinateRegion(center: zloc.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
        self.mapView?.setRegion(mkCoordinateRegion, animated: true)
    }
    func zoomOut(with zloc: CLLocation){
        let mkCoordinateRegion = MKCoordinateRegion(center: zloc.coordinate, latitudinalMeters: 4000000, longitudinalMeters: 4000000)
        self.mapView?.setRegion(mkCoordinateRegion, animated: true)
    }
    

}
extension MapViewController: MKMapViewDelegate{
    
    
    func mapView(_ mv: MKMapView, viewFor  annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view: MKPinAnnotationView
        let identifier = "Pin"
        
        if annotation is MKUserLocation {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        if annotation !== mv.userLocation   {
            //look for an existing view to reuse
            if let dequeuedView = mv.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.pinTintColor = MKPinAnnotationView.purplePinColor()
                view.animatesDrop = true
                view.canShowCallout = true
               
                let leftButton = UIButton(type: .infoLight)
                let rightButton = UIButton(type: .detailDisclosure)
                leftButton.tag = 0
                rightButton.tag = 1
                view.leftCalloutAccessoryView = leftButton
                view.rightCalloutAccessoryView = rightButton
            }
            return view
        }
        
        return nil
    }
    
    
    func mapView(_ mv: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //print("In create the annotation")
        
        let parkAnnotation = view.annotation as! Park
        switch control.tag {
        case 0: //left button
            if let url = URL(string: parkAnnotation.getLink()){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case 1: //right button
            let selectedPark = view.annotation
            let currentLocationMapItem = MKMapItem.forCurrentLocation()
            let selectedPlacemark = MKPlacemark(coordinate: (selectedPark?.coordinate)!, addressDictionary: nil)
            let selectedParkMapItem = MKMapItem(placemark: selectedPlacemark)
            let mapItems = [selectedParkMapItem, currentLocationMapItem]
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            MKMapItem.openMaps(with: mapItems, launchOptions:launchOptions)
        default:
            break
        }
    }
    
}
extension MapViewController: CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let latestLocation = locations.first else { return }
        
        currentCoordinate = latestLocation.coordinate
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates()
        }
    }
}
