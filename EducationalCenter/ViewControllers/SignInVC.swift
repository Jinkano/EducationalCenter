//
//  ViewController.swift
//  EducationalCenter
//
//  Created by Mananas on 1/12/25.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController
{
    /**/
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    /**/
    @IBAction func signIn(_ sender: Any)
    {
        let email = tfUserName.text ?? ""
        let password = tfPassword.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { [unowned self] authResult, error in
            if let error = error {
                print(error.localizedDescription)
                self.showMessage(message: error.localizedDescription)
                return
            }
            
            print("User signed in successfully")
            
            /* Si las credenciales son correctas mostramos el ViewController.
             * El 'segue' se llama "NavigateToHome" que se le asigna en el inspector de atributos.
             *
            self.performSegue(withIdentifier: "NavigateToHome", sender: nil)*/
        }
        
    }
    
    /**/
    @IBAction func signUp(_ sender: Any)
    {
        let email = tfUserName.text ?? ""
        let password = tfPassword.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("User create account successfully")
            
            /* Si las credenciales son correctas mostramos el ViewController.
             * El 'segue' se llama "NavigateToHome" que se le asigna en el inspector de atributos.
             *
            self.performSegue(withIdentifier: "NavigateToHome", sender: nil)*/
        }
    }
}

