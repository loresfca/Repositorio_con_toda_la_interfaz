//
//  ControladorBusquedaReglamento.swift
//  SwiftMapKit
//
//  Created by Versatran on 4/9/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import UIKit

class ControladorBusquedaReglamento: UIViewController, NSURLSessionDelegate,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    
    var datosRespuesta:String="";
    var arregloEncontrados:[AnyObject]=[];
    
    @IBOutlet weak var palabraClave: UITextField!
    @IBOutlet weak var tablaReglamento: UITableView!
    
    @IBAction func buscarReglamento(sender: AnyObject) {
        var arregloArticulos:NSArray;
        
        if (self.datosRespuesta != ""){
            let palabraClaveValor=palabraClave!.text!.lowercaseString;
            
            if(!palabraClaveValor.isEmpty && palabraClave != ""){
                arregloArticulos=JSONParseArray(datosRespuesta)
                self.arregloEncontrados.removeAll()
                for i in 0 ..< arregloArticulos.count{
                    let descripcionToLowerCase:String=(arregloArticulos[i]["descripcion"] as! String).lowercaseString
                    let articuloToLowerCase:String=(arregloArticulos[i]["articulo"] as! String).lowercaseString
                    let fraccionToLowerCase:String=(arregloArticulos[i]["fraccion"] as! String).lowercaseString
                    let diasSancionToLowerCase:String=(arregloArticulos[i]["dias_sansion"] as! String).lowercaseString
                    
                    if(descripcionToLowerCase.rangeOfString(palabraClaveValor) != nil ||
                        articuloToLowerCase.rangeOfString(palabraClaveValor) != nil ||
                        fraccionToLowerCase.rangeOfString(palabraClaveValor) != nil ||
                        diasSancionToLowerCase.rangeOfString(palabraClaveValor) != nil){
                        self.arregloEncontrados.append(arregloArticulos[i]);
                        tablaReglamento.reloadData()
                    }
                }
                if(self.arregloEncontrados.isEmpty){
                    manejarAlerta("No encontrado", mensaje: "No se encontraron artículos con esa palabra.", boton_confirmacion: "OK")
                }else{
                    tablaReglamento.reloadData()
                }
            }else{
                manejarAlerta("Campo vacío", mensaje: "Ingrese una palabra clave del artículo en el campo de texto.", boton_confirmacion: "OK")
            }
        }
    }
    
    func manejarAlerta(titulo:String,mensaje:String,boton_confirmacion:String){
        let alerta = UIAlertController(title: titulo,
                                       message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alerta.addAction(UIAlertAction(title: boton_confirmacion, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    func recuperarFacultadosReglamento(){
        
        let url:NSURL = NSURL(string: "http://201.144.220.174/infracciones/api/articulos/articulo_vigente")!
        
        let sesion = NSURLSession.sharedSession()
        let peticionServidor = NSMutableURLRequest(URL: url)
        peticionServidor.HTTPMethod = "POST"
        
        //datos aleatorios
        let parametros = "datos=7234y5h2n4"
        peticionServidor.HTTPBody = parametros.dataUsingEncoding(NSUTF8StringEncoding)
        let tarea = sesion.dataTaskWithRequest(peticionServidor){
            data, response, error in
            guard ((error == nil) && (data != nil)) else {
                print("Sucedió un error en la conexión!")
                return
            }
            self.datosRespuesta = String(data: data!, encoding: NSUTF8StringEncoding)!
        }
        tarea.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperarFacultadosReglamento()
        tablaReglamento.dataSource = self
        tablaReglamento.delegate = self
        palabraClave.delegate=self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let compartir=segue.destinationViewController as! ControladorRedSocial
        let indice=self.tablaReglamento.indexPathForSelectedRow?.row
        let objetoArticulo=self.arregloEncontrados[indice!]
        compartir.articulo=objetoArticulo;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func JSONParseArray(string: String) -> [AnyObject]{
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding){
            do{
                if let array = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)  as? [AnyObject]{
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
        
        cell.textLabel!.font = UIFont(name:"Avenir", size:14)
        cell.textLabel!.numberOfLines = 0;
        cell.textLabel!.lineBreakMode=NSLineBreakMode.ByWordWrapping
        
        
        let elemento = self.arregloEncontrados[indexPath.row]
        let articulo:String=(elemento["articulo"] as? String)!
        let corralon:String=(elemento["corralon"] as? String)!
        let descripcion:String=(elemento["descripcion"] as? String)!
        let dias_sansion:String=(elemento["dias_sansion"] as? String)!
        let fraccion:String=(elemento["fraccion"] as? String)!
        let inciso:String=(elemento["inciso"] as? String)!
        let puntos:String=(elemento["puntos"] as? String)!
        
        cell.textLabel?.text = "Artículo:"+articulo+" - Fracción:"+fraccion+" - Inciso:"+inciso+" - Unidades de cuenta:"+dias_sansion+" - Puntos:"+puntos+" - Corralón: "+corralon+"\n"+descripcion;
        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>,
                               withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
