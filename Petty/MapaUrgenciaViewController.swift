//
//  ViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/18/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import MapKit
import FirebaseStorage

class MapaUrgenciaViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UISearchBarDelegate, LocateOnTheMap, GMSAutocompleteFetcherDelegate {
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    
    
    @IBOutlet weak var googleMapsViewContainer: UIView!
    let locationManager = CLLocationManager()
    let GoogleSearchPlaceApiKey = "AIzaSyDM-nmY6qNYj0Q67v0h743IPETNrTjRr50"
    
    
    var descript = ""
    var lati: String!
    var longi: String!
    @IBOutlet weak var imageSelected: UIButton!
    var imagen: UIImage!
    var urlDescarga: URL!
    
    var imageReference: StorageReference{
        return Storage.storage().reference() .child("Resources")
    }
    
    
    var imageFfileName: String = "image.jpg"
    
    //todo lo del search
    
    
    var cammara:GMSCameraPosition!
    var googleMapsView: GMSMapView!
    
    
    
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let x1 = UIImage(named: "com1")
        
        self.imageSelected.setImage(x1, for: .normal)
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //let mapView = GMSMapView()
        
        
        // aqui va todo lo de search bar
        
        
        
        // Do any additional setup after loading the view.
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let x = String((0..<6).map{ _ in letters.randomElement()! })
        imageFfileName = x+".jpg"
        
    }
    
    
    @IBAction func sendRequestUrgencia(_ sender: UIBarButtonItem)
    {
       
        self.performSegue(withIdentifier: "dos", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        print("uyuyuyuyuy")
            self.imageSelected = UIButton()
        print(self.imageSelected)
       var termino = false
       // self.imageSelected.setImage(self.imagen, for: .normal)
        
        guard let image = self.imagen else {return}
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        let uploadImageRef = self.imageReference.child(self.imageFfileName)
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            print("Upload task finished")
            termino = true
            print(metadata ?? "No metadata")
            print(error ?? "No error")
            
            print("")
            print("qqqqqqqqqqqqqqq")
            print(self.imageFfileName)
            
            let o = self.imageReference.child(self.imageFfileName)
            o.downloadURL(completion: { (url, error) in
                print("")
                print("kkkkkkkkkk")
                self.urlDescarga = url
                print(self.urlDescarga)
                
                print(url)
                print(url?.absoluteString)
                print("kkkkkkkkkk")
                print("")
                
                print("")
                print("aaaaaaaaa")
                print(self.urlDescarga)
                print("")
                
                var vc = segue.destination as! ProcessingUrgenciaViewController
                
                vc.descriptionn = self.descript
                vc.lat = self.lati
                vc.long = self.longi
                vc.urlDownload = self.urlDescarga
            })
        }
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "No more progress")
            
        }
        uploadTask.resume()
        
        
        
       // }
        
            
       
        
        
        
        
        
        
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
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
        
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
    
    
    @IBAction func search(_ sender: AnyObject)
    {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.present(searchController, animated: true, completion:nil)
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
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        
        let placeClient = GMSPlacesClient()
        //
        //
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)
        {
            (results, error: Error?) -> Void in
            //NSErro verr = Error;
            print("Error @%",Error.self)
            //
            self.resultsArray.removeAll()
            if results == nil {
                return
            }
            //
            for result in results!
            {
                if let result = result as? GMSAutocompletePrediction
                {
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }
            //
            self.searchResultController.reloadDataWithArray(self.resultsArray)
            //
        }
        
        
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
        
        
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
