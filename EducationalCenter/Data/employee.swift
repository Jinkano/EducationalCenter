//
//  Users.swift
//  EducationalCenter
//
//  Created by Mananas on 1/12/25.
//

import Foundation
import FirebaseCore

/* Almacenará la información de todos los empleados y será crucial para los permisos. La clave de cada documento será el UID de Firebase Authentication.*/
struct employee: Codable
{
    let uid: String //ID único de Firebase Auth
    let email: String //email : Correo electrónico usado para iniciar sesión
    let name: String //nombre : completo del empleado
    let role: String //rol que efine el nivel de acceso: director, secretaria, profesor
    
    
    // 2. Enum para manejar el Rol de forma segura (opcional, pero recomendado)
    enum JobEmployee: String {
        case headmaster = "Director"
        case secretary = "Secretaria"
        case teacher = "Profesor"
        case unknown // Para manejar casos inesperados o errores
    }
    // Propiedad calculada para obtener el Rol de forma fácil en el código
    var jobEmployee: JobEmployee {
        return JobEmployee(rawValue: role) ?? .unknown
    }
    
    // 3. Inicializador para crear el objeto Empleado a partir de datos de Firestore
    init?(dictionary: [String: Any])
    {
        // Hacemos el casting seguro de los campos. Si falta alguno, la inicialización falla.
        guard let uid = dictionary["uid"] as? String,
              let email = dictionary["email"] as? String,
              let name = dictionary["name"] as? String,
              let role = dictionary["role"] as? String else {
            return nil
        }
        
        self.uid = uid
        self.name = name
        self.email = email
        self.role = role
        
    }
}
