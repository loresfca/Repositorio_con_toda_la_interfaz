//
//  ControladorRedSocial.swift
//  SwiftMapKit
//
//  Created by Versatran on 4/10/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import UIKit

class ControladorRedSocial: UIViewController {
    
    @IBOutlet weak var datosArticulo: UITextView!
    
    
    @IBOutlet weak var mensaje: UITextField!
    
    var articulo:AnyObject=[];
    
@IBAction func compartirRedesSociales(sender: AnyObject) {
    let datoArticuloCompartir = datosArticulo!.text
    let mensajeCompartir = mensaje!.text
    
    let objetos:[AnyObject]=[datoArticuloCompartir,mensajeCompartir!]
    
    let actividad = UIActivityViewController(activityItems: objetos,
                                             applicationActivities:nil)
    actividad.excludedActivityTypes=[UIActivityTypeMail]
    
    self.presentViewController(actividad,animated:true,completion:nil)
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    let texto:String="Artículo:" + (articulo["articulo"] as? String)!
        + " Fracción:" + (articulo["fraccion"]  as? String)!
        + "\nPárrafo:" + (articulo["parrafo"]  as? String)!
        + " Inciso:" + (articulo["inciso"]  as? String)!
        + "\nCorralón:" + (articulo["corralon"]  as? String)!
        + "\nPuntos: " + (articulo["puntos"]  as? String)!
        + "\n\n" + (articulo["descripcion"]  as? String)!;
    
    datosArticulo.text=texto
    datosArticulo.contentInset = UIEdgeInsetsMake(-7.0,0.0,0,0.0);
    self.eliminarTecladoEnTap()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

    //Version alternativa al evento de dismiss a traves de resign first responders
    func eliminarTecladoEnTap() {
        let tapPantalla: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ControladorRedSocial.dismissKeyboard))
        view.addGestureRecognizer(tapPantalla)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

}
