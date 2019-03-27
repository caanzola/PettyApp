//
//  MapaEncontradaViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/26/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import GoogleMaps
import GooglePlaces
import CoreLocation
import MapKit

class MapaEncontradaViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UISearchBarDelegate, LocateOnTheMap {
    
    var descript: String!
    var url: String!
    var imageName: String!
    var imageC: UIImage!
    
    @IBOutlet weak var googleMapsViewContainer: UIView!
    var urlDescarga: URL!
    var urlDownload: String!
    var urlDown = ""
    var tipo = ""
    
    var lati: String!
    var longi: String!
    
    var cammara:GMSCameraPosition!
    var googleMapsView: GMSMapView!
    
    let locationManager = CLLocationManager()
    let GoogleSearchPlaceApiKey = "AIzaSyDM-nmY6qNYj0Q67v0h743IPETNrTjRr50"
    
    var imageReference: StorageReference{
        return Storage.storage().reference() .child("Resources")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    func regresar(alert: UIAlertAction)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let x = storyBoard.instantiateViewController(withIdentifier: "y") as! CustomTabBarViewController
        //self.navigationController?.pushViewController(x, animated: true)
        self.present(x, animated: true, completion: nil)
    }
    
    
    
    @IBAction func enviar(_ sender: Any)
    {
        if self.tipo == "perdida"
        {
            guard let image = self.imageC else {return}
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
            let uploadImageRef = self.imageReference.child(imageName)
            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                print("Upload task finished")
                print(metadata ?? "No metadata")
                print(error ?? "No error")
                
                let o = self.imageReference.child(self.imageName)
                o.downloadURL(completion: { (url, error) in
                    self.urlDescarga = url
                    self.urlDownload = self.urlDescarga.absoluteString
                    print(self.urlDownload)
                    print("")
                })
            }
            uploadTask.observe(.progress) { (snapshot) in
                print(snapshot.progress ?? "No more progress")
            }
            uploadTask.resume()
            
            let alert = UIAlertController(title: "Confirmación", message: "Tu anuncio ha sido registrado exitosamente.", preferredStyle: .alert)
            let subButton = UIAlertAction(title: "Ok", style: .default, handler: self.regresar)
            
            alert.addAction(subButton)
            self.present(alert, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                
                let mascotasReference = Firestore.firestore().collection("perdidas")
                let parameters: [String: Any] = ["descripcion":self.descript,  "url":self.urlDownload, "imageFileName":self.imageName, "latitud":self.lati, "longitud": self.longi]
                mascotasReference.addDocument(data: parameters)
                
                
            }
        }
        else
        {
            guard let image = self.imageC else {return}
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
            let uploadImageRef = self.imageReference.child(imageName)
            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                print("Upload task finished")
                print(metadata ?? "No metadata")
                print(error ?? "No error")
                
                let o = self.imageReference.child(self.imageName)
                o.downloadURL(completion: { (url, error) in
                    self.urlDescarga = url
                    self.urlDownload = self.urlDescarga.absoluteString
                    print(self.urlDownload)
                    print("")
                })
            }
            uploadTask.observe(.progress) { (snapshot) in
                print(snapshot.progress ?? "No more progress")
            }
            uploadTask.resume()
            
            let alert = UIAlertController(title: "Confirmación", message: "Tu anuncio ha sido registrado exitosamente.", preferredStyle: .alert)
            let subButton = UIAlertAction(title: "Ok", style: .default, handler: self.regresar)
            
            alert.addAction(subButton)
            self.present(alert, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                
                let mascotasReference = Firestore.firestore().collection("encontradas")
                let parameters: [String: Any] = ["descripcion":self.descript,  "url":self.urlDownload, "imageFileName":self.imageName, "latitud":self.lati, "longitud": self.longi]
                mascotasReference.addDocument(data: parameters)
                
                
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print()
        print("-------- A ver ----------")
        print()
        
        self.showCurrentLocationOnMap()
        self.locationManager.stopUpdatingLocation()
    }
    
    func showCurrentLocationOnMap()
    {
        lati = "\(self.locationManager.location?.coordinate.latitude ?? 0.0)"
        longi = "\(self.locationManager.location?.coordinate.longitude ?? 0.0)"
        
        cammara = GMSCameraPosition.camera(withLatitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: 17.0)
        
        googleMapsView = GMSMapView.map(withFrame: self.googleMapsViewContainer.frame, camera: cammara)
        googleMapsView.delegate = self
        //view = mapView
        
        googleMapsView.settings.myLocationButton = true
        googleMapsView.isMyLocationEnabled = true
        
        let markker = GMSMarker()
        markker.position = cammara.target
        markker.snippet = "Current Location"
        markker.map = googleMapsView
        self.view.addSubview(self.googleMapsView)
        
        //searchResultController = SearchResultsController()
        //searchResultController.delegate = self
        //gmsFetcher = GMSAutocompleteFetcher()
        //gmsFetcher.delegate = self
        
        //view = mapView
        //self.googleMapsViewContainer.addSubview(mapView)
        //googleMapsViewContainer = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
    {
        print("///////////////////////")
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        print("///////////////////////")
        
        let cammaraa = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 17.0)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: cammaraa)
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        let markker = GMSMarker()
        markker.position = cammaraa.target
        markker.snippet = "Current Location"
        markker.map = mapView
        self.view.addSubview(mapView)
        view = mapView
        
        //self.googleMapsViewContainer.addSubview(mapView)
        //googleMapsViewContainer = mapView
    }
    
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String)
    {
        
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.googleMapsView.camera = camera
            
            marker.title = "Address : \(title)"
            marker.map = self.googleMapsView
            
        }
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
