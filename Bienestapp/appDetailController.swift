
import Foundation
import UIKit
import Alamofire

var restriction = Restriction()

class appDetailController: UIViewController {
    var application: Application? = nil
    
    @IBOutlet weak var nameApp: UILabel!
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var timeUsedApp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameApp.text = application?.name
        imageApp.image = application?.icon
        timeUsedApp.text = application?.usetime
        
    }
        	
    @IBAction func restrict(_ sender: Any) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let nextScreen = segue.destination as! restrictionController
        //let celda = sender as! Cell
        //let app = Application()
        //app.name = application?.name
        //app.icon = application?.name
        //app.usetime = application?.name
        //nextScreen.application = app
    }
}
