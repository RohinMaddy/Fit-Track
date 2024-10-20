//
//  UserDetails.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 18/10/2024.
//

import Foundation
import SwiftData

@Model
class UserDetails {
    var name: String
    var age: Int
    var height: Double
    var weight: Double
    var calorieGoal: Double
    var stepGoal: Double
    var trackClories: Double
    
    init(name: String, age: Int, height: Double, weight: Double, calorieGoal: Double, stepGoal: Double, trackClories: Double) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.calorieGoal = calorieGoal
        self.stepGoal = stepGoal
        self.trackClories = trackClories
    }
}
