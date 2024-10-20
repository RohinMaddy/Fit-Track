//
//  FitCardView.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 06/10/2024.
//

import SwiftUI

struct FitCardView: View {
    let actvityData: ActivityData?
    
    let targetSteps: Double
    
    // Calculate progress as a percentage
    var progress: Double {
        return min(Double(actvityData?.activityValue ?? 0) / Double(targetSteps), 1.0)
    }
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text(actvityData?.activityType ?? "Steps")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: actvityData?.image ?? "figure.walk")
                        .resizable()
                        .frame(width: 20, height: 25)
                        .foregroundStyle(.white)
                }
                .padding([.leading, .trailing, .bottom])
                ZStack {
                    
                    Circle()
                        .stroke(lineWidth: 20.0)
                        .opacity(0.3)
                        .foregroundColor(.white.opacity(0.7))
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(progress))
                        .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.pink.opacity(0.6))
                        .rotationEffect(Angle(degrees: -90))
                        .animation(.easeInOut(duration: 0.6), value: progress)
                    
                    VStack {
                        Text("\(actvityData?.activityValue.roundedString ?? "0")")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)
                        Text("of \(targetSteps.roundedString)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 200, height: 200)
                .padding(.bottom)
            }
            .padding()
        }
    }
}

#Preview {
    FitCardView(actvityData: ActivityData(id: 0, activityType: "Steps", activityValue: 3500, image: "figure.walk"), targetSteps: 10000)
}
