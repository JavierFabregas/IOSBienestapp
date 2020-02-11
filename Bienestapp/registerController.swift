//

import UIKit
import Alamofire
//var user = User()
class registerController: UIViewController {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
        var errores = false
        
        if(nameInput.text!.isEmpty){
            errores = true
            errorName.isHidden = false
        }else{
            user.name = nameInput.text!
            errorName.isHidden = true
        }
        
        if(emailInput.text!.isEmpty){
            errores = true
            errorEmail.isHidden = false
        }else{
            user.email = emailInput.text!
            errorEmail.isHidden = true
        }
        
        if(passwordInput.text!.isEmpty){
            errores = true
            errorPassword.isHidden = false
        }else{
            user.password = passwordInput.text!
            errorPassword.isHidden = true
        }
        
        
        if(!errores){
            
            print("nombre: ", user.name
                + " Email: ", user.email + " Password: ", user.password)
            postUser(user: user)
            uploadCSV()
        }else{
            print("Con errores no llegamos a ningun lado")
        }
    }
    func postUser(user: User) {
        let url = URL(string: "http://localhost:8888/APIBienestapp/public/index.php/api/register")
        let json = ["name": user.name,
                    "email": user.email,
                    "password": user.password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        }
    }
    
    func loginUser(user: User){
        let url = URL(string: "http://localhost:8888/APIBienestapp/public/index.php/api/login")
        let json = ["email": user.email,
                    "password": user.password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            
            var json = response.result.value as! [String: AnyObject]
            token = json["token"] as! String
            
            if(response.response!.statusCode == 201){
                self.performSegue(withIdentifier: "SuccessLogin", sender: nil)
                
            }else{
                let alerta1 = UIAlertAction(title: "Aceptar", style:
                UIAlertAction.Style.default){(error) in
                    
                }
                let alerta = UIAlertController (title: "Error", message: "Login incorrecto", preferredStyle: UIAlertController.Style.alert)
                alerta.addAction(alerta1)
                self.present(alerta, animated: true,completion: nil)
            }
        }
    }
    
    func uploadCSV (){
        let url = URL(string: "http://localhost:8888/APIBienestapp/public/index.php/api/usage")
        let json = ["email": user.email]
        
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response)
            
            
        }
    }
}

