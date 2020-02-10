
import Foundation
import UIKit
import Alamofire

class userController: UIViewController{
    
    @IBOutlet weak var Pass1: UITextField!
    @IBOutlet weak var Pass2: UITextField!
    @IBOutlet weak var PassError: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = user.name
        userEmail.text = user.email
        
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
        let header = ["Authentication": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Imphdmllcl9mYWJyZWdhc19hcHBzMW1hMTgxOUBjZXYuY29tIn0.CPmIcFFSltjwwdByDJAIS_EM4iuIeYZjKnkdv7KQM3E"]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response)
        }
    }
}
