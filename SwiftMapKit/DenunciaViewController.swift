//
//  DenunciaViewController.swift
//  SwiftMapKit
//
//  Created by Carla Flores on 09/04/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import UIKit

class DenunciaViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate{
    
    @IBOutlet weak var selectDelegacion: UIPickerView!
    @IBOutlet weak var selectTipo: UIPickerView!
    let delegacion=["Álvaro Obregón","Azcapotzalco","Benito Juárez","Coyoacán","Cuajimalpa","Cuahutémoc","Gustavo A Madero","Iztacalco","Iztapalapa","Magdalena Contreras","Miguel Hidalgo","Milpa Alta","Tláhuac","Tlalpan","Venustiano Carranza","Xochimilco"];
    let tipo=["Queja lemento","Vigilancia","Vialidad/tránsito","Robo"];
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTipo.delegate=self;
        selectTipo.dataSource=self;
        selectDelegacion.delegate=self;
        selectDelegacion.dataSource=self;
        self.eliminarTecladoEnTap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.eliminarTecladoEnTap()

    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(
        pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
        ) -> Int {
        if (pickerView.tag == 1){
            return tipo.count
        }else{
            return delegacion.count
        }
    }
    func pickerView(
        pickerView: UIPickerView,
        titleForRow row: Int,
                    forComponent component: Int
        ) -> String?
    {
        if (pickerView.tag == 1){
            return tipo[row];
        }else{
            return delegacion[row];
        }
    }
    
    func pickerView(
        pickerView: UIPickerView,
        didSelectRow row: Int, inComponent component: Int){
        print("seleccionado");
    }
    
    func eliminarTecladoEnTap() {
        let tapPantalla: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DenunciaViewController.dismissKeyboard))
        view.addGestureRecognizer(tapPantalla)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}