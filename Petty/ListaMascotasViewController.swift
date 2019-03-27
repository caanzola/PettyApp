//
//  ListaMascotasViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/22/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ListaMascotasViewController: UIViewController {
    
  
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var lbl4: UILabel!
    
    var selectedName: String!
    var imageReference: StorageReference{
        return Storage.storage().reference() .child("Resources")
    }
    
    var id1 = ""
    var id2 = ""
    var id3 = ""
    var id4 = ""
    
    var quieroEliminar = "No"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        // Do any additional setup after loading the view.
        
        var lblActual = lbl1
        var imgActual = img1
        
        let mascotasReference = Firestore.firestore().collection("mascotas")
        
        mascotasReference.addSnapshotListener { (snapshot,_) in
            
            guard let snapshot = snapshot else { return }
            
            var c = 1;
            for document in snapshot.documents
            {
                let data = document.data()
                
                print("")
                print("")
                print("00000000000000000")
                print("")
                print(c)
                print(data["urlImage"])
                print(data["imageFileName"])
                print(data)
                let imageName = data["imageFileName"]
                c = c+1
                let downUrl = data["urlImage"]
                
                let name: String
                name = data["name"] as! String
                
                
                let downloadImageRef = self.imageReference.child(data["imageFileName"] as! String)
                let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data,error) in
                    if let data = data{
                        let image = UIImage(data: data)
                        if imgActual == self.img1
                        {
                            self.img1.image = image
                            self.lbl1.text = name
                            self.id1 = document.documentID as! String
                            imgActual = self.img2
                        }
                        else if imgActual == self.img2
                        {
                            self.img2.image = image
                            self.lbl2.text = name
                            self.id2 = document.documentID as! String
                            imgActual = self.img3
                        }
                        else if imgActual == self.img3
                        {
                            self.img3.image = image
                            self.lbl3.text = name
                            self.id3 = document.documentID as! String
                            imgActual = self.img4
                        }
                        else if imgActual == self.img4
                        {
                            self.img4.image = image
                            self.lbl4.text = name
                            self.id4 = document.documentID as! String
                            imgActual = self.img1
                        }
                        
                    }
                    print(error ?? "NO ERROR")
                    
                }
                
                
                /*
                 if lblActual == self.lbl1
                 {
                 self.lbl1.text = name
                 lblActual = self.lbl2
                 }
                 else if lblActual == self.lbl2
                 {
                 self.lbl2.text = name
                 lblActual = self.lbl3
                 }
                 else if lblActual == self.lbl3
                 {
                 self.lbl3.text = name
                 lblActual = self.lbl4
                 }
                 else if lblActual == self.lbl4
                 {
                 self.lbl4.text = name
                 lblActual = self.lbl1
                 }*/
            }
            
            
        }
        
    }
    
    
    @IBAction func onClickBut1(_ sender: Any)
    {
        if self.quieroEliminar == "Si"
        {
            
            if self.lbl1.text != ""
            {
                
                let actionSheet = UIAlertController(title: "Eliminar", message: "Esta mascota se eliminará de tu cuenta", preferredStyle: .actionSheet)
                actionSheet.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { (action:UIAlertAction) in
                    
                    let mascotasReference = Firestore.firestore().collection("mascotas")
                    mascotasReference.addSnapshotListener { (snapshot,_) in
                        
                        guard let snapshot = snapshot else { return }
                        mascotasReference.document(self.id1).delete()
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ELIMINEEEEEE ")
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ")
                        
                    }
                    self.quieroEliminar = "No"
                }))
                
                
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(actionSheet, animated: true, completion: nil)
                
            }
            else
            {
                let alert = UIAlertController(title: "Ups", message: "No tienes ninguna mascota aquí.", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            if self.lbl1.text != ""
            {
                
                selectedName = self.lbl1.text
                /*
                 let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let x = storyBoard.instantiateViewController(withIdentifier: "detalleMascota") as! FourthViewController
                 self.navigationController?.pushViewController(x, animated: true)
                 */
                performSegue(withIdentifier: "detailPet", sender: self)
            }
            else
            {
                let alert = UIAlertController(title: "Ups", message: "No tienes ninguna mascota aquí.", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    

    @IBAction func onClickBut2(_ sender: Any)
    {
        if self.quieroEliminar == "Si"
        {
            if self.lbl2.text != ""
            {
                let actionSheet = UIAlertController(title: "Eliminar", message: "Esta mascota se eliminará de tu cuenta", preferredStyle: .actionSheet)
                actionSheet.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { (action:UIAlertAction) in
                    
                    let mascotasReference = Firestore.firestore().collection("mascotas")
                    mascotasReference.addSnapshotListener { (snapshot,_) in
                        
                        guard let snapshot = snapshot else { return }
                        mascotasReference.document(self.id2).delete()
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ELIMINEEEEEE ")
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ")
                        
                    }
                    self.quieroEliminar = "No"
                }))
                
                
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(actionSheet, animated: true, completion: nil)
                
                /*
                let mascotasReference = Firestore.firestore().collection("mascotas")
                mascotasReference.addSnapshotListener { (snapshot,_) in
                    
                    guard let snapshot = snapshot else { return }
                    mascotasReference.document(self.id2).delete()
                    
                }
                self.quieroEliminar = "No"*/
            }
            else
            {
                let alert = UIAlertController(title: "Ups", message: "No tienes ninguna mascota aquí.", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            if self.lbl2.text != ""
            {
                print("What")
                selectedName = self.lbl2.text
                
                
                performSegue(withIdentifier: "detailPet", sender: self)
            }
            else
            {
                print("Kha")
                let alert = UIAlertController(title: "Ups", message: "No tienes ninguna mascota aquí.", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func onClickBut3(_ sender: Any)
    {
        if self.quieroEliminar == "Si"
        {
            if self.lbl3.text != ""
            {
                let actionSheet = UIAlertController(title: "Eliminar", message: "Esta mascota se eliminará de tu cuenta", preferredStyle: .actionSheet)
                actionSheet.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { (action:UIAlertAction) in
                    
                    let mascotasReference = Firestore.firestore().collection("mascotas")
                    mascotasReference.addSnapshotListener { (snapshot,_) in
                        
                        guard let snapshot = snapshot else { return }
                        mascotasReference.document(self.id3).delete()
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ELIMINEEEEEE ")
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ")
                        
                    }
                    self.quieroEliminar = "No"
                }))
                
                
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(actionSheet, animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Ups", message: "No tienes ninguna mascota aquí.", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            if self.lbl3.text != ""
            {
                selectedName = self.lbl3.text
                performSegue(withIdentifier: "detailPet", sender: self)
                
                
            }
            else
            {
                let alert = UIAlertController(title: "Ups", message: "No tienes ninguna mascota aquí.", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func onClickBut4(_ sender: Any)
    {
        if self.quieroEliminar == "Si"
        {
            if self.lbl4.text != ""
            {
                let actionSheet = UIAlertController(title: "Eliminar", message: "Esta mascota se eliminará de tu cuenta", preferredStyle: .actionSheet)
                actionSheet.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { (action:UIAlertAction) in
                    
                    let mascotasReference = Firestore.firestore().collection("mascotas")
                    mascotasReference.addSnapshotListener { (snapshot,_) in
                        
                        guard let snapshot = snapshot else { return }
                        mascotasReference.document(self.id4).delete()
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ELIMINEEEEEE ")
                        print(" ")
                        print(" ")
                        print(" ")
                        print(" ")
                        
                    }
                    self.quieroEliminar = "No"
                }))
                
                
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(actionSheet, animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Ups", message: "No tienes ninguna mascota aquí.", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            if self.lbl4.text != ""
            {
                selectedName = self.lbl4.text
                performSegue(withIdentifier: "detailPet", sender: self)
                
                
            }
            else
            {
                let alert = UIAlertController(title: "Ups", message: "No tienes ninguna mascota aquí.", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "detailPet"
        {
            var vc = segue.destination as! FourthViewController
            vc.nombreText = self.selectedName
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                
                
                if self.selectedName == self.lbl1.text
                {
                    vc.imagePet.image = self.img1.image
                }
                else if self.selectedName == self.lbl2.text
                {
                    vc.imagePet.image = self.img2.image
                }
                else if self.selectedName == self.lbl3.text
                {
                    vc.imagePet.image = self.img3.image
                }
                else if self.selectedName == self.lbl4.text
                {
                    vc.imagePet.image = self.img4.image
                }
                
            }
        }
        else if segue.identifier == "add"
        {
            var vc = segue.destination as! CreatePetViewController
            vc.llegoImagen = "No"
        }
        
    }
    
    @IBAction func add(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: self)
        
    }
    
    
    @IBAction func remove(_ sender: Any) {
        
        self.quieroEliminar = "Si"
        
        let alert = UIAlertController(title: "Eliminar", message: "Selecciona la mascota que deseas eliminar.", preferredStyle: .alert)
        let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(subButton)
        self.present(alert, animated: true, completion: nil)
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
