//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Vladimir on 25.02.2023.
//

import Foundation

struct ForecastViewModel {
    let forecast: Forecast.Daily
    
    private static var dateFormater: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    var day: String {
        Self.dateFormater.string(from: forecast.dt)
    }
    
    var overview: String {
        forecast.weather[0].description.capitalized
    }
}
