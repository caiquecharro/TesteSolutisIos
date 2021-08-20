//
//  servicos.swift
//  teste
//
//  Created by caique charro on 18/08/21.
//


import Foundation
import UIKit


protocol LoginResponseDelegate : NSObjectProtocol {
  func resultRequestValidateLogin(result: UserModel)
}

class Services {
    weak var loginResponseDelegate: LoginResponseDelegate?
    
    
    func restLogin(username: String, password: String, delegate: LoginResponseDelegate) {
        
        loginResponseDelegate = delegate
        
        let params = ["username":username, "password":password] as Dictionary<String, String>

        var request = URLRequest(url: URL(string: "https://api.mobile.test.solutis.xyz/login")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                
                var user = UserModel()
                
                if json["message"] != nil {
                    user.mensagem = json["message"] as! String
                }else{
                    user.nome = json["nome"] as! String
                    user.cpf = json["cpf"] as! String
                    user.token = json["token"] as! String
                    user.saldo = (json["saldo"] as! NSNumber).floatValue
                }

                
                self.onResponseLogin(user: user)
                
                
            } catch {
                print("error")
            }
        })
        task.resume()
  
    }
    
    func onResponseLogin(user: UserModel) {
        DispatchQueue.main.async(execute: {
          self.loginResponseDelegate?.resultRequestValidateLogin(result: user)
        })
    }
    
    
    
}
