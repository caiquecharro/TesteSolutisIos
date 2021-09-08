//
//  HomeView.swift
//  teste
//
//  Created by caique charro on 13/06/21.
//

import Foundation
import UIKit
import SVProgressHUD

class HomeView: UIViewController, UITableViewDelegate, UITableViewDataSource, StatementsResponseDelegate {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var viewGradiente: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCpf: UILabel!
    @IBOutlet weak var lblSaldo: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLogout: UIButton!
    
    var user : UserModel?
    var statementList: [StatementsResponse] = [StatementsResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradient()
       
        
        self.lblName.text = user!.nome
        self.lblCpf.text = user!.cpf
        self.lblSaldo.text = Utils.formattedValue(valor: user!.saldo)
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableview.reloadData()
        
        self.lblCpf.text = Utils.formatCPF(user!.cpf)
        serviceStatements()
        
    }
    
    func setGradient(){
        
        let view = self.viewGradiente
        let gradient = CAGradientLayer()

        gradient.frame = view!.bounds
        gradient.colors = [UIColor(red: 177/256, green: 199/256, blue: 228/256, alpha: 1.0).cgColor, UIColor(red: 0/256, green: 116/256, blue: 178/256, alpha: 1.0).cgColor]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        view!.layer.insertSublayer(gradient, at: 0)
  
    }
    
    func serviceStatements(){
        
        SVProgressHUD.show()
        Services().restStatement(token: user!.token, delegate: self)
        
    }
    
    func resultRequestValidateStatement(result: [StatementsResponse]) {
        
        SVProgressHUD.dismiss()
        
        self.statementList = result
        self.tableview.reloadData()
        
    }
    
    @IBAction func clickLogout(_ sender: Any) {
        
        var refreshAlert = UIAlertController(title: "Alerta", message: "Deseja realmente sair ?", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (action: UIAlertAction!) in
            
            self.dismiss(animated: false, completion: nil)
            
          }))

        refreshAlert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: {(action: UIAlertAction!) in

            
          }))

        present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if statementList.count > 0{
            return statementList.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if statementList[indexPath.item].valor! >= 0 {
            
            let cellPositiva = tableView.dequeueReusableCell(withIdentifier: "cellPositiva", for: indexPath) as! CellPositiva
            
            cellPositiva.update(statement: statementList[indexPath.item])
            
            return cellPositiva
            
        }else{
            
            let cellNegativa = tableView.dequeueReusableCell(withIdentifier: "cellNegativa", for: indexPath) as! CellNegativa
            
            cellNegativa.update(statement: statementList[indexPath.item])
            
            return cellNegativa
        }
        
    }

}
