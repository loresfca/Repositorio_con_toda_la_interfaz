//
//  ControladorDetallesResultadosInterfaceController.swift
//  SwiftMapKit
//
//  Created by Versatran on 4/10/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import WatchKit
import Foundation


class ControladorDetallesResultadosInterfaceController: WKInterfaceController {

    @IBOutlet var nombreAgente: WKInterfaceLabel!
    @IBOutlet var placaAgente: WKInterfaceLabel!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        print(context!)
        
        nombreAgente.setText(context![0]! as? String)
        placaAgente.setText(context![1]! as? String)
        
        
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
