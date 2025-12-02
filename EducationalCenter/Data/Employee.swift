//
//  Users.swift
//  EducationalCenter
//
//  Created by Mananas on 1/12/25.
//

import Foundation
import FirebaseCore

/* Almacenará la información de todos los empleados y será crucial para los permisos. La clave de cada documento será el UID de Firebase Authentication.*/
struct Employee: Codable
{
    let uid: String //ID único de Firebase Auth
    let name: String //nombre : completo del empleado
    let email: String //email : Correo electrónico usado para iniciar sesión
    let jobEmployee: String //rol que efine el nivel de acceso: director, secretaria, profesor
    let registrationDate: Int64 //fechaContratacion : en la que se registró el empleado - Timestamp
}

/*/ 2. Enum para manejar el Rol de forma segura (opcional, pero recomendado)
    enum JobEmployee: String {
        case headmaster = "director"
        case secretary = "secretaria"
        case teacher = "profesor"
        case unknown // Para manejar casos inesperados o errores
    }
// Propiedad calculada para obtener el Rol de forma fácil en el código
    var rolEnumerado: JobEmployee {
        return JobEmployee(rawValue: jobEmployee) ?? .unknown
    }

// 3. Inicializador para crear el objeto Empleado a partir de datos de Firestore
init?(dictionary: [String: Any]) {
    // Hacemos el casting seguro de los campos. Si falta alguno, la inicialización falla.
    guard let uid = dictionary["uid"] as? String,
          let name = dictionary["name"] as? String,
          let email = dictionary["email"] as? String,
          let job = dictionary["job"] as? String else {
        return nil
    }
    
    self.uid = uid
    self.name = name
    self.email = email
    self.job = job
    
    // Manejo del Timestamp de Firebase
    if let timestamp = dictionary["registrationDate"] as? TimeInterval {
        // Si Firebase nos dio un TimeInterval
        self.fechaContratacion = Date(timeIntervalSince1970: timestamp)
    } else if let firebaseTimestamp = dictionary["registrationDate"] as? Timestamp {
        // Si Firebase nos dio un objeto Timestamp de la librería
        self.fechaContratacion = firebaseTimestamp.dateValue()
    } else {
        self.fechaContratacion = nil
    }
}*/
