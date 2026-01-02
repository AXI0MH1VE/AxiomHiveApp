//
//  Extensions.swift
//  AxiomHiveApp
//
//  Useful extensions for common types
//

import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    func timeAgo() -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .weekOfYear, .month, .year], from: self, to: now)
        
        if let years = components.year, years > 0 {
            return "\(years) year\(years == 1 ? "" : "s") ago"
        }
        if let months = components.month, months > 0 {
            return "\(months) month\(months == 1 ? "" : "s") ago"
        }
        if let weeks = components.weekOfYear, weeks > 0 {
            return "\(weeks) week\(weeks == 1 ? "" : "s") ago"
        }
        if let days = components.day, days > 0 {
            return "\(days) day\(days == 1 ? "" : "s") ago"
        }
        if let hours = components.hour, hours > 0 {
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        }
        if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        }
        return "Just now"
    }
    
    func formatted(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}

// MARK: - TimeInterval Extensions
extension TimeInterval {
    func formatted() -> String {
        if self < 1 {
            return String(format: "%.0f ms", self * 1000)
        } else if self < 60 {
            return String(format: "%.2f s", self)
        } else if self < 3600 {
            let minutes = Int(self / 60)
            let seconds = Int(self.truncatingRemainder(dividingBy: 60))
            return "\(minutes)m \(seconds)s"
        } else {
            let hours = Int(self / 3600)
            let minutes = Int((self.truncatingRemainder(dividingBy: 3600)) / 60)
            return "\(hours)h \(minutes)m"
        }
    }
}

// MARK: - String Extensions
extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        guard count >= Constants.Security.minPasswordLength else { return false }
        
        if Constants.Security.requireNumbers {
            let numberRegex = ".*[0-9]+.*"
            let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
            guard numberPredicate.evaluate(with: self) else { return false }
        }
        
        if Constants.Security.requireSpecialCharacters {
            let specialCharRegex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
            let specialCharPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharRegex)
            guard specialCharPredicate.evaluate(with: self) else { return false }
        }
        
        return true
    }
    
    func truncated(to length: Int, trailing: String = "...") -> String {
        guard count > length else { return self }
        return String(prefix(length)) + trailing
    }
}

// MARK: - Double Extensions
extension Double {
    func formatAsPercentage(decimals: Int = 1) -> String {
        return String(format: "%.\(decimals)f%%", self)
    }
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

// MARK: - View Extensions
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func cardStyle() -> some View {
        self
            .background(Constants.Colors.secondaryBackground)
            .cornerRadius(Constants.UI.cornerRadius)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    func errorAlert(error: Binding<Error?>, isPresented: Binding<Bool>) -> some View {
        alert("Error", isPresented: isPresented, presenting: error.wrappedValue) { _ in
            Button("OK") {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}

// MARK: - Custom Shapes
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Color Extensions
extension Color {
    static func statusColor(for status: TransactionStatus) -> Color {
        switch status {
        case .pending, .processing:
            return Constants.Colors.warning
        case .completed:
            return Constants.Colors.success
        case .failed:
            return Constants.Colors.error
        case .cancelled:
            return Constants.Colors.secondary
        }
    }
}
