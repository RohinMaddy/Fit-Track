//
//  Fit_TrackApp.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 06/10/2024.
//

import SwiftUI
import SwiftData

@main
struct Fit_TrackApp: App {
    @StateObject var healhManager: HealthManager = HealthManager()
    
    var container: ModelContainer {
        let schema = Schema([UserDetails.self])
        do {
            let modelContainer = try ModelContainer(for: schema, configurations: [])
            return modelContainer
        } catch {
            fatalError("Unable to build container!")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healhManager)
                .modelContainer(container)
        }
    }
}
