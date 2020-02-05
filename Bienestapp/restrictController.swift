//
//  restrictController.swift
//  Bienestapp
//
//  Created by alumnos on 05/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import UIKit
import Alamofire


class restrictController: UIViewController {
    var application: Application? = nil
    
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var nameApp: UILabel!
    
    @IBOutlet weak var TimeSlider: UISlider!
    @IBOutlet weak var TimeSliderValue: UILabel!
    
    
    @IBOutlet weak var startHourRestriction: UIDatePicker!
    @IBOutlet weak var finishHourRestriction: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameApp.text = application?.name
        imageApp.image = application?.icon
        //timeUsedApp.text = application?.usetime
    }
    
    @IBAction func SliderValue(_ sender: Any) {
        self.TimeSliderValue.text = "\(self.TimeSlider.value)"
    }
    
    func checkDates (startHourRestriction: Date,finishHourRestriction: Date) -> Date{
        if(startHourRestriction >= finishHourRestriction){
            let newFinish = finishHourRestriction + 86400
            return newFinish
        }
        return finishHourRestriction
    }
    
    @IBAction func sendRestrict(_ sender: Any) {
        let x = self.TimeSlider!.value as Float
        let integer: Int = Int(x)
        
        restriction.name = nameApp.text!
        restriction.max_time = String (integer)
        
        let start = startHourRestriction.date
        let formateador = DateFormatter()
        formateador.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let startTexto = formateador.string(from: start)
        
        let finish = checkDates(startHourRestriction: startHourRestriction.date, finishHourRestriction: finishHourRestriction.date)
        let finishTexto = formateador.string(from: finish)
        
        restriction.start_hour_restriction = startTexto
        restriction.finish_hour_restriction = finishTexto
        
        postRestriction(restriction: restriction)
        
        
    }
    
    func postRestriction(restriction: Restriction){
        let url = URL(string: "http://localhost:8888/APIBienestapp/public/index.php/api/restriction")
        let json = ["name": restriction.name, "max_time": restriction.max_time, "start_hour_restriction": restriction.start_hour_restriction, "finish_hour_restriction": restriction.finish_hour_restriction] as [String : Any]
        
        let header = ["Authentication": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Imphdmllcl9mYWJyZWdhc19hcHBzMW1hMTgxOUBjZXYuY29tIn0.CPmIcFFSltjwwdByDJAIS_EM4iuIeYZjKnkdv7KQM3E"]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers:header).responseJSON { (response) in
            
           print(json)
           print("--------")
           print(response)
        }
    }
    
    
}
