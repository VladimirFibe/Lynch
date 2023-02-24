import Cocoa
import CoreLocation

struct Forecast: Codable {
    struct Daily: Codable {
        let dt: Date
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
        let temp: Temp
        let humidity: Int
        struct Weather: Codable {
            let id: Int
            let description: String
            let icon: String
            var weatherIconURL: URL {
                URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!
            }
        }
        let weather: [Weather]
        let clouds: Int
        let pop: Double
    }
    let daily: [Daily]
}

let apiService = APIService.shared
var dateFormatter = DateFormatter()
dateFormatter.dateFormat = "E, MMM, d"

CLGeocoder().geocodeAddressString("Moscow") { placemarks, error in
    if let error = error {
        print(error)
    }
    if let lat = placemarks?.first?.location?.coordinate.latitude,
       let lon = placemarks?.first?.location?.coordinate.longitude {
        apiService.getJSON(from: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=6fa522e5b709fdd1749b9d9459f7e897", dateDecodingStrategy: .secondsSince1970, keyDecodingStrategy: .useDefaultKeys) { (result: Result<Forecast, APIService.APIError>) in
            switch result {
            case .success(let forecast):
                for day in forecast.daily {
                    print(dateFormatter.string(from: day.dt))
                    print(" Max: ", day.temp.max)
                    print(" Min: ", day.temp.min)
                    print(" Humidity: ", day.humidity)
                    print(" Description: ", day.weather[0].description)
                    print(" Clouds: ", day.clouds)
                    print(" Pop: ", day.pop)
                    print(" IconURL: ", day.weather[0].weatherIconURL)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
