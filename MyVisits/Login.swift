

import Foundation
import UIKit
class Login: UIViewController, UITextFieldDelegate{
  
    // var
    
    private let Main_SEGUE = "ShowVisitList";
    @IBOutlet weak var emailtxt: UITextField!
    
    @IBOutlet weak var pwdtxt: UITextField!
    
    @IBOutlet weak var resetEmail: UITextField!
    
    @IBOutlet weak var restView: UIView!
    
   
    
    
    
    
    
    // REG View
    
    @IBOutlet weak var regView: UIView!
    @IBAction func CloseReg(_ sender: UIButton) {
       regView.isHidden = true
    }
    @IBOutlet weak var RegEmail: UITextField!
    
    @IBOutlet weak var RegPas: UITextField!
    
    @IBAction func SubReg(_ sender: UIButton) {
        if RegEmail.text != "" && RegPas.text != ""{
            AuthProvider.Instance.signUp(withEmail: RegEmail.text!, password: RegPas.text!,  loginHandler: { (message) in
                if message != nil {
                    self.alertTheUser(title: "Problem with Creating a New User", message: message!); }
                else {
                    DBProvider.Instance.user = self.emailtxt.text!;
                    self.RegEmail.text = "";
                    self.RegPas.text = "";
                    self.performSegue(withIdentifier: self.Main_SEGUE, sender: nil)
                    
                }
            });
        }
        else{
            alertTheUser(title: "Email and password are Requiered", message:" please enter email and password in the fields");
        }
        
    }
    
    
    @IBAction func REG(_ sender: UIButton) {
        regView.isHidden = false
    }
    
    // fun
    
    @IBAction func CloseBtn(_ sender: UIButton) {
          restView.isHidden = true
    }
    
    @IBAction func Rest(_ sender: UIButton) {
         restView.isHidden = false
    }
    
    
    @IBAction func ResetBtn(_ sender: UIButton) {
        if self.resetEmail.text != "" {
            AuthProvider.Instance.reset(withEmail:resetEmail.text!, loginHandler:
                { (massage) in
                    
                    if massage != nil { // if we dont get an error
                        self.alertTheUser(title: "Success!", message: "Password reset email sent.")
                    }
                    else
                    {self.alertTheUser(title: "Error!", message: massage!)
                        self.resetEmail.text = "";
                        
                    }
            });
            
        }
        else {
            alertTheUser(title: "Email and Password Are Required", message: "Please enter email and password in the text fields")
        }
        
        
        
    }
   
    
    @IBAction func LoginBtn(_ sender: UIButton) {
        if emailtxt.text != "" && pwdtxt.text != "" {
            
            AuthProvider.Instance.login(withEmail:emailtxt.text!, password: pwdtxt.text!, loginHandler: { (massage)in
                
                if massage != nil { // if we dont get an error
                    self.alertTheUser(title: "Problem With Authentication", message: massage!)
                }
                else
                {
                   DBProvider.Instance.user = self.emailtxt.text!;
                    self.emailtxt.text = "";
                    self.pwdtxt.text = "";
                 self.performSegue(withIdentifier: self.Main_SEGUE, sender: nil)
                  
                    
                    
                    
                }
            });
            
        }
            
        else {
            alertTheUser(title: "Email and Password Are Required", message: "Please enter email and password in the text fields")
        }
    }
    
  func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated:  true , completion:  nil);
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
   self.emailtxt.delegate = self
        self.pwdtxt.delegate = self
        self.RegEmail.delegate = self
        self.RegPas.delegate = self
        self.resetEmail.delegate = self
        
    }
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
