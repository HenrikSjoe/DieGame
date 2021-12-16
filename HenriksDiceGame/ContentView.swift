//
//  ContentView.swift
//  HenriksDiceGame
//
//  Created by Henrik Sjögren on 2021-12-16.
//

import SwiftUI

struct ContentView: View {
    @State var diceNumber1 = 3
    @State var diceNumber2 = 5
    @State var showingBustSheet = false
    @State var showingWinSheet = false
    @State var turnSum = 0
    @State var totalSum = 0
    @State var rolls = 0
    @State var playerSums = [0, 0, 0, 0, 0, 0]
    
    
    
    var body: some View {
        
        ZStack {
            Color(red: 0, green: 114/256, blue: 8/256)
                .ignoresSafeArea()
            
            VStack{
                Text("Player 1")
                    .underline()
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("Rolls: \(rolls)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("Total: \(totalSum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("Turn: \(turnSum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    DiceView(n: diceNumber1)
                    DiceView(n: diceNumber2)
                }
                .onAppear(perform: {newDiceValues()})
                Spacer()
                VStack (spacing: 20){
                    Button(action: {
                        roll()
                    }) {
                        Text("Roll")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    }
                    .background(Color.red)
                    .cornerRadius(15.0)
                    
                    Button(action: {
                        stop()
                    }) {
                        Text("Stop")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    }
                    .background(Color.red)
                    .cornerRadius(15.0)
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $showingBustSheet, onDismiss: { turnSum = 0 }) {
            BustSheet(turnSum: turnSum)
        }
        .sheet(isPresented: $showingWinSheet, onDismiss: { totalSum = 0; rolls = 0 }){
            WinSheet(totalSum: totalSum, rolls: rolls)
        }
    }
    
    func roll() {
        newDiceValues()
        
        turnSum += diceNumber1 + diceNumber2
        
        if turnSum > 21 {
            showingBustSheet = true
            // visa ny skärm
        }
        
        if !showingBustSheet {
            rolls += 1
        }
    }
    
    func newDiceValues() {
        diceNumber1 = Int.random(in: 1...6)
        diceNumber2 = Int.random(in: 1...6)
    }
    
    func stop() {
        totalSum += turnSum
        turnSum = 0
        
        if totalSum >= 100 {
            showingWinSheet = true
            print(totalSum)
        }
    }
}


struct DiceView: View {
    let n: Int
    
    var body: some View {
        Image(systemName: "die.face.\(n)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}

struct BustSheet : View {
    let turnSum : Int
    
    var body: some View {
        
        ZStack {
            Color(red: 0, green: 114/256, blue: 8/256)
                .ignoresSafeArea()
            
            VStack{
                Text("Bust")
                    .foregroundColor(.white)
                    .font(.title)
                Text("\(turnSum)")
                    .foregroundColor(.red)
                    .font(.title)
                    .padding()
            }
        }
    }
}

struct WinSheet : View {
    let totalSum : Int
    let rolls : Int
    
    var body: some View {
        ZStack {
            Color(red: 0, green: 114/256, blue: 8/256)
                .ignoresSafeArea()
            
            VStack{
                Text("You won in \(rolls) rolls")
                    .foregroundColor(.white)
                    .font(.title)
                //                Text("\(totalSum)")
                //                    .foregroundColor(.red)
                //                    .font(.title)
                //                    .padding()
            }
        }
        
    }
}

//struct PickerView: View {
//    @State private var selection = 1
//    let players = ["1", "2", "3", "4", "5", "6", "7" , "8"]
//
//    var body: some View {
//        VStack {
//            Picker("Select number of players", selection: $selection) {
//                ForEach(players, id: \.self) {
//                    Text($0)
//                }
//            }
//            .pickerStyle(.menu)
//
//           // Text("Selected players: \(selection)")
//        }
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

