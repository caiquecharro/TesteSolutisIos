//
//  cellPositiva.swift
//  teste
//
//  Created by caique charro on 13/06/21.
//

import Foundation
import UIKit


class CellPositiva : UITableViewCell {
    
    
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var mainBackground2: UIView!
    
    @IBOutlet weak var shadowLayer: UIView!
    @IBOutlet weak var shadowLayer2: UIView!

    
    func update(){
        
        
        if mainBackground != nil {
            
            self.mainBackground.layer.cornerRadius = self.mainBackground.frame.width/35.0
            self.mainBackground.layer.masksToBounds = true
            
            self.shadowLayer.layer.cornerRadius = self.shadowLayer.frame.width/35.0
            self.shadowLayer.layer.masksToBounds = true
            
        }
        
        if mainBackground2 != nil{
            
            self.mainBackground2.layer.cornerRadius = self.mainBackground2.frame.width/35.0
            self.mainBackground2.layer.masksToBounds = true
            
            self.shadowLayer2.layer.cornerRadius = self.shadowLayer2.frame.width/35.0
            self.shadowLayer2.layer.masksToBounds = true
            
        }

        

    }
    
    
    
    
    
    
    
}
