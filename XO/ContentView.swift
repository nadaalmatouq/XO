//
//  ContentView.swift
//  XO
//
//  Created by Nada Alm on 5/9/20.
//  Copyright © 2020 Nada Alm. All rights reserved.
//

import SwiftUI


struct Field{
    
    var text: String
    var enabled: Bool
    
}


struct ContentView: View {
    
    @State var fields : [[Field]] = .init(repeating: .init(repeating:Field(text: "", enabled: true), count: 3), count: 3)
    @State var currentPlayer: String = "X"
    @State var winner: String = ""
    @State var counter: Int = 0
    
    
    func restartGame() {
    
            //restart
           fields = .init(repeating: .init(repeating:Field(text: "", enabled: true), count: 3), count: 3)
            currentPlayer = "X"
          winner = ""
        counter = 0
               
            
    }
    
    
    
    var body: some View {
        
        
        
        ZStack {
            Image("xo-iphone").resizable().scaledToFill()
           
            
            VStack{
             
                
                Text(winner).foregroundColor(.red).font(.system(size: 50, weight: .bold, design: .rounded)).background(Color.white)
                
                Text("\(currentPlayer) turn").foregroundColor(.black).font(.system(size: 50, weight: .bold, design: .rounded)).background(Color.white).padding(10)
                
                  
                    Grid(fields: $fields, currentPlayer: $currentPlayer, counter: $counter, winner: $winner)
                    
                    
                   
                     
                    if winner != ""{
                        
                        
                        
                        Button(action: {
                              //resatrt
                           
                              
                            self.restartGame()
                              
                              
                          }){
                              
                            Text("Restart Game?").foregroundColor(.blue).font(.system(size: 40, design: .rounded)).shadow(radius: 12).background(Color.white).offset(y:20)
                              
                          }
                        
                    }
                        
                        
                    
                    
                    
            }//VStack
        }.edgesIgnoringSafeArea(.all)//ZStack
        
    }
    
    
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(winner: "")
    }
}



struct Grid: View {
    
    
    
    @Binding var fields : [[Field]]
    @Binding var currentPlayer: String
    @Binding var counter: Int
    @Binding var winner: String
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(0 ..< 3) { r in
                
                HStack(spacing: 20){
                    ForEach(0 ..< 3) { c in
                        
                        XOButton(fields: self.$fields, currentPlayer: self.$currentPlayer, counter: self.$counter, winner: self.$winner, r: r, c: c)
                    }//H forEach
                }//HStack
            }//vertical forEach
        }.offset(x: -7)//Vstack
    }
    
     
    
}

struct XOButton: View {
    
       @Binding var fields : [[Field]]
       @Binding var currentPlayer: String
       @Binding var counter: Int
       @Binding var winner: String
       var r: Int
        var c: Int
    var body: some View {
        Button(action: {
            
            
            
            if self.fields[self.r][self.c].enabled{
                self.fields[self.r][self.c].text = self.currentPlayer
                self.currentPlayer = self.currentPlayer == "X" ? "O" : "X"
                self.fields[self.r][self.c].enabled = false
                
                self.counter += 1
                self.checkWinners()
            }
            
        }){
            
            
            Text(self.fields[r][c].text).frame(width: 100, height: 100).foregroundColor(.white).font(.system(size: 50, weight: .bold, design: .rounded)).background(Color.blue).shadow(radius: 12)
            
            
        }
    }
    
    
    func checkWinners(){
            
            
            func checkWinner(p: String){
            
            let r1 = fields[0][0].text == p && fields[0][1].text == p && fields[0][2].text == p
            let r2 = fields[1][0].text == p && fields[1][1].text == p && fields[1][2].text == p
            let r3 = fields[2][0].text == p && fields[2][1].text == p && fields[2][2].text == p
            
            
            let c1 = fields[0][0].text == p && fields[1][0].text == p && fields[2][0].text == p
            let c2 = fields[0][1].text == p && fields[1][1].text == p && fields[2][1].text == p
            let c3 = fields[0][2].text == p && fields[1][2].text == p && fields[2][2].text == p
                
            let d1 = fields[0][0].text == p && fields[1][1].text == p && fields[2][2].text == p
            let d2 = fields[0][2].text == p && fields[1][1].text == p && fields[2][0].text == p
            
            
            if r1 || r2 || r3 || c1 || c2 || c3 || d1 || d2{
                
                winner = "\(p) wins!!"
                
                
            }
            else if counter == 9{
                
                winner = "Tie!!"
                
                }
                
            }//checkWinner
            checkWinner(p: "X")
            checkWinner(p: "O")
            
            
        }//checkWinners
        
        
    }
}
