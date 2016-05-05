//
//  ControladorDireccionCorralon.swift
//  SwiftMapKit
//
//  Created by Versatran on 4/10/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MiPin2: NSObject, MKAnnotation {
    let title:String?
    let subtitle:String?
    var coordinate:CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordenadas: CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordenadas
    }
}


class ControladorDireccionCorralon: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var textoDireccion: UITextView!
    
    var textoDireccionCorralon:String=""
    var telefono:String=""
    
    private let locationManager = CLLocationManager()
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.pinTintColor = UIColor.redColor()
        pin.canShowCallout = true
        if let logo = UIImage(named: "coche") {
            pin.detailCalloutAccessoryView = UIImageView(image: logo)
        }
        return pin
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        textoDireccion.text=textoDireccionCorralon
        
        mapa.delegate=self
        
        mapa.zoomEnabled=true
        mapa.mapType=MKMapType.Standard
        mapa.showsCompass=true
        mapa.showsScale=true
        mapa.showsTraffic=false
        
        
        var coordCorralon:CLLocationCoordinate2D=CLLocationCoordinate2D();
        
        //Reverse geocoding: convertir una direccion a una coordenada especifica
        //se usa para encontrar al corralon en el mapa con los datos que arroja
        //el api en json
        CLGeocoder().geocodeAddressString(textoDireccionCorralon, completionHandler: { (lugaresCandidatos, error) in
            if error != nil {
                print(error)
                return
            }
            if lugaresCandidatos?.count > 0 {
                let lugares = lugaresCandidatos?[0]
                let location = lugares?.location
                //VARIABLE PARA USAR EN EL MAPA
                if(location?.coordinate != nil){
                    coordCorralon = (location?.coordinate)!
                    print(coordCorralon)
                    let cl = CLLocationCoordinate2DMake(coordCorralon.latitude,
                        coordCorralon.longitude)
                    self.mapa.region=MKCoordinateRegionMakeWithDistance(cl, 1000, 1000)
                    let pin=MiPin2(title: "Tu coche", subtitle: "Aquí esta tu coche!", coordenadas: coordCorralon)
                    self.mapa.addAnnotation(pin)
                }else{
                    print("No se encontro la direccion del corralon!");
                }
            }
        })

    }
    
    @IBAction func compartirUbicacionCorralon(sender: AnyObject) {
        let lugarCorralon = "Lugar del corralon: "+self.textoDireccionCorralon
        let telefonoCorralon = "Telefono del corralon: "+self.telefono
        
        let objetos:[AnyObject]=[lugarCorralon,telefonoCorralon]
        
        let actividad = UIActivityViewController(activityItems: objetos,
                                                 applicationActivities:nil)
                actividad.excludedActivityTypes=[UIActivityTypeMail,UIActivityTypeAirDrop]        
        self.presentViewController(actividad,animated:true,completion:nil)

    }
    
    
    //en caso de querer llamar al corralon directamente
    @IBAction func llamarCorralon(sender: AnyObject) {
        let tel="telprompt:".stringByAppendingString(telefono)
        UIApplication.sharedApplication().openURL(NSURL(string:tel)!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
