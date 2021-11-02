//
//  RegisterVC.swift
//  MessengerClone
//
//  Created by Rodrigo Leyva on 10/28/21.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var imageButton: UIButton!
    //MARK: - Variables
    
    var selectedProfileImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty, password.count >= 6, let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let profileImage = selectedProfileImage else {
            
            // alert user
            alertUser(message: "Don't leave any fields empty, please select a profile image, and password must be longer than 6 characters.")
            return
        }
        let user = ChatAppUser(firstName: firstName, lastName: lastName, email: email)
        
        Auth.auth().createUser(withEmail: user.email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error{
                self?.alertUser(message: error.localizedDescription)
                return
            }
            
            
            DatabaseManager.shared.createUser(user: user)
            
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        
        
        
        
        
        
    }
    
    func alertUser(message: String){
        let alert = UIAlertController(title: "Whoops", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func imagePressed(_ sender: Any) {
        presentImagePickerActionSheet()
    }
    
}

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentImagePickerActionSheet(){
        
        let alertSheet = UIAlertController(title: "Select profile image", message: "How would you like to select image?", preferredStyle: .actionSheet)
        
        alertSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            
            self?.presentCamera()
        }))
        
        alertSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in
            
            self?.presentLibrary()
            
        }))
        
        present(alertSheet, animated: true, completion: nil)
        
        
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func presentLibrary(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.selectedProfileImage = selectedImage
        
        imageButton.setBackgroundImage(nil, for: .normal)
        imageButton.setImage(selectedImage, for: .normal)
        imageButton.imageView?.layer.cornerRadius = 70.0
        imageButton.imageView?.layer.borderWidth = 2
        imageButton.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        
        picker.dismiss(animated: true, completion: nil)
        
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
