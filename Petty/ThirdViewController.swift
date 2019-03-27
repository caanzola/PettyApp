//
//  ThirdViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 2/21/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var tipo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    
    @IBAction func listado(_ sender: Any)
    {
        let actionSheet = UIAlertController(title: "Selecciona", message: "¿Qué listado deseas ver?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Mascotas encontradas", style: .default, handler: { (action:UIAlertAction) in
            self.tipo = "encontradas"
             self.performSegue(withIdentifier: "listam", sender: self)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Mascotas perdidas", style: .default, handler: { (action:UIAlertAction) in
            
            self.tipo = "perdidas"
            self.performSegue(withIdentifier: "listam", sender: self)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if self.tipo == "encontradas"
        {
            var vc = segue.destination as! ListaRescateViewController
            vc.tipo = self.tipo
        }
        
        if self.tipo == "perdidas"
        {
            var vc = segue.destination as! ListaRescateViewController
            vc.tipo = self.tipo
        }
        
    }
    
}
