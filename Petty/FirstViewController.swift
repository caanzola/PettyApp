//
//  FirstViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 2/21/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class FirstViewController: UIViewController {
    
    let alertService = AlertService()
    
    let network: NetworkManager = NetworkManager.sharedInstance
    
    // maneja la alerta de en progreso

    @IBOutlet weak var alertButton: UIButton!

    
    @IBAction func didTapAlert() {
        
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
        
    }
    
    // servico baño
    
    @IBOutlet weak var servicioBañoButton: UIButton!
    @IBAction func didTapServicioBaño() {
        
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
    }
    // servicio paseador
    
    @IBOutlet weak var servicioPaseadorButton: UIButton!
    @IBAction func didTapServicioPaseador() {
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
    }
    
    // servicio funeraria
    
    
    @IBOutlet weak var servicioFunerariaButton: UIButton!
    @IBAction func didTapServicioFuneraria() {
        
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
    }
    
    // partos y esterilizacion
    
    @IBOutlet weak var servicioPartosButton: UIButton!
    
    @IBAction func didTapServicioPartos() {
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
        
    }
    // desparasitacion
    
    
    @IBOutlet weak var servicioDesparasitacionButton: UIButton!
    
    @IBAction func didTapServicioDesparasitacion() {
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
    }
    
    // aqui termina todo lo del manejo de la alerta
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetworkManager.isUnreachable { _ in
            showOfflinePage()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        
        let mascotasReference = Firestore.firestore().collection("mascotas")
        
        
        //let parameters: [String: Any] = ["nombre":"Canela", "edad":"5 meses","peso":"4 kg", "raza":"Coker spaniel"]
        
        //mascotasReference.addDocument(data: parameters)
        
        mascotasReference.addSnapshotListener { (snapshot,_) in
            
            guard let snapshot = snapshot else { return }
            
            //print(snapshot.documents.isEmpty)
            
            //for document in snapshot.documents
            //{
              //  print(document.data())
            //}
            
                if snapshot.documents.isEmpty
                {
                let alert = UIAlertController(title: "Bienvenido", message: "Aún no tienes ninguna mascota registrada. Por favor agrega tus mascotas para poder acceder a todos nuestros servicios.", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: registrarMascota)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
                }
            }
            /*else
            {
                let alert = UIAlertController(title: "Atencion", message: "Ahora si ya tienes mascotas", preferredStyle: .alert)
                let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(subButton)
                self.present(alert, animated: true, completion: nil)
            }*/
            
        
        }
        /*
        func showOfflinePage() -> Void {
            DispatchQueue.main.async {
                self.performSegue(
                    withIdentifier: "NetworkUnavailable",
                    sender: self
                )
            }
        }
        */
        func showOfflinePage() {
            let alertVC = alertService.alert(title: "No hay conexion a internet ", body: "Revisa tu conexión de internet para tener acceso a todos nuestros servicios ", buttonTitle: "Entendido") {
                
            }
            
            present(alertVC, animated: true)
        }
    
        func registrarMascota(alert: UIAlertAction)
        {
            print(" ")
            print(" -------------------- ")
            print(" ")
        
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let x = storyBoard.instantiateViewController(withIdentifier: "create") as! CreatePetViewController
            //self.present(x, animated: true, completion: nil)
            self.navigationController?.pushViewController(x, animated: true)
        }
    }
    
    

    
}

