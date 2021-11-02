//
//  ViewController.swift
//  MessengerClone
//
//  Created by Rodrigo Leyva on 10/28/21.
//

import UIKit
import FirebaseAuth

class ConversationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser == nil {
            // present login view controller
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    @IBAction func logoutPressed(_ sender: Any) {
        
        
        do{
            try Auth.auth().signOut()
            
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        
            
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    


}

