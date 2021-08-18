//
//  HomeView.swift
//  teste
//
//  Created by caique charro on 13/06/21.
//

import Foundation
import UIKit

class HomeView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var viewGradiente: UIView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let cellPositiva = tableView.dequeueReusableCell(withIdentifier: "cellPositiva", for: indexPath) as! CellPositiva
            
            
            cellPositiva.update()
            
            return cellPositiva
        }else{
            let cellPositiva = tableView.dequeueReusableCell(withIdentifier: "cellNegativa", for: indexPath) as! CellPositiva
            
            cellPositiva.update()
            return cellPositiva
        }

        
    }
    
    

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let view = self.viewGradiente
        let gradient = CAGradientLayer()

        gradient.frame = view!.bounds
        gradient.colors = [UIColor(red: 177/256, green: 199/256, blue: 228/256, alpha: 1.0).cgColor, UIColor(red: 0/256, green: 116/256, blue: 178/256, alpha: 1.0).cgColor]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)

        view!.layer.insertSublayer(gradient, at: 0)
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableview.reloadData()
        
    }


}
