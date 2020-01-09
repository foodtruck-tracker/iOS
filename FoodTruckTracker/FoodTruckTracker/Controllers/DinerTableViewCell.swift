
//  DinerTableViewCell.swift
//  FoodTruckTracker
//
//  Created by Lambda_School_Loaner_218 on 1/7/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.


//import UIKit
//import MapKit
//import CoreLocation
//
//
//class DinerTableViewCell: UITableViewCell {
//
//
//    @IBOutlet weak var mapView: MKMapView!
//    @IBOutlet weak var addressLabel: UILabel!
//
//    let locationManager = CLLocationManager()
//    let regionInMeters: Double = 10000
//    var previousLocation: CLLocation?
//
//
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//
//    }
//
//
//    func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//    func checkLoacationServices() {
//        if CLLocationManager.locationServicesEnabled() {
//            checkLocationAuthorization()
//        } else {
//            print("unabel to check location")
//        }
//    }
//
//    func getDirections() {
//        guard let location = locationManager.location?.coordinate else {
//
//            return
//        }
//        let request = createDirectionsRequest(from: location)
//        let directions = MKDirections(request: request)
//
//        directions.calculate { [unowned self] (response, error) in
//            //TODO: handle error is needed
//            guard let response = response else { return } //TODO: shpw response not available in an alert
//
//            for route in response.routes {
//                self.mapView.addOverlay(route.polyline)
//                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//            }
//        }
//    }
//
//    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
//        let destinationCoordinate = getCenterLocation(for: mapView).coordinate
//        let startingLocation =      MKPlacemark(coordinate: coordinate)
//        let destination =           MKPlacemark(coordinate: destinationCoordinate)
//
//        let request =               MKDirections.Request()
//        request.source =            MKMapItem(placemark: startingLocation)
//        request.destination =       MKMapItem(placemark: destination)
//        request.transportType =     .automobile
//        request.requestsAlternateRoutes = true
//
//        return request
//    }
//
//    func resetMapView(withNew directions: MKDirections) {
//        //mapView.removeOverlay(mapView.overlays)
//    }
//
//
//
//    func checkLocationAuthorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            startTrackingUserLocation()
//        case .denied:
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case.restricted:
//            break
//        case.authorizedAlways:
//            break
//
//        }
//    }
//
//    func startTrackingUserLocation() {
//        mapView.showsUserLocation = true
//        centerViewOnUserLocation()
//        locationManager.startUpdatingLocation()
//        previousLocation = getCenterLocation(for: mapView)
//    }
//
//    func centerViewOnUserLocation() {
//        if let location = locationManager.location?.coordinate {
//            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//            mapView.setRegion(region, animated: true)
//        }
//    }
//
//
//    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
//        let latitude = mapView.centerCoordinate.latitude
//        let longitude = mapView.centerCoordinate.longitude
//
//        return CLLocation(latitude: latitude, longitude: longitude)
//    }
//
//
//}
//
//
//extension DinerTableViewCell: CLLocationManagerDelegate {
//
//
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization()
//    }
//}
//
//
//extension DinerTableViewCell: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let center = getCenterLocation(for: mapView)
//        let geoCoder = CLGeocoder()
//
//        guard let perviousLocation = self.previousLocation else { return }
//
//        guard center.distance(from: perviousLocation) > 50 else { return }
//        self.previousLocation = center
//
//        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
//            guard let self = self else { return }
//
//            if let _ = error {
//                //TODO: show alert informing the user
//                return
//            }
//
//            guard let placemark = placemarks?.first else {
//
//                return
//            }
//
//            let streetNumber = placemark.thoroughfare ?? ""
//            let streetName = placemark.thoroughfare ?? ""
//
//            DispatchQueue.main.async {
//                self.addressLabel.text = "\(streetNumber) \(streetName)"
//            }
//        }
//    }
//
//
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
//        render.strokeColor = .blue
//
//        return render
//    }
//}
