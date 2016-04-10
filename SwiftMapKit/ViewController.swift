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
    
    @IBOutlet weak var botonCorralon: UIButton!
    
    @IBOutlet weak var tablaOpciones: UITableView!
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.pinTintColor = UIColor.blackColor()
        pin.canShowCallout = true
        if let logo = UIImage(named: "moto") {
            pin.detailCalloutAccessoryView = UIImageView(image: logo)
        }
        return pin
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        var punto = CLLocationCoordinate2D()
        punto.latitude = 19.283996
        punto.longitude = -99.136006
        
        //let pin=MKPointAnnotation()
        let pin=MiPin(title: "Tu posición", subtitle: "Xi", coordenadas: punto, telefono:"54832020")
        
        /*pin.coordinate = punto
        pin.title = "Tec CCM"
        pin.subtitle = "Tlalpan"*/
        mapa.delegate=self
        mapa.addAnnotation(pin)
        
        tablaOpciones.delegate=self;
        tablaOpciones.dataSource=self;

        let cl=CLLocationCoordinate2DMake(19.283996, -99.136006)
        mapa.region=MKCoordinateRegionMakeWithDistance(cl, 1000, 1000)

        mapa.zoomEnabled=true
        mapa.mapType=MKMapType.HybridFlyover
        mapa.showsCompass=true
        mapa.showsScale=true
        mapa.showsTraffic=true
        
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
            mapa.showsUserLocation = true
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
        case 7:
            performSegueWithIdentifier("seguePoliticas", sender: nil)
            break;
        default:
            break;
        }
    }


}

