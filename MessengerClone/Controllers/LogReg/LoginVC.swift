//
//  LoginVC.swift
//  MessengerClone
//
//  Created by Rodrigo Leyva on 10/28/21.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    

    @IBAction func facebookLoginPressed(_ sender: Any) {
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            
            // alert user
            alertUser(message: "Don't leave any fields empty and password must be longer and 6 characters.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
                
            }
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let authResult = authResult else {return}
            print(authResult.user.email)
            
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    func alertUser(message: String){
        let alert = UIAlertController(title: "Whoops", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func googleLoginPressed(_ sender: Any) {
    }
    

}
