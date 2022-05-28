//
//  PairCardApp.swift
//  Shared
//
//  Created by Fred Xin on 5/3/22.
//

import SwiftUI

@main
struct PairCardApp: App {
    @StateObject var globalData = GlobalData()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(globalData)
        }
    }
}
