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

protocol StatementsResponseDelegate : NSObjectProtocol {
  func resultRequestValidateStatement(result: [StatementsResponse])
}

class Services {
    
    weak var loginResponseDelegate: LoginResponseDelegate?
    weak var statementsResponseDelegate: StatementsResponseDelegate?
    
    
    // MARK: - Servicos Login
    
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
                    user.saldo = (json["saldo"] as! NSNumber).doubleValue
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
    
    // MARK: - Servicos extrato
    
    func restStatement(token: String, delegate: StatementsResponseDelegate) {
        
        statementsResponseDelegate = delegate
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: URL(string: "https://api.mobile.test.solutis.xyz/extrato")!)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "token")
        request.httpMethod = "GET"

        
        let task = session.dataTask(with: request) { data, response, error
            in
            print(response!)
            do {
                
                let extractData = try JSONDecoder().decode([StatementsResponse].self, from: data!)
                var extractList: [StatementsResponse] = []
                
                for item in extractData {
                    
                    let response = StatementsResponse()
                    response.descricao = item.descricao
                    response.data = item.data
                    response.valor = item.valor
                    
                    extractList.append(response)
                }
                
                self.onResponseStatement(listStatements: extractList)
                
                
            } catch {
                print("error")
            }
        }
        task.resume()
  
    }
    
    func onResponseStatement(listStatements: [StatementsResponse]) {
        DispatchQueue.main.async(execute: {
          self.statementsResponseDelegate?.resultRequestValidateStatement(result: listStatements)
        })
    }
    
    
    
}
