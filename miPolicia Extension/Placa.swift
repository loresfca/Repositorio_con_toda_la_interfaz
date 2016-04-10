//
//  placa.swift
//  SwiftMapKit
//
//  Created by Benjamin Gil on 4/9/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import WatchKit

class Placa: NSObject {
    var placa:String
    var deposito:String
    var fechaLlegada:String
    var fechaEntrega:String
    
    init(laPlaca:String,elDeposito:String,laFechaLlegada:String,laFechaEntrega:String) {
        placa=laPlaca
        deposito=elDeposito
        fechaLlegada=laFechaLlegada
        fechaEntrega = laFechaEntrega
    }

}
