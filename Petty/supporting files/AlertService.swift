//
//  AlertService.swift
//  Petty
//
//  Created by cecilia Diaz Garcia on 3/21/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit

class AlertService
{
    func alert(title: String, body: String, buttonTitle: String, completion: @escaping () -> Void) -> AlertViewController {
        
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        
        alertVC.alertTitle = title
        
        alertVC.alertBody = body
        
        alertVC.actionButtonTitle = buttonTitle
        
        alertVC.buttonAction = completion
        
        return alertVC
    }
    
}
