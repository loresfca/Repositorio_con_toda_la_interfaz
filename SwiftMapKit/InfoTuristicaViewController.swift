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
    var infoText:String=""
    var titulo:String="";
    override func viewDidLoad() {
        super.viewDidLoad()
        info.text=infoText;
        self.title = titulo;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
