
import UIKit
import Alamofire
class appList: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUsages()
        
    }
    
    func getUsages(){
        let url = URL(string: "http://localhost:8888/APIBienestapp/public/index.php/api/mostrar")
        print("sesion iniciada")
        let header = ["Authentication": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Imphdmllcl9mYWJyZWdhc19hcHBzMW1hMTgxOUBjZXYuY29tIn0.CPmIcFFSltjwwdByDJAIS_EM4iuIeYZjKnkdv7KQM3E"]
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            let usages = response.result.value as! [[String:Any]]
            
            for use in usages{
                print(use["application_id"]!)
            }
        }
    }
}
