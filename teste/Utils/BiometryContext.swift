//
//  BiometryContext.swift
//  teste
//
//  Created by caique charro on 18/08/21.
//

import LocalAuthentication
import KeychainSwift

class BiometryContext {
    
    var context: LAContext?
    
    static let sharedInstanceVar: BiometryContext? = {
        var sharedInstance = BiometryContext()
        sharedInstance.context = LAContext()
        return sharedInstance
    }()

    class func sharedInstance() -> Self {
        return sharedInstanceVar! as! Self
    }
    
    func saveEncryptedData() {
        
        let encryptedStorage = KeychainSwift()
        encryptedStorage.set(true, forKey: "isBiometry")
        

    }

    func fetchDecryptedData() -> [AnyHashable : Any]? {

        return nil
    }

    func deleteEncryptedData() {
        
        let encryptedStorage = KeychainSwift()
        encryptedStorage.delete("isBiometry")
        

    }
}



extension LAContext {
    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }

    var biometricType: BiometricType {
        var error: NSError?

        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }

        if #available(iOS 11.0, *) {
            switch self.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            @unknown default:
                #warning("Handle new Biometric type")
            }
        }
        
        return  self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
    }
}
