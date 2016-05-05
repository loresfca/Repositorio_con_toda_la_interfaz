//
//  OverlayFotodenunciaControlador.swift
//  Mi Policia
//
//  Created by Versatran on 4/22/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import UIKit
import CoreLocation

class OverlayFotodenunciaControlador: UIViewController,CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()

    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var latitud: UILabel!
    @IBOutlet weak var longitud: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let hoy = NSDate()
        let formatoFecha = NSDateFormatter()
        formatoFecha.locale = NSLocale.currentLocale()
        formatoFecha.dateFormat = "dd-MM-yyyy HH:mm";
        let fechaHoraStr = formatoFecha.stringFromDate(hoy);
        timestamp.text=fechaHoraStr
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
            let posActual = locationManager.location
            if(posActual != nil){
                latitud.text="Lat: "+(posActual!.coordinate.latitude.description)
                longitud.text="Lng: "+posActual!.coordinate.longitude.description
            }
            
        default:
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    
    
}
