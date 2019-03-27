//
//  VeterinarioUrgenciaViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/18/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit

class VeterinarioUrgenciaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let alert = UIAlertController(title: "Pedido confirmado", message: "Tu pedido ha sido confirmado, en pocos minutos llegará un veterinario experto a la ubicación que seleccionaste y te atenderá.", preferredStyle: .alert)
        let subButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(subButton)
        self.present(alert, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let alert = UIAlertController(title: "Pedido confirmado", message: "Tu pedido ha sido confirmado, en pocos minutos llegará un veterinario experto a la ubicación que seleccionaste y te atenderá.", preferredStyle: .alert)
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
