//
//  ContentView.swift
//  DiceGame
//
//  Created by David Svensson on 2022-12-20.
//

import SwiftUI

/*******************************
*   Skapa ett tärningsspel där man slår två tärningar. Efter valfritt antal slag
*  kan omgången avslutas, då sparas hittils uppnådda poäng
* Om poängen för en omgång överskrider 21 blir istället poängen för den omgången 0
*
    Målet är att uppnå 100p på så få omgångar som möjligt
  
 ********************************/

struct ContentView: View {
    @State var diceNumber1 = 4
    @State var diceNumber2 = 3
    @State var sum = 0
    @State var showingBustSheet = false
    
    var body: some View {
        ZStack {
            Color(red: 51/256, green: 106/256, blue: 61/256)
                .ignoresSafeArea()
            
            VStack {
                Text("\(sum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    DiceView(n: diceNumber1)
                    DiceView(n: diceNumber2)
                }.onAppear() {
                    newDiceValues()
                }
                Spacer()

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
                Spacer()
            }
        }
        .sheet(isPresented: $showingBustSheet, onDismiss: { sum = 0 }) {
            BustSheet(sum: sum)
        }
    }
    
    func roll() {
        newDiceValues()
        
        sum += diceNumber1 + diceNumber2
        if ( sum > 21 ) {
            showingBustSheet = true
        }
    }
    
    func newDiceValues() {
        diceNumber1 = Int.random(in: 1...6)
        diceNumber2 = Int.random(in: 1...6)
    }
    
}


struct DiceView : View {
    let n: Int
    
    var body: some View {
        
        Image(systemName: "die.face.\(n)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}


struct BustSheet : View {
    let sum : Int
    
    var body: some View {
        ZStack {
            Color(red: 51/256, green: 106/256, blue: 61/256)
                .ignoresSafeArea()
            
            VStack {
                Text("Bust")
                    .foregroundColor(.white)
                    .font(.title)
                
                Text("\(sum)")
                    .foregroundColor(.red)
                    .font(.title)
            }
        }
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//      //  BustSheet()
//    }
//}
