
import UIKit
import Alamofire
class appList: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getUsages(){
             let url = ("http://localhost:8888/APIBienestapp/public/index.php/api/register")
        
        Alamofire.request(url).responseJSON {(response) in
            if let json = response.result.value {
                let jsonParseado = json as! [[String: Any]]
                var usos: [Usos] = []
                for uso in jsonParseado {
                    usos.append(Usos(json: uso))
                }
                for uso in usos {
                    print(uso.quote)
                }
            }
        }
    }
}
