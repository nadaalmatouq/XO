//
//  ContentView.swift
//  XO
//
//  Created by Nada Alm on 5/9/20.
//  Copyright © 2020 Nada Alm. All rights reserved.
//

import SwiftUI



struct Field{
    
    var player: Player
    var enabled: Bool
    
}


struct ContentView: View {
    
 @EnvironmentObject var env: Env  //instead of @Binding we put @EnvironmentObject to do binding for the whole Env class
    
    var body: some View {
        
        
        
        ZStack {
            Image("xo-iphone").resizable().scaledToFill()
           
            
            VStack{
             
                
                Text(env.winner).foregroundColor(.red).font(.system(size: 50, weight: .bold, design: .rounded)).background(Color.white)
                
                Text("\(env.currentPlayer.text()) turn").foregroundColor(.black).font(.system(size: 50, weight: .bold, design: .rounded)).background(Color.white).padding(10)
                
                  
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
            
            
            Text(self.env.fields[r][c].player.text()).frame(width: 100, height: 100).foregroundColor(.white).font(.system(size: 50, weight: .bold, design: .rounded)).background(Color.blue).shadow(radius: 12)
            
            
        }
    }
    
    
   
        
        
    }
}


