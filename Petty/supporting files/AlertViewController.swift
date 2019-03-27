//
//  AlertViewController.swift
//  Petty
//
//  Created by cecilia Diaz Garcia on 3/20/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    var alertTitle = String()
    
    var alertBody = String()
    
    var actionButtonTitle = String()
    
    var buttonAction: (() -> Void)?
    
    //@IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
        titleLabel.text = alertTitle
        
        bodyLabel.text = alertBody
        
        actionButton.setTitle(actionButtonTitle, for: .normal)
    }
    
    /*
    @IBAction func didTapCancel(_ sender: Any) {
        
        dismiss(animated: true)
    }
    */
    
    
    @IBAction func didTapOk(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
