//
//  ControladorBusquedaPlacas.swift
//  SwiftMapKit
//
//  Created by Versatran on 3/16/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import WatchKit

class ControladorBusquedaPlacas: UIViewController,NSURLSessionDelegate {

    
    var nuevoArray:AnyObject?
    
    let direccion="http://api.labcd.mx/v1/seguridad/corralones/"
    
    @IBOutlet weak var placa: UITextField!

    @IBOutlet weak var nombreDeposito: UILabel!
    @IBOutlet weak var fechaLlegada: UILabel!
    @IBOutlet weak var entregaPlaca: UILabel!
    
    @IBOutlet weak var fechaEntrega: UILabel!
    @IBAction func busquedaPlaca(sender: AnyObject) {
        if(placa!.text!==""){
            let alerta_placa_vacia = UIAlertController(title: "Placa vacia", message: "Por favor ingrese una placa.", preferredStyle: UIAlertControllerStyle.Alert)
            alerta_placa_vacia.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alerta_placa_vacia, animated: true, completion: nil)
        }else{
            let url = NSURL(string: (direccion+placa!.text!))
            let datos = NSData(contentsOfURL: url!)
            nuevoArray=JSONParse(datos!)
            if(nuevoArray![0] as? String=="error: placa invalida"){
                
                let alerta_placa_invalida = UIAlertController(title: "Placa inválida", message: "Por favor ingrese una placa válida.", preferredStyle: UIAlertControllerStyle.Alert)
                alerta_placa_invalida.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alerta_placa_invalida, animated: true, completion: nil)
            }else{
//<<<<<<< HEAD
//                if(nuevoArray!["mensaje"] as? String == "Vehículo NO está en corralón"){
//                    let alerta_placa_invalida = UIAlertController(title: "Placa inválida", message: "Por favor ingrese una placa válida.", preferredStyle: UIAlertControllerStyle.Alert)
//                    alerta_placa_invalida.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                    self.presentViewController(alerta_placa_invalida, animated: true, completion: nil)
//                }else{
//                    print(nuevoArray!["direccionCorralon"])
//                }
//=======
                print(nuevoArray!)
                do{
                    if let nombreCorralon:String = try String(nuevoArray!["nombreCorralon"]!){ 
                        nombreDeposito.text = "Llegada al depósito " + nombreCorralon
                        nombreDeposito.font = UIFont.boldSystemFontOfSize(16.0)
                        fechaLlegada.text = nuevoArray!["fechaYHoraRemolque"] as! String?
                        entregaPlaca.text = "Entrega de vehículo " + placa.text!
                        entregaPlaca.font = UIFont.boldSystemFontOfSize(16.0)
                        fechaEntrega.text = nuevoArray!["fecha_Max"] as! String?
                    }
                }catch{
                    print("el coche no esta en el corralon");
                }
            }
        }
    }

    func JSONParse(data: NSData) -> AnyObject? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        } catch let errorParseoJSON {
            print(errorParseoJSON)
        }
        return nil
    }
    
    func JSONParseArray(string: String) -> [AnyObject]{
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding){
            do{
                if let array = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)  as? [AnyObject] {
                    return array
                }
            }catch{
                print("error")
            }
        }
        return [AnyObject]()
    }
    
}
