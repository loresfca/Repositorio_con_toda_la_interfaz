//
//  ControladorBusquedaFacultadosInfraccionarViewController.swift
//  SwiftMapKit
//
//  Created by Versatran on 4/9/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import UIKit

class ControladorBusquedaFacultadosInfraccionarViewController: UIViewController,NSURLSessionDelegate,UITableViewDelegate, UITableViewDataSource{
    
    var datosRespuesta:String="";
    var arregloEncontrados:[AnyObject]=[];
    
    
    @IBOutlet weak var nombreFacultados: UITextField!
    @IBOutlet weak var tablaFacultados: UITableView!
    
    @IBAction func buscarFacultado(sender: AnyObject) {
        var objetoFacultados:NSArray;
        
        if (self.datosRespuesta != ""){
            let nombreF=nombreFacultados!.text!.lowercaseString;
            print("NombreF: "+nombreF);
            if(!nombreF.isEmpty && nombreF != ""){
                objetoFacultados=JSONParseArray(datosRespuesta)
                self.arregloEncontrados.removeAll()
                for i in 0 ..< objetoFacultados.count{
                    let nombreCompletoLowerCase:String=(objetoFacultados[i]["nombre_completo"] as! String).lowercaseString
                    let placaLowerCase:String=(objetoFacultados[i]["placa"] as! String).lowercaseString
                    if(nombreCompletoLowerCase.rangeOfString(nombreF) != nil ||
                        placaLowerCase.rangeOfString(nombreF) != nil){
                        self.arregloEncontrados.append(objetoFacultados[i]);
                    }
                }
                if(self.arregloEncontrados.isEmpty){
                    manejarAlerta("No encontrado", mensaje: "No se encontraron elementos con ese nombre o placa.", boton_confirmacion: "OK")
                }else{
                    print(self.arregloEncontrados);
                    tablaFacultados.reloadData()
                }
            }else{
                manejarAlerta("Campo vacío", mensaje: "Ingrese una placa o nombre en el campo de texto.", boton_confirmacion: "OK")
            }
        }
    }
    
    func manejarAlerta(titulo:String,mensaje:String,boton_confirmacion:String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alerta.addAction(UIAlertAction(title: boton_confirmacion, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alerta, animated: true, completion: nil)
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
        }
        tarea.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperarFacultadosInfraccionar()
        
        tablaFacultados.dataSource = self
        tablaFacultados.delegate = self
        self.eliminarTecladoEnTap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    //Para la tabla
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arregloEncontrados.count
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celda",
                                                               forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.numberOfLines = 0;
        
        let elemento = self.arregloEncontrados[indexPath.row]
        let nombre:String=(elemento["nombre_completo"] as? String)!
        let placa:String=(elemento["placa"] as? String)!
        cell.textLabel?.text = nombre+"\nPlaca: "+placa
        return cell
    }
    
    //Version alternativa al evento de dismiss a traves de resign first responders
    func eliminarTecladoEnTap() {
        let tapPantalla: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ControladorBusquedaFacultadosInfraccionarViewController.dismissKeyboard))
        view.addGestureRecognizer(tapPantalla)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
}
