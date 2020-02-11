
import Foundation
import UIKit
import Alamofire
import UserNotifications

class userController: UIViewController{
    
    @IBOutlet weak var Pass1: UITextField!
    @IBOutlet weak var Pass2: UITextField!
    @IBOutlet weak var PassError: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func getPeticiones(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]){(
            autorizado,error
            )in
            if autorizado{
                print("permiso concedido")
            }else{
                print("permiso denegado", error?.localizedDescription)
            }
        }
    }
    
    
    @IBAction func updatePassword(_ sender: Any) {
        if checkInputs() {
            user.password = Pass1.text!
            postUpdate(user: user)
        }
    }
    
    func checkInputs() -> Bool {
        if Pass1.text!.isEmpty || Pass2.text!.isEmpty {
            PassError.text! = "Debes rellenar todos los campos"
            PassError.isHidden = false
            return false
        }else if(Pass1.text! != Pass2.text!){
            PassError.text! = "Las contraseñas no coinciden"
            PassError.isHidden = false
            return false
        }
        return true
    }
    
    func postUpdate(user: User) {
        let url = URL(string: "http://localhost:8888/APIBienestapp/public/index.php/api/updateUser")
        let json = ["password": user.password]
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response)
        }
    }
}
