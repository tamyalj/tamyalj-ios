//
//  Authin.swift
//  MyVisits
//
//  Created by Ahmed Al Neyadi on 7/4/19.
//  Copyright © 2019 FatimaAljassmi. All rights reserved.
//

import Foundation
import FirebaseAuth
typealias  LoginHandler = (_ msg: String?) -> Void;
struct  LoginErrorCode {
    static let INVALID_EMAIL = "INVALID EMAIL ADDRESS, PLEASE PROVIDE A REAL EMAIL ADDRESS";
    static let WRONG_PASSWORD = "WORNG PASSWORD, PLEASE ENTER THE CORRECT PASSWORD";
    static let PROBLEM_CONNECTING = "PROBLEM CONNECTING TO DATABASE PLEASE TRY LATER";
    static let USER_NOT_FOUND = "USER NOT FOUND, PLEASE REGISTER";
    static let EMAIL_ALREADY_IN_USE = " EMAIL ALREADY IN USE , PLEASE USE ANOTHER EMAIL";
    static let WEAK_PASSWORD = "PASSWORD SHOULD BE AT LEAST 6 CHARACTERS LONG";
}
class AuthProvider {
    //to access the class
    private static let _instance = AuthProvider();
    static var Instance: AuthProvider{
        return _instance;
    }
    
    func signUp(withEmail: String, password: String, fname: String, lname: String, city: String, phoneNumber: Int, loginHandler: LoginHandler?){
        
        Auth.auth().createUser(withEmail: withEmail, password: password, completion: {(user, error) in
            
            if error != nil {
                
                handleErrors(err: error! as NSError, loginHandler: loginHandler)
            }
            else{
                
                if user?.uid != nil {
                    
                    //store the user to database
                    DBProvider.Instance.saveUser(withID: user!.uid , email: withEmail, password: password)
                    
                    
                    // login the user
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler);
                    
                }
                
            }
            
        });
        
}
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




