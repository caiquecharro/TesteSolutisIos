//
//  LoginViewController.swift
//  teste
//
//  Created by caique charro on 12/06/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.btnLogin.layer.cornerRadius = self.btnLogin.frame.width/8.0
        self.btnLogin.layer.masksToBounds = true
        
        
    }

    @IBAction func clickLogin(_ sender: Any) {
        
        let vc = HomeView() //your view controller
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    func validations(){
        
    }
    
    
    
    func doLogin(){
        
        
        
        
        
    }
    
}

