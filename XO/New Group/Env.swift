//
//  Env.swift
//  XO
//
//  Created by Nada Alm on 5/11/20.
//  Copyright © 2020 Nada Alm. All rights reserved.
//

import Foundation

class Env: ObservableObject{
    
    @Published var fields : [[Field]] = .init(repeating: .init(repeating:Field(player: .none, enabled: true), count: 3), count: 3)
    @Published var currentPlayer: Player = .X
    @Published var winner: String = ""
    @Published var counter: Int = 0
    
    
    
    func restartGame() {
    
            //restart
           fields = .init(repeating: .init(repeating:Field(player: .none, enabled: true), count: 3), count: 3)
        currentPlayer = .X
          winner = ""
        counter = 0
               
            
    }
    
    
    
    
    func checkWinners(){
               
               
               func checkWinner(p: Player){
               let c = (p , p , p)
               let r1 = (fields[0][0].player , fields[0][1].player , fields[0][2].player) == c
               let r2 = (fields[1][0].player , fields[1][1].player , fields[1][2].player) == c
               let r3 = (fields[2][0].player , fields[2][1].player , fields[2][2].player) == c
                
                
               let c1 = (fields[0][0].player , fields[1][0].player , fields[2][0].player) == c
               let c2 = (fields[0][1].player , fields[1][1].player , fields[2][1].player) == c
               let c3 = (fields[0][2].player , fields[1][2].player , fields[2][2].player) == c
                    
               let d1 = (fields[0][0].player , fields[1][1].player , fields[2][2].player) == c
               let d2 = (fields[0][2].player , fields[1][1].player , fields[2][0].player) == c
               
               
               if r1 || r2 || r3 || c1 || c2 || c3 || d1 || d2{
                   
                   winner = "\(p) wins!!"
                   
                   
               }
               else if counter == 9 && winner == ""{
                   
                   winner = "Tie!!"
                   
                   }
                   
               }//checkWinner
        checkWinner(p: .X)
        checkWinner(p: .O)
               
               
           }//checkWinners
    
    
    func buttonAction(r: Int,c: Int){
        
        if fields[r][c].enabled{
            fields[r][c].player = currentPlayer
            currentPlayer.toggle()
                       fields[r][c].enabled = false
                       
                       counter += 1
            checkWinners()
    }
    
    }//end func buttonAction
    
}//End Class Env
