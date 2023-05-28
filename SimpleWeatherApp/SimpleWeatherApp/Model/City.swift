//
//  City.swift
//  SimpleWeatherApp
//
//  Created by Erkam Karaca on 26.05.2023.
//

import Foundation

struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coordinates?
    let weather: [WeatherItems]?
    let main: Main?
    let wind: Wind?
}

struct Coordinates: Codable {
    let lon: Float?
    let lat: Float?
}

struct WeatherItems: Codable {
    let main: String?
    let description: String?
}

struct Main: Codable {
    let temp: Float?
    let feelsLike: Float?
    let tempMin: Float?
    let tempMax: Float?
    let humidity: Int?
    let seaLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case temp, humidity
    }
}

struct Wind: Codable {
    let speed: Float?
    let gust: Float?
}

struct JsonCity: Codable {
    let id: Int?
    let name: String?
}


