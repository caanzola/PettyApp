//
//  FourthViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 2/21/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class FourthViewController: UIViewController {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var raza: UILabel!
    @IBOutlet weak var peso: UILabel!
    @IBOutlet weak var edad: UILabel!
    
    @IBOutlet weak var imagePet: UIImageView!
    
    var nombreText = ""
    var id = ""
    var urlDownload = ""
    var imageName = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nombre.text = nombreText
        
        let mascotasReference = Firestore.firestore().collection("mascotas")
        
        mascotasReference.addSnapshotListener { (snapshot,_) in
            
            guard let snapshot = snapshot else { return }
            
            for document in snapshot.documents
            {
                let data = document.data()
                let name: String
                name = data["name"] as! String
                
                if name == self.nombreText
                {
                    self.raza.text = data["race"] as! String
                    self.peso.text = data["weight"] as! String
                    self.edad.text = data["age"] as! String
                    self.id = data["id"] as! String
                    self.urlDownload = data["urlImage"] as! String
                    self.imageName = data["imageFileName"] as! String
                }
            }
        }
    }
    
    
    @IBAction func edit(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var vc = segue.destination as! CreatePetViewController
        vc.image = self.imagePet.image
        vc.llegoImagen = "Si"
        vc.nameEdit = self.nombre.text
        vc.raceEdit = self.raza.text
        vc.weightEdit = self.peso.text
        vc.ageEdit = self.edad.text
        vc.id = self.id
        vc.urlDownload = self.urlDownload
        vc.imageName = self.imageName
    }
    
    
    
}
