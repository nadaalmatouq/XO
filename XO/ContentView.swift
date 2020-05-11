//
//  ContentView.swift
//  XO
//
//  Created by Nada Alm on 5/9/20.
//  Copyright © 2020 Nada Alm. All rights reserved.
//

import SwiftUI


class Env: ObservableObject{
    
    @Published var fields : [[Field]] = .init(repeating: .init(repeating:Field(text: "", enabled: true), count: 3), count: 3)
    @Published var currentPlayer: String = "X"
    @Published var winner: String = ""
    @Published var counter: Int = 0
    
    
    
    func restartGame() {
    
            //restart
           fields = .init(repeating: .init(repeating:Field(text: "", enabled: true), count: 3), count: 3)
            currentPlayer = "X"
          winner = ""
        counter = 0
               
            
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
               else if counter == 9 && winner == ""{
                   
                   winner = "Tie!!"
                   
                   }
                   
               }//checkWinner
               checkWinner(p: "X")
               checkWinner(p: "O")
               
               
           }//checkWinners
    
    
    func buttonAction(r: Int,c: Int){
        
        if fields[r][c].enabled{
                       fields[r][c].text = currentPlayer
                       currentPlayer = currentPlayer == "X" ? "O" : "X"
                       fields[r][c].enabled = false
                       
                       counter += 1
            checkWinners()
    }
    
    }//end func buttonAction
    
}//End Class Env

struct Field{
    
    var text: String
    var enabled: Bool
    
}


struct ContentView: View {
    
 @EnvironmentObject var env: Env  //instead of @Binding we put @EnvironmentObject to do binding for the whole Env class
    
    var body: some View {
        
        
        
        ZStack {
            Image("xo-iphone").resizable().scaledToFill()
           
            
            VStack{
             
                
                Text(env.winner).foregroundColor(.red).font(.system(size: 50, weight: .bold, design: .rounded)).background(Color.white)
                
                Text("\(env.currentPlayer) turn").foregroundColor(.black).font(.system(size: 50, weight: .bold, design: .rounded)).background(Color.white).padding(10)
                
                  
                Grid()
                    
                    
                   
                     
                    if env.winner != ""{
                        Button(action: {
                              //restart
                            self.env.restartGame()
                          }){
                              
                            Text("Restart Game?").foregroundColor(.blue).font(.system(size: 40, design: .rounded)).shadow(radius: 12).background(Color.white).offset(y:2)
                              
                          }
                        
                    }
                       
            }//VStack
        }.edgesIgnoringSafeArea(.all)//ZStack
        
    }
    
    
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Env())
    }
}



struct Grid: View {
    
    @EnvironmentObject var env: Env
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(0 ..< 3) { r in
                
                HStack(spacing: 20){
                    ForEach(0 ..< 3) { c in
                        
                        XOButton(r: r, c: c)
                    }//H forEach
                }//HStack
            }//vertical forEach
        }.offset(x: -7)//Vstack
    }
    
     
    
}

struct XOButton: View {
    
    @EnvironmentObject var env: Env
       var r: Int
        var c: Int
    var body: some View {
        
        Button(action: {
            
            self.env.buttonAction(r: self.r,c: self.c)
           
        
            
        }){
            
            
            Text(self.env.fields[r][c].text).frame(width: 100, height: 100).foregroundColor(.white).font(.system(size: 50, weight: .bold, design: .rounded)).background(Color.blue).shadow(radius: 12)
            
            
        }
    }
    
    
   
        
        
    }
}


