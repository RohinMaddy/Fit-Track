//
//  HealthManager.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 06/10/2024.
//

import Foundation
import HealthKit

class HealthManager: Observable, ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var activityData: [ActivityData] = []
    
    init () {
        
        let healthTypes: Set = [FitTrackTypes.steps.getTypes, FitTrackTypes.distance.getTypes, FitTrackTypes.calories.getTypes]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                fetchTodaysActivity(type: FitTrackTypes.steps)
                fetchTodaysActivity(type: FitTrackTypes.calories)
                fetchTodaysActivity(type: FitTrackTypes.distance)
            }
            catch {
                print(error)
            }
        }
        
    }
    
    func fetchTodaysActivity(type: FitTrackTypes) {
        let predicate = HKQuery.predicateForSamples(withStart: Date().startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: type.getTypes, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching steps: \(error?.localizedDescription ?? "")")
                return
            }
            
            let value = quantity.doubleValue(for: type.getUnit)
            print("Todays Activity: \(value)")
            let activity = ActivityData(id: type.rawValue, activityType: type.getActivityName, activityValue: value, image: type.getActivityIcon)
            DispatchQueue.main.async {
                self.activityData.append(activity)
            }
        }
        
        healthStore.execute(query)
            
    }
    
}
