//
//  FitTrackTypes.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 06/10/2024.
//

import Foundation
import HealthKit

enum FitTrackTypes : Int{
    case steps
    case calories
    case distance
    
    var getTypes: HKQuantityType {
        switch self {
        case .steps: return HKQuantityType(.stepCount)
        case .calories: return HKQuantityType(.activeEnergyBurned)
        case .distance: return HKQuantityType(.distanceWalkingRunning)
        }
    }
    
    var getUnit: HKUnit {
        switch self {
        case .steps: return .count()
        case .calories: return .kilocalorie()
        case .distance: return .meter()
        }
    }
    
    var getActivityName: String {
        switch self {
        case .steps: return "Steps"
        case .calories: return "Calories"
        case .distance: return "Distance"
        }
    }
    
    var getActivityIcon: String {
        switch self {
        case .steps: return "figure.walk"
        case .calories: return "flame.fill"
        case .distance: return "figure.walk.treadmill"
        }
    }
}
