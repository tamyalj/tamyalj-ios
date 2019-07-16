//
//  NewLocation.swift
//  MyVisits
//
//  Created by Ahmed Al Neyadi on 7/4/19.
//  Copyright © 2019 FatimaAljassmi. All rights reserved.
//
/*
import Foundation
import UIKit
import MapKit
import CoreLocation
import FirebaseStorage

class NewLocation: UIViewController, UINavigationControllerDelegate , UIImagePickerControllerDelegate, CLLocationManagerDelegate
{
    private var locationManager = CLLocationManager();
    private var userLocation: CLLocationCoordinate2D?;
    var dateVisti: String = ""
    var time : String = ""
    var Vtitle: String = ""
    var Vname: String = ""
    var currentLocation: CLLocation!

    
  
    
    
    
    @IBOutlet weak var vTitle: UITextField!
    
    @IBOutlet weak var vName: UITextField!

    
    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var imageView: UIImageView!
    
 
    
    
    
    
    
    
    @IBAction func cameraBtn(_ sender: UIButton) {
        
        
        
        
      
        
        //obj to capture
        let picker = UIImagePickerController()
        picker.delegate = self
        //use camera
        picker.sourceType = .camera
        // picture will apper in new lay out
        present(picker, animated: true, completion: nil)

        
        
    }
    
    @IBAction func ImageBtn(_ sender: Any) {
        //create UIIMAGEPICKERCONTROLLER object
        //this is to capture image
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .photoLibrary //this is going to use camera
        
        //the line below will make the picture
        //appear in the new layout
        //with built in button
        present(picker , animated: true , completion: nil)
        
        
        
    }
    
  
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.imageView.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
        
        let alertView = UIAlertController(title: "Thank you for sharing", message: "Your image has been saved to Photo Library!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            
        })
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
        //image in firebase
        let storage = Storage.storage()
        
        var data = Data()
        
        data = selectedImage.pngData()! // image file name
        
        // Create a storage reference from our storage service
        
        let storageRef = storage.reference()
        
       var imageRef = storageRef.child("selectedImage”)
        
        _ = imageRef.putData(data, metadata: nil, completion: { (metadata,error ) in
        
        guard let metadata = metadata else{
        
        print(error)
        
        return
        
        }
        
        let downloadURL = metadata.downloadURL()
        
        print(downloadURL)
        
   
    }
   
    
    //location
    
    private func initializeLocationManager() {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locationManager.location?.coordinate
        {
           userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
            MapView.setRegion(region, animated: true)
            MapView.removeAnnotations(MapView.annotations)
            let annotation = MKPointAnnotation();
            annotation.coordinate = userLocation!;
            annotation.title = "My Location";
            MapView.addAnnotation(annotation);
            
        }
        // locationManager.stopUpdatingLocation()
    }
    
    
    
    @IBAction func forannotation(_ sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began { return }
        let touchLocation = sender.location(in: MapView)
        let locationCoordinate = MapView.convert(touchLocation, toCoordinateFrom: MapView)
        //creating annotation
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(locationCoordinate.latitude, locationCoordinate.longitude)
        
        let date = NSDate()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyy"
        let stringDate = dateFormatter.string(from: date as Date)
        
        
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        // formatter.dateStyle = .long
        
        // get the date time String from the date object
        formatter.string(from: currentDateTime)
        
        //formatter.timeStyle = .medium
        formatter.dateStyle = .none
        let stringtime = formatter.string(from: currentDateTime)
       
            let Accannotation = MKPointAnnotation()
            Accannotation.coordinate = location
            Accannotation.title = "Accident"
            self.MapView.addAnnotation(Accannotation)
        Constants.Instance.annotations(Vtitle: vTitle.text!, latitude: Double(location.latitude), longtitude: Double(location.longitude),Vname: vName.text!, dateofnotify: stringDate, timeofnotify: stringtime )
      
    }
    
    
    
    
    @IBAction func AddNewVisit(_ sender: Any) {
        
        
        
        if self.vTitle.text == "" || self.vName.text == ""
        
        {
            
            let alertController = UIAlertController(title: "Error!", message: "Please fill all the fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else
        {
            
            
            
            
        }
    }
    
    
    
    
}

    
    
    

    
    
    
    

*/
