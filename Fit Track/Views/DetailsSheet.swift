//
//  DetailsSheet.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 18/10/2024.
//

import SwiftUI

struct DetailsSheet: View {
    @State var userDetails: UserDetails
    @Binding var isUpdatingSheet: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .indigo], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                VStack {
                    Text("Welcome to Fit Track, Please Enter Your Details")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                        .foregroundStyle(Color.black)
                    Form {
                        nameCell(name: $userDetails.name)
                        ageCell(age: $userDetails.age)
                        detailsCell(type: $userDetails.height, typeName: "Height (ft): ")
                        detailsCell(type: $userDetails.weight, typeName: "Weight (kg): ")
                        detailsCell(type: $userDetails.stepGoal, typeName: "Step Goal: ")
                        detailsCell(type: $userDetails.calorieGoal, typeName: "Calorie Goal: ")

                    }
                    .frame(minHeight: 500, maxHeight: .infinity)
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    .foregroundStyle(Color.white)
                    Spacer()
                    ButtonView(userDetails: $userDetails, isUpdatingSheet: $isUpdatingSheet)
                }
        }
        .onTapGesture(perform: {
            UIApplication.shared.dismissKeyboard() 
        })
        .frame(maxHeight: .infinity)
        .interactiveDismissDisabled()
    }
}

struct nameCell: View {
    @Binding var name: String
    
    var body: some View {
        HStack {
            Text("Name: ")
                .bold()
                .frame(height: 40, alignment: .leading)
                .font(.title3)
                .foregroundStyle(Color.gray)
            TextField("Enter Name", text: $name)
                .font(.title3)
                .foregroundStyle(Color.gray)
        }
    }
}

struct ageCell: View {
    @Binding var age: Int
    
    var body: some View {
        HStack {
            Text("Age: ")
                .bold()
                .frame(height: 40, alignment: .leading)
                .font(.title3)
                .foregroundStyle(Color.gray)
            TextField("Value", value: $age, format: .number).keyboardType(.numberPad)
                .font(.title3)
                .foregroundStyle(Color.gray)
        }
    }
}

struct detailsCell: View {
    @Binding var type: Double
    var typeName: String
    
    var body: some View {
        HStack {
            Text(typeName)
                .bold()
                .frame(height: 40, alignment: .leading)
                .font(.title3)
                .foregroundStyle(Color.gray)
            TextField("Value", value: $type, format: .number).keyboardType(.numberPad)
                .font(.title3)
                .foregroundStyle(Color.gray)
        }
    }
}

struct ButtonView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State var showAlert: Bool = false
    @Binding var userDetails: UserDetails
    @Binding var isUpdatingSheet: Bool
    
    var body: some View {
        Button {
            let userDetails = UserDetails(name: userDetails.name, age: userDetails.age, height: userDetails.height, weight: userDetails.weight, calorieGoal: userDetails.calorieGoal, stepGoal: userDetails.stepGoal, trackClories: 0)
            
            if (userDetails.age == 0 || userDetails.height == 0 || userDetails.weight == 0 || userDetails.calorieGoal == 0 || userDetails.stepGoal == 0 || userDetails.name == "") {
                showAlert = true
            } else {
                showAlert = false
                context.insert(userDetails)
                // Auto save enabled in swift data but just in case
                do {
                    try context.save()
                } catch {
                    fatalError("Unable to save data")
                }
                isUpdatingSheet = false
                dismiss()
            }
        } label: {
            Text("Done")
                .font(.title2)
                .foregroundStyle(Color.white)
                .bold()
        }
        .alert("We need more information", isPresented: $showAlert, actions: {
            Button("OK") { showAlert = false}
        })
        .frame(maxWidth: .infinity, alignment: .bottom)
        .frame(height: 60)
        .buttonBorderShape(.capsule)
        .clipShape(.capsule)
        .overlay {
            Capsule().stroke(Color.white, lineWidth: 2)
        }
        .padding()
    }
}

#Preview {
    DetailsSheet(userDetails: UserDetails(name: "Rohin", age: 28, height: 6, weight: 84, calorieGoal: 500, stepGoal: 10000, trackClories: 0), isUpdatingSheet: .constant(true))
}
