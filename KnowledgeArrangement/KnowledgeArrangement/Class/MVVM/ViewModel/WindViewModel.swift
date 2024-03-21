//
//  WindViewModel.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2022/7/26.
//  Copyright © 2022 ProgrammerHome. All rights reserved.
//

import Foundation
struct WindViewModel {
    
    let currentWeather: CurrentWeather
    
    private(set) var coordString = ""
    private(set) var windSpeedString = ""
    private(set) var windDegString = ""
    private(set) var locationString = ""
    
    init(currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
        updateProperties()
    }
    
    private mutating func updateProperties() {
        coordString = setCoordString(currentWeather: self.currentWeather)
        windSpeedString = setWindSpeedString(currentWeather: self.currentWeather)
        windDegString = setWindDirectionString(currentWeather: self.currentWeather)
        locationString = setLocationString(currentWeather: self.currentWeather)
    }
    
}

extension WindViewModel {
    private func setCoordString(currentWeather: CurrentWeather) -> String {
        return "Lat: \(currentWeather.coord.lat), Lon: \(currentWeather.coord.lon)"
    }
    
    private func setWindSpeedString(currentWeather: CurrentWeather) -> String {
        return "Wind Speed: \(currentWeather.wind.speed)"
    }

    private func setWindDirectionString(currentWeather: CurrentWeather) -> String {
        return "Wind Deg: \(currentWeather.wind.deg)"
    }

    private func setLocationString(currentWeather: CurrentWeather) -> String {
        return "Location: \(currentWeather.name)"
    }
}

