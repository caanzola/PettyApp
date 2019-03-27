//
//  PreguntaSiHayMascotasViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/22/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class PreguntaSiHayMascotasViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let mascotasReference = Firestore.firestore().collection("mascotas")
        
        mascotasReference.addSnapshotListener { (snapshot,_) in
            
            guard let snapshot = snapshot else { return }
            
            if snapshot.documents.isEmpty
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let x = storyBoard.instantiateViewController(withIdentifier: "noHay") as! NoHayMascotasViewController
                self.navigationController?.pushViewController(x, animated: true)
                
                //self.present(x, animated: true, completion: nil)
            }
            else
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let x = storyBoard.instantiateViewController(withIdentifier: "siHay") as! ListaMascotasViewController
                self.navigationController?.pushViewController(x, animated: true)
                
                //self.present(x, animated: true, completion: nil)
            }
            
        }
        
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
