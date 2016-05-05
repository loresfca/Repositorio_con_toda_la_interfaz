//
//  ViewController.swift
//  SwiftMapKit
//
//  Created by L00228817 on 5/4/15.
//  Copyright (c) 2015 Tec de Monterrey. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MiPin : NSObject, MKAnnotation {
    let title:String?
    let subtitle:String?
    var coordinate:CLLocationCoordinate2D
    let telefono:String?
    
    init(title:String, subtitle:String, coordenadas: CLLocationCoordinate2D, telefono:String){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordenadas
        self.telefono=telefono
    }
}

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate, UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapa: MKMapView!
    
    
    
    //    @IBOutlet weak var label1: UILabel!
    //    @IBOutlet weak var label2: UILabel!
    //    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var botonCorralon: UIButton!
    
    @IBOutlet weak var tablaOpciones: UITableView!
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.pinTintColor = UIColor.redColor()
        pin.canShowCallout = true
        if let logo = UIImage(named: "tu") {
            pin.detailCalloutAccessoryView = UIImageView(image: logo)
        }
        return pin
    }
    
    @IBAction func llamarEmergencia(sender: AnyObject) {
        let telegonoEmergencia = "(55)46042513";
        UIApplication.sharedApplication().openURL(NSURL(string:"telprompt:"+telegonoEmergencia)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
        tablaOpciones.delegate=self;
        tablaOpciones.dataSource=self;
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    
        mapa.delegate=self
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
            let posActual = locationManager.location
            if(posActual != nil){

                let cl=CLLocationCoordinate2DMake(posActual!.coordinate.latitude,posActual!.coordinate.longitude)
                
                mapa.region=MKCoordinateRegionMakeWithDistance(cl, 1000, 1000)
                
                mapa.zoomEnabled=true
                mapa.mapType=MKMapType.Standard
                mapa.showsCompass=true
                mapa.showsScale=true
                mapa.showsTraffic=false
                
                var punto = CLLocationCoordinate2D()
                punto.latitude = posActual!.coordinate.latitude
                punto.longitude = posActual!.coordinate.longitude
                
                let pin=MiPin(title: "Tu posición", subtitle: "Aquí te encuentras!", coordenadas: punto, telefono:"54832020")
                mapa.addAnnotation(pin)
            }
            
        default:
            locationManager.stopUpdatingLocation()
            mapa.showsUserLocation = false
        }
    }
    
    private let datos = ["BUSCA TU CUADRANTE","FACULTADOS PARA INFRACCIONAR","REGLAMENTO DE TRÁNSITO","POLICÍA TURÍSTICA","SEGURIDAD PRIVADA","ACOMPAÑAMIENTO DE CUENTAHABIENTES","ENGLISH ASSISTANCE","POLÍTICA DE PRIVACIDAD"]
    
    private let arrImagenes=["pointer","policia","burbujas","policia_turistica","escudo","estrella","informacion","estrella","telefono","urgente"];
    
    //Para la tabla
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datos.count
    }
    
    let identificador = "Identificador"
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(
            identificador)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.Default, reuseIdentifier: identificador)
        }
        cell?.textLabel?.text=datos[indexPath.row]
        cell?.imageView?.image=UIImage(named:arrImagenes[indexPath.row])
        
        return cell!
    }
    
    
    //Hacer el trigger del segue correspondiente
    //a la pantalla que se requiera dependiendo del
    //numero de renglon selecionado de la tabla
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row){
        case 0:
            performSegueWithIdentifier("segueCuadrante", sender: nil)
            break;
        case 1:
            performSegueWithIdentifier("segueFacultados", sender: nil)
            break;
        case 2:
            performSegueWithIdentifier("segueReglamento", sender: nil)
            break;
        case 3:
            performSegueWithIdentifier("segueTuristica", sender: nil)
            break;
        case 4:
            performSegueWithIdentifier("seguePrivada", sender: nil)
            break;
            
        case 5:
            let refreshAlert = UIAlertController(title: "Confirmar",
                                                 message: "El acompañamiento a cuentahabientes es solicitado a través de la UCS...",
                                                 preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Llamar a la UCS", style: .Default, handler: { (action: UIAlertAction!) in
                UIApplication.sharedApplication().openURL(NSURL(string:"telprompt:52089898")!)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .Default, handler: { (action: UIAlertAction!) in
                
                refreshAlert .dismissViewControllerAnimated(true, completion: nil)
                
                
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
            break;
        case 6:
            let telefonoIngles:String="52089275"
            UIApplication.sharedApplication().openURL(NSURL(string: "telprompt:"+telefonoIngles)!)
            break;
        case 7:
            performSegueWithIdentifier("seguePoliticas", sender: nil)
            break;
        default:
            break;
        }
    }
    
    
}

