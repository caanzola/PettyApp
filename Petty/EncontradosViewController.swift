//
//  EncontradosViewController.swift
//  Petty
//
//  Created by JHON JAIRO GONZALEZ MELO on 3/23/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit

class EncontradosViewController: UIViewController, UINavigationControllerDelegate , UIImagePickerControllerDelegate, UITextViewDelegate  {
    
    
    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var myTextView: UITextView!
    
    var urlDown = ""
    var imageFileName = ""
    var urlDescarga: URL!
    var urlDownload: String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myTextView.layer.cornerRadius = 8
        self.myTextView.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        self.myTextView.layer.borderWidth = 1.0
        
        myTextView.delegate = self
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let x = String((0..<6).map{ _ in letters.randomElement()! })
        self.imageFileName = x+".jpg"
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
    @IBAction func selectImage(_ sender: UIButton) {
        
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                imagePickerController.sourceType = .camera
                
                self.present(imagePickerController, animated: true, completion: nil)
                
            }else{
                
                print("Camera is not available")
                
            }
            
            
            
        }))
        
        
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        
        
        imageButton.setImage(info[UIImagePickerController.InfoKey.originalImage] as? UIImage, for: .normal)
        
        
        
        
        
        //self.dismiss(animated: true, completion: nil)
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func enviar(_ sender: Any)
    {
        performSegue(withIdentifier: "uno", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var vc = segue.destination as! MapaEncontradaViewController
        vc.descript = self.myTextView.text
        vc.imageName = self.imageFileName
        vc.imageC = self.imageButton.currentImage
        vc.tipo = "encontrada"
    }

}
