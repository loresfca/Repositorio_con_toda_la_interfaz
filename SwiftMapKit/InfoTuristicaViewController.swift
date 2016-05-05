//
//  InfoTuristicaViewController.swift
//  SwiftMapKit
//
//  Created by Carla Flores on 10/04/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//

import UIKit

class InfoTuristicaViewController: UIViewController {

    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var imagen: UIImageView!
    
    
    var infoText:String=""
    var titulo:String="";
    var nombreImagen:String="";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        info.text=infoText;
        imagen.image=UIImage(named:nombreImagen)
        self.title = titulo;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"",
                                                                style:.Plain,
                                                                target:nil,
                                                                action:nil)
    }
    

}
