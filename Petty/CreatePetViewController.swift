//
//  CreatePetViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/21/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit

class CreatePetViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var raceTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet var imageButton: UIButton!
    
    var image: UIImage!
    var llegoImagen: String!
    var nameEdit: String!
    var raceEdit: String!
    var weightEdit: String!
    var ageEdit: String!
    var id: String!
    var urlDownload: String!
    var imageName: String!
    var cambioImagen: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTextField.delegate = self
        self.raceTextField.delegate = self
        self.weightTextField.delegate = self
        self.ageTextField.delegate = self
        
        if self.llegoImagen == "Si"
        {
            self.imageButton.setImage(self.image, for: .normal)
            self.nameTextField.text = self.nameEdit
            self.raceTextField.text = self.raceEdit
            self.weightTextField.text = self.weightEdit
            self.ageTextField.text = self.ageEdit
            
        }
        
        // Do any additional setup after loading the view.
    }
    
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField{
        case nameTextField:
            if ((textField.text?.count)! + (string.count-range.length)) > 20 {
                return false
            }
            else
            {
                return true
            }
        case raceTextField:
            if ((textField.text?.count)! + (string.count-range.length)) > 20 {
                return false
            }
            else
            {
                return true
            }
        case ageTextField:
            if ((textField.text?.count)! + (string.count-range.length)) > 20 {
                return false
            }
            else
            {
                return true
            }
        case weightTextField:
            if ((textField.text?.count)! + (string.count-range.length)) > 20 {
                return false
            }
            else
            {
                return true
            }
        default:
            return true
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    view.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        scroll.setContentOffset( CGPoint(x: 0.0, y: 220.0), animated: true)
        
    }

    @IBAction func save(_ sender: Any)
    {
        performSegue(withIdentifier: "tres", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var vc = segue.destination as! ProcessingMascotaViewController
        vc.name = nameTextField.text ?? ""
        vc.race = raceTextField.text ?? ""
        vc.weight = weightTextField.text ?? ""
        vc.age = ageTextField.text ?? ""
        vc.imagen = imageButton.currentImage
        vc.editar = "No"
        
        if llegoImagen == "Si"
        {
            vc.editar = "Si"
            vc.id = self.id
            
            if self.cambioImagen != "Si"
            {
                vc.urlDown = self.urlDownload
                vc.imageFileName = self.imageName
            }
            else
            {
                vc.cambioImagen = "Si"
                vc.imagen = imageButton.currentImage
            }
        }
        
    }
    
    
    
    
    @IBAction func takePhoto(_ sender: UIButton)
    {
        print("asdasdASD ////////// ")
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
        
        if self.llegoImagen == "Si"
        {
            self.cambioImagen = "Si"
        }
        
        //self.dismiss(animated: true, completion: nil)
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
