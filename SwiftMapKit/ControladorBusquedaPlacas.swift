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
    
    var direccionCorralon:String="";
    var telefonoCorralon:String=""
    
    let direccion="http://api.labcd.mx/v1/seguridad/corralones/"
    
    @IBOutlet weak var placa: UITextField!
    @IBOutlet weak var botonUbicacionCorralon: UIButton!
    
    @IBOutlet weak var nombreDeposito: UILabel!
    @IBOutlet weak var fechaLlegada: UILabel!
    @IBOutlet weak var entregaPlaca: UILabel!
    
    @IBOutlet weak var fechaEntrega: UILabel!
    @IBAction func busquedaPlaca(sender: AnyObject) {
        if(placa!.text!==""){
            manejarAlerta("Placa vacia", mensaje: "Por favor ingrese una placa.",
                          boton_confirmacion: "OK")
        }else{
            let url = NSURL(string: (direccion+placa!.text!))
            let datos = NSData(contentsOfURL: url!)
            nuevoArray=JSONParse(datos!)
            if(nuevoArray!["mensaje"] as? String == "error: placa invalida"){
                manejarAlerta("Placa inválida", mensaje: "Por favor ingrese una placa válida.",
                              boton_confirmacion: "OK")
            }else{
                if(nuevoArray!["nombreCorralon"]==nil){
                    manejarAlerta("No en corralón", mensaje: "El vehículo no se encuentra en un corralón.",boton_confirmacion: "OK")
                }else{
                    print(nuevoArray);
                    let nombreCorralon:String = (nuevoArray!["nombreCorralon"]! as! String?)!
                    nombreDeposito.text = "Llegada al depósito " + (nombreCorralon)
                    nombreDeposito.font = UIFont.boldSystemFontOfSize(16.0)
                    fechaLlegada.text = nuevoArray!["fechaYHoraRemolque"] as! String?
                    entregaPlaca.text = "Entrega de vehículo " + placa.text!
                    entregaPlaca.font = UIFont.boldSystemFontOfSize(16.0)
                    fechaEntrega.text = nuevoArray!["fecha_Max"] as! String?
                    
                    direccionCorralon=(nuevoArray!["direccionCorralon"] as! String?)!
                    telefonoCorralon=(nuevoArray!["telefonoCorralon"] as! String?)!.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                    botonUbicacionCorralon.hidden=false;
                    
                }
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let ubicacionCorralon=segue.destinationViewController as! ControladorDireccionCorralon
        ubicacionCorralon.textoDireccionCorralon=direccionCorralon
        ubicacionCorralon.telefono=telefonoCorralon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eliminarTecladoEnTap()
        botonUbicacionCorralon.hidden=true;
    }
    
    //Metodo para lanzar alertas a la demanda
    func manejarAlerta(titulo:String,mensaje:String,boton_confirmacion:String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alerta.addAction(UIAlertAction(title: boton_confirmacion, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alerta, animated: true, completion: nil)
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
    
    //Version alternativa al evento de dismiss a traves de resign first responders
    func eliminarTecladoEnTap() {
        let tapPantalla: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ControladorBusquedaPlacas.dismissKeyboard))
        view.addGestureRecognizer(tapPantalla)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
    

