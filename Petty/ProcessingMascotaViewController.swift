//
//  ProcessingMascotaViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/21/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ProcessingMascotaViewController: UIViewController {

    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    @IBOutlet weak var alertButton: UIButton!
    let alertService = AlertService()
    
    var name = ""
    var race = ""
    var weight = ""
    var age = ""
    var id = ""
    var urlDown = ""
    var imageFileName = ""
    var cambioImagen = "No"
    var editar = "No"
    
    @IBOutlet weak var imageSelected: UIButton!
    var imagen: UIImage!
    
    var imageReference: StorageReference{
        return Storage.storage().reference() .child("Resources")
    }
    
    
    var imageFfileName: String = "image.jpg"
    var urlDescarga: URL!
    var urlDownload: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("")
        print(self.editar)
        print("")
        
        print("")
        
        if editar == "No"
        {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let x = String((0..<6).map{ _ in letters.randomElement()! })
            imageFfileName = x+".jpg"
            
            imageSelected.setImage(imagen, for: .normal)
            
            guard let image = imageSelected.currentImage else {return}
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
            let uploadImageRef = imageReference.child(imageFfileName)
            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                print("Upload task finished")
                print(metadata ?? "No metadata")
                print(error ?? "No error")
                
                let o = self.imageReference.child(self.imageFfileName)
                o.downloadURL(completion: { (url, error) in
                    print("")
                    print("kkkkkkkkkk")
                    self.urlDescarga = url
                    print(self.urlDescarga)
                    
                    print(url)
                    print(url?.absoluteString)
                    
                    
                    print(self.urlDescarga)
                    self.urlDownload = self.urlDescarga.absoluteString
                    print(self.urlDownload)
                    print("")
                    
                    let mascotasReference = Firestore.firestore().collection("mascotas")
                    print("")
                    
                    print("")
                    print("aaaaaaaaa")
                    print(self.urlDownload)
                    let id = self.imageFfileName.components(separatedBy: ".")[0]
                    
                    print(id)
                    
                    let parameters: [String: Any] = ["name":self.name, "age":self.age,"weight":self.weight, "race":self.race, "urlImage": self.urlDownload, "imageFileName": self.imageFfileName, "id": id]
                    
                    mascotasReference.addDocument(data: parameters)
                    self.editar = "No"
                })
            }
            uploadTask.observe(.progress) { (snapshot) in
                print(snapshot.progress ?? "No more progress")
                
            }
            uploadTask.resume()
            
            
            
            /*DispatchQueue.main.asyncAfter(deadline: .now() + 4)
            {*/
            
            
            //}
        }
        else
        {
            print("Voy a editar")
            print(self.id)
            
            if self.cambioImagen == "Si"
            {
                let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                let x = String((0..<6).map{ _ in letters.randomElement()! })
                imageFfileName = x+".jpg"
            }
            else
            {
                imageFfileName = self.imageFileName
                urlDownload = self.urlDown
            }
            
            imageSelected.setImage(imagen, for: .normal)
            
            guard let image = imageSelected.currentImage else {return}
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
            let uploadImageRef = imageReference.child(imageFfileName)
            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                print("Upload task finished")
                print(metadata ?? "No metadata")
                print(error ?? "No error")
                
                let o = self.imageReference.child(self.imageFfileName)
                o.downloadURL(completion: { (url, error) in
                    print("")
                    print("kkkkkkkkkk")
                    self.urlDescarga = url
                    print(self.urlDescarga)
                    
                    print(url)
                    print(url?.absoluteString)
                    
                    
                    print(self.urlDescarga)
                    self.urlDownload = self.urlDescarga.absoluteString
                    print(self.urlDownload)
                    print("")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        let mascotasReference = Firestore.firestore().collection("mascotas")
                        mascotasReference.addSnapshotListener { (snapshot,_) in
                            
                            guard let snapshot = snapshot else { return }
                            
                            for document in snapshot.documents
                            {
                                print(document.data()["id"])
                                if document.data()["id"]as!String == self.id as!String
                                {
                                    mascotasReference.document(document.documentID).setData(["name":self.name, "age":self.age,"weight":self.weight, "race":self.race, "urlImage": self.urlDownload, "imageFileName": self.imageFfileName, "id": self.id ])
                                }
                                
                            }
                        }
                    }
                    
                })
            }
            uploadTask.observe(.progress) { (snapshot) in
                print(snapshot.progress ?? "No more progress")
                
            }
            uploadTask.resume()
            
            
            
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            
            self.loadingIcon.stopAnimating()
            self.loadingIcon.hidesWhenStopped = true
            
           
            super.viewDidAppear(true)
            let alert = UIAlertController(title: "Confirmación", message: "Tu mascota ha sido registrada exitosamente.", preferredStyle: .alert)
            let subButton = UIAlertAction(title: "Ok", style: .default, handler: self.regresar)
            
            alert.addAction(subButton)
             self.present(alert, animated: true, completion: nil)
            
            
        }
    }
    
    func regresar(alert: UIAlertAction)
    {
        
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let x = storyBoard.instantiateViewController(withIdentifier: "y") as! CustomTabBarViewController
        //self.navigationController?.pushViewController(x, animated: true)
        self.present(x, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
