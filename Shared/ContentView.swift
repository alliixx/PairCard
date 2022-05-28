//
//  ContentView.swift
//  Shared
//
//  Created by Fred Xin on 5/3/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var globalData: GlobalData

    var body: some View {
        TabView {
            PlayCardView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }
                .environmentObject(globalData)
            HomeView()
                .tabItem {
                    Label("Help", systemImage: "person.fill.questionmark")
                }
                
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .environmentObject(globalData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


