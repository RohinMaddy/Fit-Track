//
//  HomeView.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 06/10/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @EnvironmentObject var healhManager: HealthManager
    @State private var isShowingDetailsSheet = false
    @Query(sort: \UserDetails.name) var userDetails: [UserDetails]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    if !userDetails.isEmpty {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 0)]) {
                            ForEach(healhManager.activityData.sorted(by: { $0.id < $1.id })) { activity in
                                FitCardView(actvityData: activity, targetSteps: getTarget(activity: activity, userDetails: userDetails.first!))
                                    .clipShape(.rect(cornerRadius: 20.0))
                                    .padding()
                            }
                        }
                    }
                }
                .navigationTitle("Welcome \(userDetails.first?.name ?? "")")
                .onAppear() {
                    isShowingDetailsSheet =  userDetails.isEmpty ? true : false
                }
                .sheet(isPresented: $isShowingDetailsSheet) {
                    DetailsSheet(userDetails: UserDetails(name: "", age: 0, height: 0, weight: 0, calorieGoal: 0, stepGoal: 0, trackClories: 0), isUpdatingSheet: $isShowingDetailsSheet)
                }
            }
        }
    }
    
    func getTarget(activity: ActivityData, userDetails: UserDetails) -> Double {
        switch activity.activityType {
        case "Steps" : return Double(userDetails.stepGoal)
        case "Calories" : return Double(userDetails.calorieGoal)
        case "Distance" : return Double(userDetails.stepGoal * 0.78)
        default: return 0
        }
    }
}
