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
                    ForEach(0 ..< cardPicker.count) {
                      Text(String(self.cardPicker[$0]))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding([.top, .leading, .trailing])
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 10)
             .background(Color.blue)
            
            HStack {
                Label("Difficulty", systemImage: "square.3.stack.3d")
                    .padding([.top, .leading, .trailing])
                Spacer()
            }
            VStack {
                HStack {
                    Image(systemName: "ladybug.fill").padding(.horizontal)
                    Spacer()
                    Picker(selection: $selectedBug,
                           label: Text("remember \(self.diffPicker[selectedBug]) cards")) {
                        ForEach(0 ..< diffPicker.count) {
                          Text(String(self.diffPicker[$0]))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Spacer()
                }.padding(.vertical)
                
                HStack {
                    Image(systemName: "tortoise.fill").padding(.horizontal)
                    Spacer()
                    Picker(selection: $selectedTortoise,
                           label: Text("remember \(self.diffPicker[selectedTortoise]) cards")) {
                        ForEach(0 ..< diffPicker.count) {
                            Text(String(self.diffPicker[$0]))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Spacer()
                }.padding(.vertical)
                
                HStack {
                    Image(systemName: "hare.fill").padding(.horizontal)
                    Spacer()
                    Picker(selection: $selectedHare,
                           label: Text("remember \(self.diffPicker[selectedHare]) cards")) {
                        ForEach(0 ..< diffPicker.count) {
                            Text(String(self.diffPicker[$0]))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Spacer()
                }.padding(.vertical)

                HStack {
                    Image(systemName: "person.crop.rectangle.fill").padding(.horizontal)
                    Spacer()
                    Picker(selection: $selectedPerson, label: Text("remember \(self.diffPicker[selectedPerson]) cards")) {
                        ForEach(0 ..< diffPicker.count) {
                            Text(String(self.diffPicker[$0]))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Spacer()
                }.padding(.vertical)

                HStack {
                    Image(systemName: "desktopcomputer").padding(.horizontal)
                    Spacer()
                    Picker(selection: $selectedCpu,
                           label: Text("remember \(self.diffPicker[selectedCpu]) cards")) {
                        ForEach(0 ..< diffPicker.count) {
                            Text(String(self.diffPicker[$0]))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Spacer()
                }.padding(.vertical)
            }
            Spacer()
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 10)
             .background(Color.blue)

            Spacer()

            Button("Apply Settings") {
                globalData.cardCount = cardPicker[selectedCard]
                globalData.hSize = xPicker[selectedCard]
                globalData.vSize = yPicker[selectedCard]
                globalData.numBug = diffPicker[selectedBug]
                globalData.numTortoise = diffPicker[selectedTortoise]
                globalData.numHare = diffPicker[selectedHare]
                globalData.numHuman = diffPicker[selectedPerson]
                globalData.numCpu = diffPicker[selectedCpu]
            }
            .padding()
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
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

