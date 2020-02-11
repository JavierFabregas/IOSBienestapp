
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
    
    
    @IBAction func exit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScreen = segue.destination as! restrictController
        //let celda = sender as! Cell
        let app = Application()
        app.name = nameApp.text!
        app.icon = imageApp.image
        //app.usetime = application?.name
        nextScreen.application = app
    }
}
