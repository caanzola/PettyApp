//
//  CollectionViewController.swift
//  Petty
//
//  Created by JHON JAIRO GONZALEZ MELO on 3/23/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//
//ios

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct Productos {
    var nombre:String
    var precio:String
    var url:String
    var veterinaria:String
}

class CollectionViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var productosArray = [Productos]()
    var titlesF = [String]()
    var vetF = [String]()
    var pricF = [String]()
    var imagesF = [UIImage]()
    var tipo: String!
    
    let prueba = [UIImage(named: "productsTab"),
                  UIImage(named: "productsTab"),
                  UIImage(named: "productsTab"),
                  UIImage(named: "productsTab")]
    
    /*
     var colectionArr : [String] = ["1","2","3","4"]
     let titlesF = [("Comida1"),("Comida2"),("Comida3"),("Comida4"),("Comida5"),("Comida6"),("Comida7")]
     let vetF = [("veterinaria 1"),
     ("veterinaria 2"),
     ("veterinaria 3"),
     ("veterinaria 4"),
     ("veterinaria 5"),
     ("veterinaria 6"),
     ("veterinaria 7")]
     let pricF = [("20 mil pesos"),
     ("30 mil pesos"),
     ("40 mil pesos"),
     ("35 mil pesos"),
     ("25 mil"),
     ("45 mil pesos"),
     ("50 mil pesos")]
 
    let imagesF = [UIImage(named: "com1"),
                   UIImage(named: "com2"),
                   UIImage(named: "com3")]*/
    
    
    // multiple number to creat font size based on device screen size
    let relativeFontWelcomeTitle:CGFloat = 0.045
    let relativeFontButton:CGFloat = 0.060
    let relativeFontCellTitle:CGFloat = 0.023
    let relativeFontCellDescription:CGFloat = 0.015
    
    var imageReference: StorageReference{
        return Storage.storage().reference().child("Resources")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if self.tipo == "alimento"
        {
            readProductos()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
        else if self.tipo == "medicamentos"
        {
            readMedicamentos()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func readMedicamentos()
    {
        let productsReference = Firestore.firestore().collection("productos")
        productsReference.addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            for document in snapshot.documents
            {
                print(document.data())
                if document.data()["tipo"] as!String == "medicamento"
                {
                    let name = document.data()["name"] ?? ""
                    let precio = document.data()["precio"] ?? ""
                    
                    let url = document.data()["url"] ?? ""
                    let veterinaria = document.data()["veterinaria"] ?? ""
                    let ifn = document.data()["imageFileName"] ?? ""
                    
                    print("")
                    print("imagen nnnnnnnnnnnnnnnnnn")
                    print(ifn)
                    print("")
                    print("")
                    
                    let downloadImageRef = self.imageReference.child(ifn as! String)
                    let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data,error) in
                        if let data = data{
                            let image = UIImage(data: data)
                            self.imagesF.append(image as! UIImage)
                            print("")
                            print("imagesFfFFFFFFFFF")
                            print(self.imagesF)
                            print("")
                            print("")
                        }
                    }
                    
                    
                    
                    self.titlesF.append(name as! String)
                    print(self.titlesF)
                    self.vetF.append(veterinaria as! String)
                    print(self.vetF)
                    self.pricF.append(precio as! String )
                    print(self.pricF)
                }
            }
        }
    }
    
    func readProductos()
    {
        
        let productsReference = Firestore.firestore().collection("productos")
        productsReference.addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            for document in snapshot.documents
            {
                print(document.data())
                if document.data()["tipo"] as!String == "alimento"
                {
                    let name = document.data()["name"] ?? ""
                    let precio = document.data()["precio"] ?? ""
                    
                    let url = document.data()["url"] ?? ""
                    let veterinaria = document.data()["veterinaria"] ?? ""
                    let ifn = document.data()["imageFileName"] ?? ""
                    
                    print("")
                    print("imagen nnnnnnnnnnnnnnnnnn")
                    print(ifn)
                    print("")
                    print("")
                    
                    let downloadImageRef = self.imageReference.child(ifn as! String)
                    let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data,error) in
                        if let data = data{
                            let image = UIImage(data: data)
                            self.imagesF.append(image as! UIImage)
                            print("")
                            print("imagesFfFFFFFFFFF")
                            print(self.imagesF)
                            print("")
                            print("")
                        }
                    }
                    
                    
                    
                    self.titlesF.append(name as! String)
                    print(self.titlesF)
                    self.vetF.append(veterinaria as! String)
                    print(self.vetF)
                    self.pricF.append(precio as! String )
                    print(self.pricF)
                }
                //self.imagesF.append(url as! Ima)
                
                //let producto = Jobs()
                //job.title = Title
                
                //jobsArray.append(job)
                //self.numOfCells += 1
                
            }
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titlesF.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
        {
            
            
            //let thisElement = colectionArr[indexPath.item]
            let cellIndex = indexPath.item
            //let closeFrameSize = bestFrameSize()
            
            //cell.editImg.isHidden = true
            //cell.trashImg.isHidden = true
            //cell.imageView.image = imagesF[cellIndex]
            print(self.titlesF.count)
            print(self.imagesF)
            if (self.imagesF.isEmpty)
            {
                let alert = UIAlertController(title: "No tienes internet ", message: "Requieres de una conexion de internet para poder ver la imagen de los productos  ", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
                
                cell.imageView.image = self.prueba[cellIndex]
                
            }
            else
            {
                cell.imageView.image = self.imagesF[cellIndex]
            }
            
            print(self.titlesF)
            cell.nameView.text = "Descripción: "+self.titlesF[cellIndex]
            //cell.nameView.font = cell.nameView.font.withSize(closeFrameSize * relativeFontCellTitle)
            print(self.vetF)
            cell.veterinariaView.text = "Veterinaria: "+self.vetF[cellIndex]
            //cell.labelDetails.font = cell.labelDetails.font.withSize(closeFrameSize * relativeFontCellDescription)
            print(self.pricF)
            cell.precioView.text = "Precio: "+self.pricF[cellIndex]
            
            
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.white.cgColor
            cell.contentView.layer.masksToBounds = true
            cell.backgroundColor = UIColor.white
            
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
            
        }
        return cell
    }
    

}
