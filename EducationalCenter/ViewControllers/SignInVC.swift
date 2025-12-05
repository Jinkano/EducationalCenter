//
//  ViewController.swift
//  EducationalCenter
//
//  Created by Mananas on 1/12/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignInVC: UIViewController
{
    /**/
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    /**/
    @IBAction func signIn(_ sender: Any)
    {
        let email = tfUserName.text ?? ""
        let password = tfPassword.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { [unowned self] authResult, error in
            if let error = error
            {
                print(error.localizedDescription)
                self.showMessage(message: error.localizedDescription)
                return
            }
            
            print("Datos correctos")
            
            // 1. Captura el ID de usuario (UID)
            guard let user = authResult?.user else
            {
                print("Error: No se encontró el objeto de usuario.")
                return
            }
            
            let uid = user.uid
            print("UID del usuario autenticado: \(uid)")
            
            // 2. Utiliza el UID para buscar los datos en Firestore
            self.getFirestoreData(uid: uid)
        }
    }
    
    /**/
    func goToViewController(role: String)
    {
        switch role
        {
        case "Director":
            // Navegar a la vista principal del Director
            self.performSegue(withIdentifier: "GoTo VC Headmaster", sender: nil)
        case "Secretaria":
            // Navegar a la vista principal de la Secretaría
            self.performSegue(withIdentifier: "GoTo VC Secretary", sender: nil)
        case "Profesor":
            // Navegar a la vista principal del Profesor
            self.performSegue(withIdentifier: "GoTo VC Teacher", sender: nil)
        case "Alumno":
            // Navegar a la vista principal del Alumno
            self.performSegue(withIdentifier: "ShowStudentView", sender: nil)
        default:
            self.showMessage(message: "Rol de usuario desconocido.")
        }
    }


    /**/
    func getFirestoreData(uid: String)
    {
        let db = Firestore.firestore()
        
        // 1. Consulta el documento de perfil usando el UID como ID del documento
            db.collection("employee").document(uid).getDocument { [weak self] document, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error al obtener el documento de Firestore: \(error.localizedDescription)")
                    self.showMessage(message: "Error al cargar perfil.")
                    return
                }

                // 2. Extrae el campo 'role'
                guard let document = document, document.exists,
                      let userData = document.data(),
                      let role = userData["role"] as? String else {
                    
                    self.showMessage(message: "Perfil de empleado incompleto o no encontrado.")
                    // Opcional: Cerrar sesión Auth si no hay perfil en DB
                    // try? Auth.auth().signOut()
                    return
                }

                print("Rol del usuario: \(role)")
                
                // 3. Llama a la función de navegación con el rol obtenido
                self.goToViewController(role: role)
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

