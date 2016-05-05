//
//  PickerInterfaceController.swift
//  SwiftMapKit
//
//  Created by Benjamin Gil on 4/8/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import WatchKit
import Foundation


class PickerInterfaceController: WKInterfaceController,NSURLSessionDelegate {
    
    @IBOutlet var p1: WKInterfacePicker!
    @IBOutlet var p2: WKInterfacePicker!
    @IBOutlet var p3: WKInterfacePicker!
    
    @IBOutlet var p4: WKInterfacePicker!
    @IBOutlet var p5: WKInterfacePicker!
    @IBOutlet var p6: WKInterfacePicker!
    
    var placa = ""
    var uno = "0"
    var dos = "0"
    var tres = "0"
    var cuatro = "A"
    var cinco = "A"
    var seis = "A"
    var deposito = ""
    var fLlegada = ""
    var fEntrega = ""
    var direccion="http://api.labcd.mx/v1/seguridad/corralones/"
    var nuevoArray:AnyObject?
    
    
    
    @IBAction func placaEnviada() {
        
        placa = uno+dos+tres+cuatro+cinco+seis
        direccion=direccion+placa
        let url = NSURL(string: direccion)
        
        let datos = NSData(contentsOfURL: url!)
        nuevoArray=JSONParse(datos!)
        //print(nuevoArray!)
        deposito=(nuevoArray!["nombreCorralon"] as! String?)!
        fLlegada=(nuevoArray!["fechaYHoraRemolque"] as! String?)!
        fEntrega = (nuevoArray!["fecha_Max"] as! String?)!
        
        let pl = Placa(laPlaca: placa, elDeposito: deposito, laFechaLlegada: fLlegada, laFechaEntrega: fEntrega)
        pushControllerWithName("SecondScreen", context: pl)
        
    }
    
    
    var alfabeto:[(String,String)]=[("A","A"),("B","B"),("C","C"),("D","D"),("E","E"),("F","F"),("G","G"),("H","H"),("I","I"),("J","J"),("K","K"),("L","L"),("M","M"),("N","N"),("O","O"),("P","P"),("Q","Q"),("R","R"),("S","S"),("T","T"),("U","U"),("V","V"),("W","W"),("X","X"),("Y","Y"),("Z","Z")]
    var numeros:[(String,String)]=[("0","0"),("1","1"),("2","2"),("3","3"),("4","4"),("5","5"),("6","6"),("7","7"),("8","8"),("9","9")]
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        
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
        
        p1.setItems(pickerNumeros);
        
        p2.setItems(pickerNumeros);
        p3.setItems(pickerNumeros);
        p4.setItems(pickerAlfabeto);
        p5.setItems(pickerAlfabeto);
        p6.setItems(pickerAlfabeto);
    }
    
    @IBAction func p1Changed(value: Int) {
        uno=(numeros[value].1)
    }
    
    @IBAction func p2Changed(value: Int) {
        dos=(numeros[value].1)
    }
    
    @IBAction func p3Changed(value: Int) {
        tres=(numeros[value].1)
    }
    
    @IBAction func p4Changed(value: Int) {
        cuatro=(alfabeto[value].1)
    }
    
    @IBAction func p5Changed(value: Int) {
        cinco=(alfabeto[value].1)
    }
    
    @IBAction func p6Changed(value: Int) {
        seis=(alfabeto[value].1)
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
