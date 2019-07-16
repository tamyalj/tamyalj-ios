

import FirebaseDatabase
import Firebase



class Visits {
    
    
var Vtitle: String!
var imageURL: URL!
var datetime: String!
var id: String!
    var vname: String!
    var address:String!
    var lat:Double!
    var long:Double!
    
    init(id:String,Vtitle:String, datetime:String,imageURL:URL, vname:String, address:String,lat:Double,long:Double) {
        self.id = id
        self.Vtitle = Vtitle
        self.datetime = datetime
        self.imageURL = imageURL
        self.vname = vname
        self.address = address
        self.lat = lat
        self.long = long
        
    }
    
   
}
    
    
    

