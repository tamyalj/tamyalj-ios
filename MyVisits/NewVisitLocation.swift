
import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class NewVisitLocation: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate , UIImagePickerControllerDelegate, UITextFieldDelegate {

      private let Main_SEGUE = "ShowMain";
    
    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var loTitle: UITextField!
    
    @IBOutlet weak var loNmae: UITextField!
    
    @IBOutlet weak var lat: UILabel!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var long: UILabel!
    
    @IBOutlet weak var latitudeC: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var Addresslbl: UILabel!
    
    var locationManager = CLLocationManager()
    //var currentLocation: CLLocation!
    var previousLocation: CLLocation?
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        // kepboard will disappear
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func UpdateLocation(_ sender: UIButton) {
        locationManager.startUpdatingLocation();
        
    }
    
    
    @IBAction func Upload(_ sender: UIButton) {
        //create UIIMAGEPICKERCONTROLLER object
        //this is to capture image
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary //this is going to use camera
        picker.allowsEditing = true
        
        //the line below will make the picture
        //appear in the new layout
        //with built in button
        present(picker , animated: true , completion: nil)
        
    }
   
    
   // var imagePicker: UIImagePickerController!

 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let selectedImage =
    info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else { fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")}
    
     self.imageView.image = selectedImage
   dismiss(animated: true, completion: nil)
  
    
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        locationManager.stopUpdatingLocation()
        let locValue: CLLocationCoordinate2D = locationManager.location!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.0875, longitudeDelta: 0.0875)
        let region = MKCoordinateRegion(center: locValue, span: span)//this basically tells your map where to look and where from what distanc
        MapView.setRegion(region, animated: true)
        previousLocation = getCenterLocation(for: MapView)
        
    }
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longtitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longtitude)
    }
   

    var streetN: String = ""
    @IBAction func forannotation(_ sender: UITapGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began { return }
        let touchLocation = sender.location(in: MapView)
        let locationCoordinate = MapView.convert(touchLocation, toCoordinateFrom: MapView)
        let geoCoder = CLGeocoder()
        let center = getCenterLocation(for: MapView)
        geoCoder.reverseGeocodeLocation(center){ [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let _ = error {
                
                return
            }
            guard let placemark = placemarks?.first else {
                return
            }
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            DispatchQueue.main.async {
                self.Addresslbl.text = "\(streetNumber) \(streetName)"
            
            }
        
        }
        //creating annotation
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(locationCoordinate.latitude, locationCoordinate.longitude)
        long.text = String(location.longitude)
        latitudeC.text = String(location.latitude)
        self.MapView.removeAnnotations(MapView.annotations)
        let Accannotation = MKPointAnnotation()
        Accannotation.coordinate = location
        Accannotation.title = loTitle.text
        self.MapView.addAnnotation(Accannotation)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker.addTarget(self, action: #selector(NewVisitLocation.datePickerValueChanged), for: UIControl.Event.valueChanged)
        MapView.delegate = self
        MapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        self.loNmae.delegate = self
        self.loTitle.delegate = self
       
        
        
        // long press in map
        let gestureZ = UILongPressGestureRecognizer(target: self, action: #selector(self.forannotation(_:)))
        view.addGestureRecognizer(gestureZ)
        
    }
    
    
    @objc func datePickerValueChanged (datePicker: UIDatePicker) {
        
        let dateformatter = DateFormatter()

    
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.timeStyle = DateFormatter.Style.short
        
        let dateValue = dateformatter.string(from: datePicker.date)
      
            lat.text = dateValue
    
        
        
    }
    @IBAction func SaveBtn(_ sender: Any) {
        
        if self.imageView.image == nil {
            let alertController = UIAlertController(title: "Error!", message: "Please upload visit image.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
      if self.loTitle.text == "" || self.loNmae.text == ""
       
        {
            
            let alertController = UIAlertController(title: "Error!", message: "Please fill all the fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        if self.lat.text == ""{
            
            let dateformatter = DateFormatter()
        let currentDateTime = Date()
            lat.text = dateformatter.string(from: currentDateTime)
            
        }
        
        else
        {
            guard let title = loTitle.text
                else
            {
                print("title issue")
                return
            }
            guard let name = loNmae.text
                else
            {
                print("name issue")
                return
            }
            guard let latitude = Double(latitudeC.text!)
                else
            {
                let alertController = UIAlertController(title: "Error!", message: "Please pin your visit.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                print("coordinater issue")
                return
            }
            
            guard let longtitude = Double(long.text!)
                else
            {
                print("coordinater issue")
                return
            }
            guard let DateT = lat.text
                else
            {
                print("choose date")
        
                return
            }
  
            // Upload images to database
            let uid = Auth.auth().currentUser!.uid
          let imageN = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child(uid).child(imageN) //("\().png")
            let imgData = imageView.image?.pngData()
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            storageRef.putData(imgData!, metadata: nil, completion:
                {(metaData, error) in
                    
                    if error != nil {
                        return
                    }
                    storageRef.downloadURL { (url, error) in
                        let downloadURL = url?.absoluteString
                       
                    DBProvider.Instance.AddVisit(withID: uid,VisitTitle: title, Venuename: name, latitude: Double(latitude), longtitude: Double(longtitude), DateTime: DateT, ImageURL:downloadURL!, streetName: self.Addresslbl.text!)
                    }})

         
         self.performSegue(withIdentifier: self.Main_SEGUE, sender: nil)
            
            
            
            
            
        }}
    
   
   
    
}
