import UIKit
import Alamofire
class recoverPasswordController: UIViewController {
    
 
    @IBOutlet weak var emailInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func recoverPassword(_ sender: Any) {
        
        if(emailInput.text!.isEmpty){
            user.email = ""                                       
        }else{
            user.email = emailInput.text!
            postUser(user: user)
        }
        
    }
    func postUser(user: User) {
        let url = URL(string:"http://localhost:8888/APIBienestapp/public/index.php/api/recuperarContrasena")
        let json = ["email": user.email]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            // mostrar error si el correo ya exsiste y si se crea mandar a la pantalla de inicio.
        }
    }
}

