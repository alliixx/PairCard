//
//  SettingView.swift
//  PairCard
//
//  Created by Fred Xin on 5/16/22.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var globalData: GlobalData

    private var cardPicker = [16, 20, 30, 36]
    private var xPicker = [4, 4, 5, 6]
    private var yPicker = [4, 5, 6, 6]
    private var diffPicker = [0, 1, 2, 3, 4, 5, 6, 8, 10, 36]

    @State var selectedCard = 0
    @State var selectedBug = 0
    @State var selectedTortoise = 1
    @State var selectedHare = 2
    @State var selectedPerson = 3
    @State var selectedCpu = 4
    @State var buttonColor = Color.gray

    var body: some View {
        VStack {
            HStack{
                Spacer()
                Label("Game Setups", systemImage: "gearshape.fill").padding()
                Spacer()
            }
            HStack {
                Label("Card Number", systemImage: "number.circle.fill")
                    .padding(.trailing)
                Spacer()
                Picker(selection: $selectedCard, label: Text("Card")) {
                    ForEach(0 ..< cardPicker.count, id:\.self) {
                      Text(String(self.cardPicker[$0]))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedCard, perform: { _ in
                    buttonColor = Color.blue
                })
            }
            .padding([.top, .leading, .trailing])
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 10)
             .background(Color.blue)
            
          

            Spacer()

            Button("Apply Settings") {
                if(buttonColor == Color.blue){
                    globalData.cardCount = cardPicker[selectedCard]
                    globalData.hSize = xPicker[selectedCard]
                    globalData.vSize = yPicker[selectedCard]
                    globalData.numBug = diffPicker[selectedBug]
                    globalData.numTortoise = diffPicker[selectedTortoise]
                    globalData.numHare = diffPicker[selectedHare]
                    globalData.numHuman = diffPicker[selectedPerson]
                    globalData.numCpu = diffPicker[selectedCpu]
                    buttonColor = Color.gray
                }
            }
            .padding()
            .background(buttonColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            Spacer()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

