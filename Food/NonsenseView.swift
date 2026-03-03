//
//  NonsenseView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/27/26.
//

import SwiftUI

struct NonsenseView: View {
    @State var theme: ScreenTheme = .system
    @State var backgroundTheme: BackGroundTheme = .system
    @State var bookings: [Booking] = []
    @State var isShowData: Bool = false
    var body: some View {
        
        VStack {
                Button("Red background") {
                    backgroundTheme = .red
                }
                .buttonStyle(ThemeButtonStyle(tint: .red.opacity(0.25)))
                .foregroundStyle(.red)
                Button("Blue theme") {
                    backgroundTheme = .blue
                }
                .buttonStyle(ThemeButtonStyle(tint: .blue.opacity(0.25)))
                .foregroundStyle(.blue)
            Button("Green background") {
                backgroundTheme = .green
            }
            .buttonStyle(ThemeButtonStyle(tint: .green.opacity(0.25)))
                Button("Dark theme") {
                    theme = .dark
                    
                }
                .buttonStyle(ThemeButtonStyle(tint: .primary.opacity(0.25)))
                Button("Light theme") {
                    theme = .light
                }
                .buttonStyle(ThemeButtonStyle(tint: Color(.systemGray5)))
                .foregroundStyle(.blue)
            Button("System background") {
                backgroundTheme = .system
                
            }
            .buttonStyle(ThemeButtonStyle(tint: .gray.opacity(0.25)))
        }
        .preferredColorScheme(theme.colorScheme)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundTheme.background)
            
        
        Group {
            VStack {
                Button(isShowData ? "Hide data" : "Display data") {
                    if (isShowData) {
                        isShowData = false
                    }
                    else {
                        bookings = buildData()
                        isShowData = true
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
            if isShowData {
                buildDataView(bookings)
            }
        }
    }
    
    private func buildData() -> [Booking] {
        var bookings = [Booking]()
        bookings.append(Booking(id:1, firstname:"John", lastname:"Doe", totalprice:2204, depositpaid:false, BookingDates: BookingDate(checkin:"04-11-2025", checkout: "28-11-2025"), additionalneeds:"None"))
        bookings.append(Booking(id:2, firstname:"Sally", lastname: "Jones", totalprice:2009, depositpaid: true, BookingDates: BookingDate(checkin:"04-11-2025", checkout: "28-11-2025"), additionalneeds:"Clean towels"))
        bookings.append(Booking(id:3, firstname:"Matt", lastname:"Ryan", totalprice:1875, depositpaid: true, BookingDates: BookingDate(checkin:"04-11-2025", checkout: "28-11-2025"), additionalneeds:"none"))
        
        return bookings
    }
    
    /*@ViewBuilder
    private func changeTheme(_ chosenTheme: String) -> some View {
        if (chosenTheme == "dark") {
            VStack {
                
            }
            .preferredColorScheme(.dark)
        }
        else if (chosenTheme == "light") {
            VStack {
                
            }
            .preferredColorScheme(.light)
        }
    }*/
    
    @ViewBuilder
    private func buildDataView(_ data: [Booking]) -> some View {
        
        List {
            ForEach(data, id: \.id) { booking in
                
                HStack {
                    Text("\(booking.firstname) \(booking.lastname)")
                }
                HStack {
                    Text("\(booking.BookingDates.checkin) \(booking.BookingDates.checkout)")
                }
                HStack {
                    Text("\(booking.totalprice)")
                }
                HStack {
                    Text("\(booking.depositpaid)")
                }
            }
        }
    }
    
    struct ThemeButtonStyle: ButtonStyle {
        var tint: Color

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(tint.opacity(configuration.isPressed ? 0.6 : 1))
                .foregroundStyle(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .scaleEffect(configuration.isPressed ? 0.97 : 1)
        }
    }
}

#Preview {
    NonsenseView()
}

enum ScreenTheme {
    case system
    case light
    case dark
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

enum BackGroundTheme {
    case red
    case blue
    case green
    case system
    
    var background: Color? {
        switch self {
        case .red: return .red.opacity(0.15)
        case .blue: return .blue.opacity(0.15)
        case .green: return .green.opacity(0.15)
        case .system: return Color(.systemBackground)
        }
    }
}
