//
//  Booking.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/6/26.
//

import Foundation

struct Booking: Decodable {
    let id: Int?
    let firstname: String
    let lastname: String
    let totalprice: Int
    let depositpaid: Bool
    let BookingDates: BookingDate
    let additionalneeds: String
}

struct BookingDate: Decodable {
    let checkin: String
    let checkout: String
}
