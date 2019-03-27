//
//  ProcessingUrgenciaViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 3/21/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ProcessingUrgenciaViewController: UIViewController {

    var descriptionn = ""
    var lat = ""
    var long = ""
    var urlDownload: URL!
    
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            print(" ")
            print("xxxxxxxxxxxxxx ")
            print(self.urlDownload.absoluteString)
            print(" ")
            print(" ")
            let urgenciasReference = Firestore.firestore().collection("urgencias")
            let parameters: [String: Any] = ["description":self.descriptionn, "latittude":self.lat, "longitude": self.long, "urlImage":self.urlDownload.absoluteString]
            urgenciasReference.addDocument(data: parameters)
            
            
            
            
            self.loadingIcon.stopAnimating()
            self.loadingIcon.hidesWhenStopped = true
            
            super.viewDidAppear(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let x = storyBoard.instantiateViewController(withIdentifier: "confirm") as! VeterinarioUrgenciaViewController
            //self.navigationController?.pushViewController(x, animated: true)
            self.present(x, animated: true, completion: nil)
            
            
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
