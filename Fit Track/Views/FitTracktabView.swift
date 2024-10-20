//
//  FitTracktabView.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 06/10/2024.
//

import SwiftUI

struct FitTracktabView: View {
    @State var selectedTab = "Home"
    @EnvironmentObject var healhManager: HealthManager
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem { Image(systemName: "house") }
                .environment(healhManager)
            ProfileView()
                .tag("Person")
                .tabItem { Image(systemName: "person") }
        }
        .accentColor(.pink.opacity(0.7))
    }
}

//#Preview {
//    FitTracktabView()
//}
