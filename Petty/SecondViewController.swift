//
//  SecondViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 2/21/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var tipo: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.view.backgroundColor = UIColor(red: 239/225, green: 226/225, blue: 111/225, alpha: 1)
    }


    @IBAction func alimento(_ sender: Any)
    {
        self.tipo = "alimento"
        performSegue(withIdentifier: "productos", sender: self)
        
    }
    
    @IBAction func medicamentos(_ sender: Any)
    {
        self.tipo = "medicamentos"
        performSegue(withIdentifier: "productos", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
     {
        var vc = segue.destination as! CollectionViewController
        vc.tipo = self.tipo
     }
    
    let alertService = AlertService()
    
    // todo lo de juguetes
    @IBOutlet weak var juguetesButton: UIButton!
    
    @IBAction func didTapJuguetes() {
        
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
    }
    
    // todo lo de casas
    
    
    @IBOutlet weak var casasButton: UIButton!
    
    @IBAction func didTapCasas() {
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
    }
    
    
    // todo lo de collares
    
    @IBOutlet weak var collaresButton: UIButton!
    
    @IBAction func didTapCollares() {
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
    }
    
    // todo lo de snacks
    
    @IBOutlet weak var snacksButton: UIButton!
    
    
    @IBAction func didTapSnacks() {
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
    }
    
    // todo lo de accesorios
    
    
    @IBOutlet weak var accesoriosButton: UIButton!
    
    @IBAction func didTapAccesorios() {
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
        
    }
    
    // todo lo de otros
    
    
    @IBAction func didTapOtros() {
        let alertVC = alertService.alert(title: "Petty esta en proceso de desarrollo", body: "Seguimos trabajando para brindarte todos nuestros servicios, próximamente podrás acceder a este servicio", buttonTitle: "Entendido") {
            
        }
        
        present(alertVC, animated: true)
        
    }
    
    
    @IBOutlet weak var otrosButton: UIButton!
    
    
}

