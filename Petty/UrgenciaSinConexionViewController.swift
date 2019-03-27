//
//  UrgenciaSinConexionViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/26/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class UrgenciaSinConexionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var titlesF = [String]()
    var directionsF = [String]()
    var phonesF = [String]()
    
    let relativeFontWelcomeTitle:CGFloat = 0.045
    let relativeFontButton:CGFloat = 0.060
    let relativeFontCellTitle:CGFloat = 0.023
    let relativeFontCellDescription:CGFloat = 0.015
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("OKKKKKK")
        
        read()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func read()
    {
        
        let mascotasReference = Firestore.firestore().collection("veterinarias")
        mascotasReference.addSnapshotListener { (snapshot,_) in
            
            guard let snapshot = snapshot else { return }
            
            for document in snapshot.documents
            {
                let data = document.data()
                print(data)
                self.titlesF.append(data["nombre"] as! String)
                self.directionsF.append(data["direccion"] as! String)
                self.phonesF.append(data["telefono"] as! String)
            }
        }
    print("x")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titlesF.count
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! UrgenciaSinConexionCollectionViewCell
        
        let cellIndex = indexPath.item
        
        print(titlesF)
        print(directionsF)
        
        cell.name.text = "Nombre: "+self.titlesF[cellIndex]
        cell.direction.text = "Dirección: " + self.directionsF[cellIndex]
        
        cell.tel.text = "Teléfono: " + self.phonesF[cellIndex]
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
        
        return cell
    }

}
