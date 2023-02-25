import Foundation

struct ForecastViewModel {
    let forecast: Forecast.Daily
    
    private static var dateFormater: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatterPercent: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    var day: String {
        Self.dateFormater.string(from: forecast.dt)
    }
    
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    var high: String {
        "H: \(Self.numberFormatter.string(for: forecast.temp.max) ?? "0")°"
    }
    
    var low: String {
        "L: \(Self.numberFormatter.string(for: forecast.temp.min) ?? "0")°"
    }
    
    var pop: String {
        "💧 \(Self.numberFormatterPercent.string(for: forecast.pop) ?? "0%")"
    }
    
    var clouds: String {
        "☁️ \(forecast.clouds)%"
    }
    
    var humidity: String {
        "Humidity: \(forecast.humidity)%"
    }
}
