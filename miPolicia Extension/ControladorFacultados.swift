//
//  ControladorFacultados.swift
//  SwiftMapKit
//
//  Created by Versatran on 4/10/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import WatchKit
import Foundation


class ControladorFacultados: WKInterfaceController,NSURLSessionDelegate {
    
    @IBOutlet var picker1: WKInterfacePicker!
    @IBOutlet var picker2: WKInterfacePicker!
    
    var letraInicial:String="";
    var numeroPlacaInicial:String="";
    
    var alfabeto:[(String,String)]=[("A","A"),("B","B"),("C","C"),("D","D"),("E","E"),("F","F"),("G","G"),("H","H"),("I","I"),("J","J"),("K","K"),("L","L"),("M","M"),("N","N"),("O","O"),("P","P"),("Q","Q"),("R","R"),("S","S"),("T","T"),("U","U"),("V","V"),("W","W"),("X","X"),("Y","Y"),("Z","Z")]
    var numeros:[(String,String)]=[("0","0"),("1","1"),("2","2"),("3","3"),("4","4"),("5","5"),("6","6"),("7","7"),("8","8"),("9","9")]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        recuperarFacultadosInfraccionar();
        let pickerAlfabeto: [WKPickerItem] =
            alfabeto.map{
                let pickerItem=WKPickerItem()
                pickerItem.caption=$0.0
                pickerItem.title=$0.1
                return pickerItem
        }
        
        let pickerNumeros: [WKPickerItem] =
            numeros.map{
                let pickerItem=WKPickerItem()
                pickerItem.caption=$0.0
                pickerItem.title=$0.1
                return pickerItem
        }
        
        picker1.setItems(pickerAlfabeto)
        picker2.setItems(pickerNumeros)
        
    }
    
    
    var datosRespuesta:String="";
    var arregloEncontrados:[AnyObject]=[];
    var nuevoArray:AnyObject?
    
    @IBAction func buscarFacultado() {
        var objetoFacultados:NSArray;
        objetoFacultados=JSONParseArray(datosRespuesta)
        self.arregloEncontrados.removeAll()
        for i in 0 ..< objetoFacultados.count{
            let nombreCompleto:String=(objetoFacultados[i]["nombre_completo"] as! String)
            let placa:String=(objetoFacultados[i]["placa"] as! String)
            
            if(nombreCompleto.hasPrefix(letraInicial) &&
                placa.hasPrefix(numeroPlacaInicial)){
                self.arregloEncontrados.append(objetoFacultados[i]);
            }
        }
        pushControllerWithName("TablaFacultados", context: self.arregloEncontrados)
    }
    
    func recuperarFacultadosInfraccionar(){
        
        //Datos de la direccion del servidor y el metodo a utilizar
        let url:NSURL = NSURL(string: "http://201.144.220.174/infracciones/api/personal/acreditado_post/")!
        let sesion = NSURLSession.sharedSession()
        let peticionServidor = NSMutableURLRequest(URL: url)
        peticionServidor.HTTPMethod = "POST"
        
        //En este caso no hay parametros, nos va a regresar la lista completa,
        //pero aqui los dejo por si el servidor sirve de nuevo, pero si no se le
        //manda nada en el body manda un error por razones desconocidas...
        //datos=random es un valor placeholder para que nos regrese la lista nada mas
        let parametros = "datos=random"
        peticionServidor.HTTPBody = parametros.dataUsingEncoding(NSUTF8StringEncoding)
        
        //Handler para la peticion
        let tarea = sesion.dataTaskWithRequest(peticionServidor){
            //Verificar que los datos no esten vacios
            data, response, error in
            guard ((error == nil) && (data != nil)) else {
                print("Sucedió un error en la conexión!")
                return
            }
            //Lo que regresa la peticion
            self.datosRespuesta = String(data: data!, encoding: NSUTF8StringEncoding)!
            
            print(self.datosRespuesta)
        }
        tarea.resume()
    }
    
    @IBAction func cambioPicker1(value: Int) {
        letraInicial=(alfabeto[value].1)
    }
    @IBAction func cambioPicker2(value: Int) {
        numeroPlacaInicial=(numeros[value].1)
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
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
