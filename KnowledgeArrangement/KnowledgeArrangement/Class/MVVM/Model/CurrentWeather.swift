//
//  CurrentWeather.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2022/7/26.
//  Copyright © 2022 ProgrammerHome. All rights reserved.
//

import Foundation
struct CurrentWeather: Codable {
    let coord: Coord
    let weather: [WeatherDetails]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let id: Int
    let name: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct WeatherDetails: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main {
    let temp: Double?
    let pressure: Double?
    let humidity: Double
    let tempMin: Double?
    let tempMax: Double?
}

extension Main: Codable {

    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
        humidity = try values.decode(Double.self, forKey: .humidity)
        tempMin = try values.decodeIfPresent(Double.self, forKey: .tempMin)
        tempMax = try values.decodeIfPresent(Double.self, forKey: .tempMax)

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(temp, forKey: .temp)
        try container.encodeIfPresent(pressure, forKey: .pressure)
        try container.encode(humidity, forKey: .humidity)
        try container.encodeIfPresent(tempMin, forKey: .tempMin)
        try container.encodeIfPresent(tempMax, forKey: .tempMax)
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}


struct Clouds: Codable {
    let all: Int
}


struct Sys: Codable {
    let type: Int
    let id: Int
    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}

