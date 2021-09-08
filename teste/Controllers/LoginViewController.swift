//
//  LoginViewController.swift
//  teste
//
//  Created by caique charro on 12/06/21.
//

import UIKit
import KeychainSwift
import SVProgressHUD
import LocalAuthentication


class LoginViewController: UIViewController , LoginResponseDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var swtSaveUser: UISwitch!
    @IBOutlet weak var swtBiometri: UISwitch!
    @IBOutlet weak var lblValidator: UILabel!
    
    var uiColorGreenPool = UIColor(red: 0.01, green: 0.79, blue: 0.86, alpha: 1.0)
    var uiColorRedAlert = UIColor(red: 0.93, green: 0.38, blue: 0.29, alpha: 1.0)
    
    var username: String?
    var password: String?
    
    var isAutoLogin: Bool = false
    var isBiometry: Bool = false
    
    var user: UserModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.btnLogin.layer.cornerRadius = self.btnLogin.frame.width/8.0
        self.btnLogin.layer.masksToBounds = true
        self.lblValidator.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupLogin()
        
    }
    
    
    func setupLogin(){
        
        self.txtUser.text = ""
        self.txtPassword.text = ""
        
        let keychain = KeychainSwift()
        
        if keychain.get("lembrarBiometria") != nil {
            
            swtBiometri.isOn = true
            swtSaveUser.isOn = true

            self.biometriaUsuario()

        }
        
        if keychain.get("lembrarUsuario") != nil{
            swtSaveUser.isOn = true
            self.txtUser.text = keychain.get("userName")
            
        }
        
    }
    
    func biometriaUsuario(){
        
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self!.isBiometry = true
                        self!.doLogin()
                    } else {
                        // error
                        self!.isBiometry = false
                        
                    }
                }
            }
        } else {
            
            self.isBiometry = false
            
        }
        
    }
    
    @IBAction func clickLogin(_ sender: Any) {
        SVProgressHUD.show()
        self.validations()
        
    }
    
    @IBAction func resetFields(_ sender: UITextField) {
        if sender == txtUser {
            txtUser.layer.borderColor = uiColorGreenPool.cgColor
            txtUser.textColor = UIColor.black
        }
        if sender == txtPassword {
            txtPassword.layer.borderColor = uiColorGreenPool.cgColor
            txtPassword.textColor = UIColor.black
        }
        
    }
    
    func validations() -> Bool {
        var mensagem: String? = nil
            if (txtUser.text == nil) || (txtUser.text == "") {
                mensagem = NSLocalizedString("Email Obrigatório", comment: "")
                txtUser.layer.borderColor = uiColorRedAlert.cgColor
                txtUser.textColor = uiColorRedAlert
            }else if !Utils().isValidEmail(txtUser.text!) {
                mensagem = "Email Inválido"
                txtUser.layer.borderColor = uiColorRedAlert.cgColor
                txtUser.textColor = uiColorRedAlert
            } else if (txtPassword.text == nil) || (txtPassword.text == "") {
                txtPassword.layer.borderColor = uiColorRedAlert.cgColor
                txtPassword.textColor = uiColorRedAlert
                mensagem = NSLocalizedString("Senha Obrigatória", comment: "")
            } else if (txtPassword.text!.count < 4) {
                txtPassword.layer.borderColor = uiColorRedAlert.cgColor
                txtPassword.textColor = uiColorRedAlert
                mensagem = NSLocalizedString("Senha Precisa ter mais que 4 digítos", comment: "")
            }else if !Utils().isValidPassword(txtPassword.text!) {
                mensagem = "Senha Inválida"
                txtPassword.layer.borderColor = uiColorRedAlert.cgColor
                txtPassword.textColor = uiColorRedAlert
            }
 
        if let mensagem = mensagem {
            
            let alert = UIAlertController(title: "Alert", message: mensagem, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
            self.present(alert, animated: true, completion: nil)
            
            return false
        }else{
            
            self.doLogin()
            
            return true
        }

    }
    
    func doLogin(){
        
        
        var keychain = KeychainSwift()
        
        self.username = self.txtUser.text
        self.password = self.txtPassword.text
        
        if keychain.get("lembrarBiometria") != nil{
            
            
            self.username = keychain.get("userName")
            self.password = keychain.get("userPassword")
            
        }
        
        Services().restLogin(username: self.username!, password: self.password!, delegate: self)

    }
    
    @IBAction func saveUser(_ sender: Any) {
        
        if swtSaveUser.isOn {
            
            let alert = UIAlertController(title: "Alert", message: "O usuario sera lembrado", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.isAutoLogin = true
            }))
            self.present(alert, animated: true, completion: nil)
            
 
            
        }else{
            self.isAutoLogin = false
            let keychain = KeychainSwift()
            
            keychain.delete("userName")
            keychain.delete("lembrarUsuario")
            keychain.delete("userPassword")
            keychain.delete("lembrarBiometria")
            
        }
        
    }
    
    @IBAction func saveBiometrics(_ sender: Any) {
        
        if swtBiometri.isOn{
            
            if swtSaveUser.isOn{
                
                var refreshAlert = UIAlertController(title: "Alerta", message: "No proximo login sera necessario biometria", preferredStyle: .alert)

                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [self] (action: UIAlertAction!) in
                    self.isBiometry = true
                  }))

                present(refreshAlert, animated: true, completion: nil)
                                
            }else{
                
                var refreshAlert = UIAlertController(title: "Alerta", message: "Para usar biometria o lembrar usuario sera habilitado", preferredStyle: .alert)

                refreshAlert.addAction(UIAlertAction(title: "Aceitar", style: .default, handler: { (action: UIAlertAction!) in
                    self.swtSaveUser.isOn = true
                    self.isAutoLogin = true
                    self.isBiometry = true
                  }))

                refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {(action: UIAlertAction!) in
                    self.swtBiometri.isOn = false
                    self.isAutoLogin = false
                    self.isBiometry = false
                  }))

                present(refreshAlert, animated: true, completion: nil)
                
            }
            
        }else{
            
            self.isAutoLogin = false
            self.isBiometry = false
            
            let keychain = KeychainSwift()

            keychain.delete("userPassword")
            keychain.delete("lembrarBiometria")
            
        }
        
    }
    
    
    func resultRequestValidateLogin(result: UserModel) {
        
        SVProgressHUD.dismiss()
        
        if result.mensagem != ""{
            
            let alert = UIAlertController(title: "Alert", message: result.mensagem, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
            self.present(alert, animated: true, completion: nil)
        }else{
            let keychain = KeychainSwift()
            self.user = result
            
            if swtSaveUser.isOn{
                
                keychain.set(self.txtUser.text!, forKey: "userName")
                keychain.set(true, forKey: "lembrarUsuario")
                
                if swtBiometri.isOn {

                    keychain.set(self.txtPassword.text!, forKey: "userPassword")
                    keychain.set(true, forKey: "lembrarBiometria")
                    
                    
                }else{
                    keychain.delete("userPassword")
                    keychain.delete("lembrarBiometria")
                    
                }
            }else{
                
                keychain.delete("userName")
                keychain.delete("lembrarUsuario")
                
            }
            
            performSegue(withIdentifier: "LoginToMenu", sender: self)
            
        }
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "LoginToMenu" {
            let home = segue.destination as? HomeView
            home?.user = self.user
        }
        
    }
    
}
