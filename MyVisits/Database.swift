
import FirebaseAuth
import FirebaseDatabase

typealias  LoginHandler = (_ msg: String?) -> Void;
struct  LoginErrorCode {
    static let INVALID_EMAIL = "INVALID EMAIL ADDRESS, PLEASE PROVIDE A REAL EMAIL ADDRESS";
    static let WRONG_PASSWORD = "WORNG PASSWORD, PLEASE ENTER THE CORRECT PASSWORD";
    static let PROBLEM_CONNECTING = "PROBLEM CONNECTING TO DATABASE PLEASE TRY LATER";
    static let USER_NOT_FOUND = "USER NOT FOUND, PLEASE REGISTER";
    static let EMAIL_ALREADY_IN_USE = " EMAIL ALREADY IN USE , PLEASE USE ANOTHER EMAIL";
    static let WEAK_PASSWORD = "PASSWORD SHOULD BE AT LEAST 6 CHARACTERS LONG";
}



//
class AuthProvider {
    //to access the class
    private static let _instance = AuthProvider();
    static var Instance: AuthProvider{
        return _instance;
    }
    
    
    func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
        
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            
            if error != nil {
                
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler);
            }
            else {
                loginHandler?(nil);
                
            }
            
        })
        
    }
    
   
    
    func signUp(withEmail: String, password: String, loginHandler: LoginHandler?){
        
        Auth.auth().createUser(withEmail: withEmail, password: password, completion: {(user, error) in
            
            if error != nil {
                
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            }
            else{
                let userID = Auth.auth().currentUser?.uid
                if userID  != nil {
                    
                    //store the user to database
                    DBProvider.Instance.saveUser(withID:userID!, email: withEmail, password: password)
                    
                    
                    // login the user
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler);
                    
                }
                
            }
            
        });
        
    }
    
    func reset (withEmail: String, loginHandler: LoginHandler?)
    {
        
        Auth.auth().sendPasswordReset(withEmail: withEmail, completion: { (error) in
            
            if error != nil {
                
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler);
            }
            else {
                loginHandler?(nil);
                
            }
            
        })
        
    }
    
    private func handleErrors(err:NSError, loginHandler: LoginHandler?){
        
        if let errCode = AuthErrorCode(rawValue: err.code){
            
            switch errCode {
                
            case .wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD);
                break;
            case .invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL);
                break;
            case .userNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND);
                break;
            case .emailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE);
                break;
            case .weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD);
                break;
                
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING);
                break;
                
            }
            
        }
        
    }
    
    func logOut() -> Bool {
        if Auth.auth().currentUser != nil {
            
            do {
                try Auth.auth().signOut()
                return true
            }
            catch{
                return false
            }
            
        }
        return true
    }
    
    
}//class

class DBProvider { //singletone
    private static let _instance = DBProvider();
    
    static var Instance: DBProvider {
        return _instance;
    }
    var dbRef: DatabaseReference{
        return Database.database().reference();
    }
    var userRef:DatabaseReference {
        return dbRef.child(Constants.user)
    }
    
    var visitRef:DatabaseReference {
        return dbRef.child(Constants.visitadd);
        
  
        
        
    }

    func saveUser(withID: String, email: String, password: String)  {
        let data: Dictionary<String, Any> = [Constants.email: email, Constants.password: password]
        userRef.child(withID).child(Constants.data).setValue(data)
        // going to databsa to create child caled user with id then values
    }
    
     var user = "";
    
    func AddVisit(withID: String,VisitTitle: String , Venuename: String, latitude: Double, longtitude: Double , DateTime: String, ImageURL: String, streetName: String){
        let data: Dictionary<String, Any> = [Constants.email: user, Constants.Vtitle: VisitTitle, Constants.Vname: Venuename, Constants.Anlatitude: latitude , Constants.Anlongtitude: longtitude,  Constants.dateTime: DateTime, Constants.locImage: ImageURL, Constants.StreetText: streetName]
        
       visitRef.child(withID).childByAutoId().setValue(data);
    }


    
   
}// class




class Constants {
   
    private static let _instance = Constants();
    
    static var Instance: Constants{
        return _instance;
    }
    // static var in other classes
    //DBProvider
    // User Regestriation Constants
    static let user = "user"
    static let email = "email"
    static let password = "password"
    static let data = "data"
    static let visitadd = "visitadd"
    
    
    //user location
    static let Anlatitude = "latitude"
    static let Anlongtitude = "longtitude"
    static let dateTime = "date"
    static let Vname = "Vname"
    static let Vtitle = "Vtitle"
    static let locImage = "locImage"
    static let StreetText = "StreetText"
    
    
    
    
}


