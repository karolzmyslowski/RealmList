//
//  AlertService.swift
//  Realm
//
//  Created by Karol Zmyslowski on 19.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class AlertService {
    
    private init() {}
    
    static func addAlert(in vc: UIViewController, completion: @escaping (String, Int?, String? ) -> Void){
        let alert = UIAlertController(title: "Add Line", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTF) in
            lineTF.placeholder = "Enter Line"
        }
        alert.addTextField { (scoreTF) in
            scoreTF.placeholder = "Enter Score"
        }
        alert.addTextField { (emailTF) in
            emailTF.placeholder = "Enter Email"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
            let scoreString = alert.textFields?[1].text,
            let emailString = alert.textFields?.last?.text
                else {return}
            
            let score = scoreString == "" ? nil : Int(scoreString)
            let email = emailString == "" ? nil : emailString
            
            completion(line, score, email)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func updateAlert(in vc: UIViewController, line: Any, completion: @escaping(String, Int?, String?) -> Void) {
        let alert = UIAlertController(title: "Update Line", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTF) in
            lineTF.placeholder = "Enter Line"
            lineTF.text = ""
        }
        alert.addTextField { (scoreTF) in
            scoreTF.placeholder = "Enter Score"
            scoreTF.text = ""
        }
        alert.addTextField { (emailTF) in
            emailTF.placeholder = "Enter Email"
            emailTF.text = ""
        }
        let action = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
                let scoreString = alert.textFields?[1].text,
                let emailString = alert.textFields?.last?.text
                else {return}
        
            let score = scoreString == "" ? nil : Int(scoreString)
            let email = emailString == "" ? nil : emailString
        
         completion(line, score, email)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}
