
//
//  Player.swift
//  XO
//
//  Created by Nada Alm on 5/11/20.
//  Copyright © 2020 Nada Alm. All rights reserved.
//

import Foundation

enum Player{
    
    case X
    case O
    case none
    
    
    
    func text() -> String{
        switch self{
        case .X: return "X"
              case .O: return "O"
              case .none: return ""
        }
        
    }//func text()
    
    
    
    mutating func toggle(){
        switch self {
        case .X:
            self = .O
        case .O:
           self = .X
        case .none:
            self = .none
            
            
        }
        
        
        
    }
    
    
    
    
    
}//enum
