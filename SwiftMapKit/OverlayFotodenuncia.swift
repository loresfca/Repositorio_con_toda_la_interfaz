//
//  OverlayFotodenuncia.swift
//  Mi Policia
//
//  Created by Versatran on 4/21/16.
//  Copyright © 2016 Tec de Monterrey. All rights reserved.
//



import UIKit

class OverlayFotodenuncia:UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextViewDelegate{
    
    @IBOutlet weak var textoComentario: UITextView!
    @IBOutlet weak var fotoTomada: UIImageView!
    
    var image:UIImage!
    var picker = UIImagePickerController()
    var yaTomoEsaFoto=false;
    
    var tamanoFoto=100;
    
    let ov = OverlayFotodenunciaControlador(nibName: "OverlayFotodenunciaControlador", bundle: nil)
    
    func presentarCamara(){
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
        picker.cameraOverlayView = ov.view
        picker.allowsEditing = false
        presentViewController(picker, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        yaTomoEsaFoto=false
        super.viewDidAppear(animated)
    }
    
    func updateDisplay(){
        fotoTomada.image=image;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate=self
        textoComentario.delegate = self;
        presentarCamara()
        self.eliminarTecladoEnTap()
    }
    
    @IBAction func tomarOtraFoto(sender: AnyObject) {
        presentarCamara()
    }
    
    //guardar la foto
    //IMPORTANTE LEER: ESTE CONTROLADOR GENERA UNA COPIA DE LA FOTO
    //TOMADA Y LA COMPRIME DE TAL FORMA QUE QUEPA EN EL IMAGEVIEW
    //PERO AL GUARDAR LA FOTO O COMPARTIRLA POR REDES SOCIALES
    //LO HACE CON LA DEFINICION Y TAMANO INTACTOS
    
    
    @IBAction func guardar(sender: AnyObject) {
        if(yaTomoEsaFoto==false){
            UIImageWriteToSavedPhotosAlbum(self.image!, nil, nil, nil)
            let alerta = UIAlertController(title:"Guardada", message: "Su foto ha sido guardada!", preferredStyle:.Alert)
            let okAction = UIAlertAction( title: "OK", style:.Default, handler: nil)
            alerta.addAction(okAction)
            presentViewController(alerta, animated: true, completion: nil)
            yaTomoEsaFoto = true;
        }else{
            let alerta = UIAlertController(title:"Foto repetida", message: "Ya guardo esa foto anteriormente!", preferredStyle:.Alert)
            let okAction = UIAlertAction( title: "OK", style:.Default, handler: nil)
            alerta.addAction(okAction)
            presentViewController(alerta, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
//        self.image = UIGraphicsGetImageFromCurrentImageContext()
        self.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        fotoTomada.image=reescalarImagen(image!, nuevoTamano: CGSize(width: self.tamanoFoto,height: self.tamanoFoto));
//        UIGraphicsEndImageContext()
        
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    func eliminarTecladoEnTap() {
        let tapPantalla: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OverlayFotodenuncia.dismissKeyboard))
        view.addGestureRecognizer(tapPantalla)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func reescalarImagen(imagen: UIImage, nuevoTamano: CGSize) -> (UIImage) {
        let newRect = CGRectIntegral(CGRectMake(0,0, nuevoTamano.width, nuevoTamano.height))
        UIGraphicsBeginImageContextWithOptions(nuevoTamano, false, 0)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context, .High)
        let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, nuevoTamano.height)
        CGContextConcatCTM(context, flipVertical)
        CGContextDrawImage(context, newRect, image.CGImage)
        let nuevaImagen = UIImage(CGImage: CGBitmapContextCreateImage(context)!)
        UIGraphicsEndImageContext()
        return nuevaImagen
    }
    
    //RED SOCIAL
    @IBOutlet weak var comentario: UITextView!
    
    @IBAction func compartirFotoDenuncia(sender: AnyObject) {
        let comentarioCompartir=comentario!.text
        let imagenCompartir=self.image
        let objetosCompartir:[AnyObject]=[comentarioCompartir,imagenCompartir]
        let actividad = UIActivityViewController(activityItems: objetosCompartir,
                                                 applicationActivities:nil)
        actividad.excludedActivityTypes=[UIActivityTypeOpenInIBooks, UIActivityTypeAddToReadingList,
                                         UIActivityTypeAssignToContact,UIActivityTypePrint,
                                         UIActivityTypePostToWeibo,UIActivityTypePostToTencentWeibo]
        self.presentViewController(actividad,animated:true,completion:nil)
        
    }
    
}