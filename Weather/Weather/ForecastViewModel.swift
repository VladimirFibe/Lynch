import Foundation

struct ForecastViewModel {
    let forecast: Forecast.Daily
    var system: Int
    
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
    
    func convert(_ temp: Double) -> Double {
        let celsius = temp - 273.5
        return system == 0 ? celsius : 1.8 * celsius + 32
    }
    var day: String {
        Self.dateFormater.string(from: forecast.dt)
    }
    
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    var high: String {
        "H: \(Self.numberFormatter.string(for: convert(forecast.temp.max)) ?? "0")°"
    }
    
    var low: String {
        "L: \(Self.numberFormatter.string(for: convert(forecast.temp.min)) ?? "0")°"
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
    
    var weatherIconURL: URL {
        URL(string: "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png")!
    }
}
