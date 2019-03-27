//
//  ListaRescateViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/26/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit

import Firebase
import FirebaseFirestore
import FirebaseStorage

class ListaRescateViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var tipo: String!
    
    
    var titlesF = [String]()
    var imagesF = [UIImage]()
    
    let prueba = [UIImage(named: "RescueTab"),
                  UIImage(named: "RescueTab"),
                  UIImage(named: "RescueTab"),
                  UIImage(named: "RescueTab")]
    
    let relativeFontWelcomeTitle:CGFloat = 0.045
    let relativeFontButton:CGFloat = 0.060
    let relativeFontCellTitle:CGFloat = 0.023
    let relativeFontCellDescription:CGFloat = 0.015
    
    var imageReference: StorageReference{
        return Storage.storage().reference().child("Resources")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self.tipo)
        
        if self.tipo == "encontradas"
        {
            
            readEncontradas()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            
            
            
            
           
        }
        else
        {
            readPerdidas()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func readEncontradas()
    {
        let mascotasReference = Firestore.firestore().collection("encontradas")
        mascotasReference.addSnapshotListener { (snapshot,_) in
            
            guard let snapshot = snapshot else { return }
            
            var c = 1;
            for document in snapshot.documents
            {
                let data = document.data()
                print("")
                print(data)
                print("")
                
                self.titlesF.append(data["descripcion"] as! String)
                
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
            }
            
            
        }
    }
    
    func readPerdidas()
    {
        let mascotasReference = Firestore.firestore().collection("perdidas")
        mascotasReference.addSnapshotListener { (snapshot,_) in
            
            guard let snapshot = snapshot else { return }
            
            var c = 1;
            for document in snapshot.documents
            {
                let data = document.data()
                print("")
                print(data)
                print("")
                
                self.titlesF.append(data["descripcion"] as! String)
                
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
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titlesF.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! PerdidasEncontradasCollectionViewCell
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
        {
            let cellIndex = indexPath.item
            
            if (self.imagesF.isEmpty)
            {
                let alert = UIAlertController(title: "No tienes internet ", message: "Requieres de una conexion de internet para poder ver la imagen de las mascotas  ", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
                
                cell.imageView.image = self.prueba[cellIndex]
            }
            else
            {
                cell.imageView.image = self.imagesF[cellIndex]
            }
            
            cell.nameView.text = "Descripción: "+self.titlesF[cellIndex]
            
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
