//
//  Model.swift
//  AlamofireProject
//
//  Created by MacBook Air on 21.03.2023.
//

import Foundation

// MARK: - Currency
struct Currency: Codable {
    let success: Bool?
    let timestamp: Int?
    let base, date: String?
    let rates: [String: Double]?
}
