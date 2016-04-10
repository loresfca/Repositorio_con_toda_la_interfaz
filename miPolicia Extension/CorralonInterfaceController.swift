//
//  CorralonInterfaceController.swift
//  SwiftMapKit
//
//  Created by Benjamin Gil on 4/9/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import WatchKit
import Foundation


class CorralonInterfaceController: WKInterfaceController {

    @IBOutlet var placaLabel: WKInterfaceLabel!
    @IBOutlet var depositoLabel: WKInterfaceLabel!
    
    @IBOutlet var fechaElabel: WKInterfaceLabel!
    @IBOutlet var entrega: WKInterfaceLabel!
    @IBOutlet var fEntregaLabel: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let pl = context as? Placa{
            let p = pl.placa
            print(p)
          placaLabel.setText("Placa: "+p)
          depositoLabel.setText("Deposito: " + (pl.deposito))
          fechaElabel.setText(pl.fechaLlegada)
            entrega.setText("Entrega de: " + p)
            fEntregaLabel.setText(pl.fechaEntrega)
            
            
        }
        
        
       
        
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
