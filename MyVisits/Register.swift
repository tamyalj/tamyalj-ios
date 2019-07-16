
import UIKit
class Register: UIViewController, UITextFieldDelegate {

    private let Main_SEGUE = "ShowMain";
    

    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var pwdtxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailtxt.delegate = self
        pwdtxt.delegate = self
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  

    @IBAction func back(_ sender: UIBarButtonItem) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
        present(vc, animated: true, completion: nil)}
        
    
    

    @IBAction func RegBtn(_ sender: UIButton) {
        
        if emailtxt.text != "" && pwdtxt.text != ""{
            AuthProvider.Instance.signUp(withEmail: emailtxt.text!, password: pwdtxt.text!,  loginHandler: { (message) in
                if message != nil {
                    self.alertTheUser(title: "Problem with Creating a New User", message: message!); }
                else {
                  DBProvider.Instance.user = self.emailtxt.text!;
                    self.emailtxt.text = "";
                    self.pwdtxt.text = "";
                    self.performSegue(withIdentifier: self.Main_SEGUE, sender: nil)
                    
                }
            });
        }
        else{
            alertTheUser(title: "Email and password are Requiered", message:" please enter email and password in the fields");
        }
        
    }
  
   


    private func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated:  true , completion:  nil);
    }
    
    
    
    
    
















}
