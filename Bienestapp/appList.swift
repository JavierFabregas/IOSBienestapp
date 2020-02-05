
import UIKit
import Alamofire
import AlamofireImage
class appList: UITableViewController {
    var applications: [[String:Any]]?
    var usages: [[String:Any]]?
    var numberOfRows = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getApplications()
        getUsages()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appCell", for: indexPath) as! Cell
        if(self.applications != nil && self.usages != nil){
            let url = URL(string: self.applications![indexPath.row]["icon"] as! String)
            cell.Imagen.af_setImage(withURL: url!)
            cell.Nombre.text = (self.applications![indexPath.row]["name"] as! String)
            cell.TimeUse.text = (self.usages![indexPath.row]["totalTime"] as! String)
            cell.day.text = (self.usages![indexPath.row]["day"] as! String)
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScreen = segue.destination as! appDetailController
        let celda = sender as! Cell
        let app = Application()
        app.name = celda.Nombre.text!
        app.icon = celda.Imagen.image!
        app.usetime = celda.TimeUse.text!
        nextScreen.application = app
    }
   func dataRecived(){
        if(self.applications == nil && self.usages == nil){
            return
        }
    
        numberOfRows = applications!.count
        self.tableView.reloadData()
    }
    func getUsages(){
        let url = URL(string: "http://localhost:8888/APIBienestapp/public/index.php/api/mostrar")
        print("sesion iniciada")
        let header = ["Authentication": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Imphdmllcl9mYWJyZWdhc19hcHBzMW1hMTgxOUBjZXYuY29tIn0.CPmIcFFSltjwwdByDJAIS_EM4iuIeYZjKnkdv7KQM3E"]
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            self.usages = response.result.value as? [[String:Any]]
            self.dataRecived()
        }
        
    }
    
    func getApplications () {
        
        let url = URL(string: "http://localhost:8888/APIBienestapp/public/index.php/api/application/var")
        print("sesion iniciada")
        
        let header = ["Authentication": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Imphdmllcl9mYWJyZWdhc19hcHBzMW1hMTgxOUBjZXYuY29tIn0.CPmIcFFSltjwwdByDJAIS_EM4iuIeYZjKnkdv7KQM3E"]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            self.applications = response.result.value as! [[String:Any]]
            self.dataRecived()
            
        }
    }
}
