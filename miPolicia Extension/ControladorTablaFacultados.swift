//
//  ControladorTablaFacultados.swift
//  SwiftMapKit
//
//  Created by Versatran on 4/10/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import WatchKit
import Foundation


class ControladorTablaFacultados: WKInterfaceController {

    @IBOutlet var tabla: WKInterfaceTable!
    
    var arrResultados=[AnyObject]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        print("Sheller:");
        print(context!)
        arrResultados=context! as! [AnyObject]
        print(arrResultados)
    }

    override func willActivate() {
        super.willActivate()
        
        
        tabla.setNumberOfRows(arrResultados.count, withRowType: "renglones")
        
        for (var indice=0; indice<arrResultados.count; indice += 1){
            let renglon=tabla.rowControllerAtIndex(indice) as! ControladorRenglones
            let nombre_completo=arrResultados[indice]["nombre_completo"] as! String
            renglon.label.setText(nombre_completo)
        }
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        let nombreAgente=arrResultados[rowIndex]["nombre_completo"] as! String;
        let placaAgente=arrResultados[rowIndex]["placa"] as! String;
        let arrDatos:[AnyObject]=[nombreAgente,placaAgente]
        return arrDatos;
    }
    

    override func didDeactivate() {
        super.didDeactivate()
    }

}
