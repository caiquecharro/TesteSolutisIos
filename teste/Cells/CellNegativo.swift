//
//  CellNegativo.swift
//  teste
//
//  Created by caique charro on 01/09/21.
//

import Foundation
import UIKit


class CellNegativa : UITableViewCell {
    
    

    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var shadowLayer: UIView!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblValor: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    
    func update(statement: StatementsResponse!){
        
        setCard()
        
        self.lblDesc.text = statement.descricao
        self.lblDate.text = Utils.formattedDate(dateString: statement.data!)
        self.lblValor.text = Utils.formattedValue(valor: statement.valor!)
        
    }
    
    func setCard() {
        
        if mainBackground != nil {
            
            self.mainBackground.layer.cornerRadius = self.mainBackground.frame.width/35.0
            self.mainBackground.layer.masksToBounds = true
            
            self.shadowLayer.layer.cornerRadius = self.shadowLayer.frame.width/35.0
            self.shadowLayer.layer.masksToBounds = true
            
        }
        
    }
    
}

