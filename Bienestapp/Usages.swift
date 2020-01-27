//
//  Usages.swift
//  Bienestapp
//
//  Created by alumnos on 27/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Foundation

class Usos{
    var quote: String
    init(json: [String: Any]){
        quote = json["quote"] as? String ?? ""
    }
}
