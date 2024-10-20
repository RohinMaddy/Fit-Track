//
//  Extentions.swift
//  Fit Track
//
//  Created by Rohin Madhavan on 06/10/2024.
//

import Foundation
import UIKit

extension Date {
     var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

extension Double {
    var roundedString: String {
        "\(Int(self.rounded()))"
    }
    
    var roundedToTwoDecimalPlaces: Double {
        return ((self * 100).rounded() / 100)
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
