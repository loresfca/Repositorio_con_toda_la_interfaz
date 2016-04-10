//
//  TuristicaViewController.swift
//  SwiftMapKit
//
//  Created by Carla Flores on 09/04/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import UIKit

class TuristicaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
     private let datos = ["RECOMENDACIONES","DERECHOS","OBLIGACIONES"]
    private let info=["En cualquier urbe del mundo hay que desplazarse con sentido común, es por esto que se recomienda tomar ciertas medidas al visitar la ciudad de México. \n\nSeguridad:\n\n   *La moneda autorizada para cualquier transacción es el peso mexicano. Su tipo de cambio varía diariamente respecto a la cotización del dólar.\n     *Evita el uso de tarjeta de débito o crédito en lugares no establecidos\nUtiliza cajeros automáticos (ATM) de supermercados o bancos que cuenten con personal de seguridad. Usa estos cajeros sólo durante el día.\n    *Si te extravías mantén la calma y pregunta a un policia o dentro de un comercio establecido por direcciones\n     *Mantén bien vigiladas tus pertenencias, especialmente en zonas turísticas o en medio de una aglomeración.","No ser discriminado en la ejecución de las actividades turísticas por cualquiera de los motivos establecidos en el artículo 1º de la Constitución Política de los Estados Unidos Méxicanos y disfrutar de libre acceso y goce a todo el patrimonio turístico, así como su permanencia en las instalaciones de dichos servicios, sin más limitaciones que las derivadas de los reglamentos específicos de cada actividad.\n\n Obtener por cualquier medio disponible la información previa, veraz, completa y objetiva sobre los servicios que conforman los diversos segmentos de la actividad turística y, en su caso, el precio de los mismos.\n\nRecibir servicios turísticos de calidad y de acuerdo a las condiciones contratadas, así como obtener los documentos que acrediten los términos de contratación, facturas o justificantes de pago.\n\nFormular quejas, denuncias y reclamaciones.","Observar las normas de higiene y convivencia social para la adecuada utilización de los servicios y del patrimonio turístico.\n\nAbstenerse de comenter cualquier acto contrario a lo establecido en las leyes y reglamentos, así como propiciar conductas que puedan ser ofensivas o discriminatorias contra cualquier persona o comunidad.\n\nRespetar los reglamentos de uso y régimen interior de los servicios turísticos.\n\nEfectuar el pago de los servicios prestados en el momento de la presentación de la factura o en su caso, en el tiempo y lugar convenidos, sin que el hecho de presentar una reclamación o queja exima del citado pago.\n\nRespetar el entorno natural y cultural de los sitios en que realice sus actividades turísticas.\n\nCualquier otra que contemple la ley General, su Reglamento u otras disposiciones aplicables."]
    private let titulo=["Recomendaciones","Derechos","Obligaciones"]
    @IBOutlet weak var tablaOpciones: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tablaOpciones.delegate=self;
        tablaOpciones.dataSource=self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Para la tabla
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datos.count
    }
    
    let identificador = "Identificador2"
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(
            identificador)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.Default, reuseIdentifier: identificador)
        }
        cell?.textLabel?.text=datos[indexPath.row]
        
        return cell!
    }
    override	func prepareForSegue(segue:	UIStoryboardSegue,	sender:
        AnyObject?)	{
								//	Get	the	new	view	controller	using
        segue.destinationViewController
								//	Pass	the	selected	object	to	the	new	view	controller.
                let	sigVista=segue.destinationViewController	as!	InfoTuristicaViewController
								let	indice=tablaOpciones.indexPathForSelectedRow?.row
								sigVista.infoText=info[indice!];
                                sigVista.titulo=titulo[indice!];
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
