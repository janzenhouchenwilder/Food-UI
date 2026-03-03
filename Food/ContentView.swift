//
//  ContentView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/5/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = BookingViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // 🔹 BUTTON THAT NAVIGATES TO AUTH VIEW
                NavigationLink("Authenticate") {
                    AuthView()
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Foods") {
                    FoodView()
                }
                .buttonStyle(.borderedProminent)

                /*Button("Load Booking") {
                    Task { await vm.getFoods() }
                }
                .buttonStyle(.bordered)*/
                
                NavigationLink("Nonsense") {
                    NonsenseView()
                }
                .buttonStyle(.borderedProminent)

                Group {
                    if vm.isLoading {
                        ProgressView("Loading…")
                    } else if let error = vm.errorMessage {
                        Text("Error: \(error)")
                            .foregroundStyle(.red)
                    } else if let booking = vm.booking {
                        bookingDetailView(booking)
                    } else {
                        Text("Press Load to fetch booking")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 20)

            }
            .padding()
            .navigationTitle("Main")
        }
    }

    @ViewBuilder
    private func bookingDetailView(_ booking: Booking) -> some View {
        List {
            HStack{
                Text("\(booking.firstname) \(booking.lastname)")
            }
            HStack{
                Text("Check-in")
                Spacer()
                Text("\(booking.BookingDates.checkin)")
            }
            HStack{
                Text("Check-out")
                Spacer()
                Text("\(booking.BookingDates.checkout)")
            }
            HStack {
                Text("Deposit paid")
                Spacer()
                Image(systemName: booking.depositpaid ? "checkmark.circle.fill" : "xmark.circle")
                    .foregroundStyle(booking.depositpaid ? .green : .red)
            }
            HStack{
                Text("Total price")
                Spacer()
                Text("$\(booking.totalprice)")
            }
            HStack{
                Text("Additional needs")
                Spacer()
                Text("\(booking.additionalneeds)")
            }
        }
    }
}



#Preview {
    ContentView()
}
