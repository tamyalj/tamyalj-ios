
import Foundation
import UIKit
import MapKit
class VisitLocationDetails: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIScrollViewDelegate{
    
    
    
    @IBOutlet weak var Titlelbl: UILabel!
    
    
    @IBOutlet weak var Namelbl: UILabel!
    
    
    @IBOutlet weak var DateTimelbl: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var MapView: MKMapView!
    
    
    @IBOutlet weak var Streetlbl: UILabel!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    var img = UIImage()
    var vtitle = ""
    var name = ""
    var dateT = ""
    var street = ""
    var lat = 0.0
    var long = 0.0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        MapView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 4
        
        
        imageView.image = img
        Titlelbl.text = vtitle
        Namelbl.text = name
        DateTimelbl.text = dateT
        Streetlbl.text = street
      
        let span = MKCoordinateSpan(latitudeDelta: 0.0275, longitudeDelta: 0.0275)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: span)
        self.MapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name
        annotation.subtitle = vtitle
        self.MapView.addAnnotation(annotation)

    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil //so map view draws "blue dot" for standard user location
        } else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView") ?? MKAnnotationView()
                annotationView.image = img
            let size = CGSize(width: 35, height: 50)
            UIGraphicsBeginImageContext(size)
            annotationView.image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            annotationView.image = resizedImage
            annotationView.canShowCallout = true
            
            
            return annotationView
        }
    }*/
    
    
    @IBAction func Share(_ sender: UIButton) {
 
let activityVC = UIActivityViewController(activityItems: [img, vtitle, dateT, street], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)


    }
    
}
