//
//  ProfileView.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 19/10/2024.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query(sort: \UserDetails.name) var userDetails: [UserDetails]
    @Environment(\.modelContext) private var context
    @State var userDetail: UserDetails = UserDetails(name: "", age: 0, height: 0, weight: 0, calorieGoal: 0, stepGoal: 0, trackClories: 0)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple.opacity(0.5), .indigo.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("You can update our details here!")
                    .font(.title2)
                    .bold()
                    .padding(.top, 50)
                    .foregroundStyle(Color.white)
                Form {
                    nameCell(name: $userDetail.name)
                    ageCell(age: $userDetail.age)
                    detailsCell(type: $userDetail.height, typeName: "Height (ft): ")
                    detailsCell(type: $userDetail.weight, typeName: "Weight (kg): ")
                    detailsCell(type: .constant(getBMI().roundedToTwoDecimalPlaces), typeName: "BMI: ")
                    detailsCell(type: $userDetail.stepGoal, typeName: "Step Goal: ")
                    detailsCell(type: $userDetail.calorieGoal, typeName: "Calorie Goal: ")
                    detailsCell(type: $userDetail.trackClories, typeName: "Todays Calories: ")
                    
                }
                .frame(minHeight: 500, maxHeight: .infinity)
                .scrollContentBackground(.hidden)
                .background(.clear)
                .foregroundStyle(Color.white)
            }
        }
        .onAppear() {
            if let userDetail = userDetails.first {
                self.userDetail = userDetail
            }
        }
        .onTapGesture(perform: {
            UIApplication.shared.dismissKeyboard()
        })
    }
    
    func getBMI() -> Double {
        return Double(userDetail.weight) / pow(Double(userDetail.height * 0.3048), 2)
    }
}

#Preview {
    ProfileView(userDetail: UserDetails(name: "Rohin", age: 28, height: 6, weight: 84, calorieGoal: 500, stepGoal: 10000, trackClories: 0))
}
