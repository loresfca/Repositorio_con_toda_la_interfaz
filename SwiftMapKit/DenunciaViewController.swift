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
    @IBOutlet weak var etiquetaTipo: UILabel!
    @IBOutlet weak var selectTipo: UIPickerView!
    @IBOutlet weak var etiquetaDelegacion: UILabel!
    let delegacion=["Álvaro Obregón","Azcapotzalco","Benito Juárez","Coyoacán","Cuajimalpa","Cuahutémoc","Gustavo A Madero","Iztacalco","Iztapalapa","Magdalena Contreras","Miguel Hidalgo","Milpa Alta","Tláhuac","Tlalpan","Venustiano Carranza","Xochimilco"];
    let tipo=["Queja contra elemento","Vigilancia","Vialidad y tránsito","Robo"];
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTipo.delegate=self;
        selectTipo.dataSource=self;
        selectDelegacion.delegate=self;
        selectDelegacion.dataSource=self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        didSelectRow row: Int,
                     inComponent component: Int)
    {
        if (pickerView.tag == 1){
            etiquetaTipo.text = tipo[selectTipo.selectedRowInComponent(0)];
        }else{
            etiquetaDelegacion.text = delegacion[selectDelegacion.selectedRowInComponent(0)];
        }
        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}