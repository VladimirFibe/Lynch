import CoreLocation

class ForecastListViewModel: ObservableObject {
    @Published var forecasts: [ForecastViewModel] = []
    
    var location = ""
    
    func getWeatherForecast() {
        let apiService = APIService.shared

        CLGeocoder().geocodeAddressString(location) { placemarks, error in
            if let error = error {
                print(error)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                apiService.getJSON(from: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=6fa522e5b709fdd1749b9d9459f7e897", dateDecodingStrategy: .secondsSince1970, keyDecodingStrategy: .useDefaultKeys) { (result: Result<Forecast, APIService.APIError>) in
                    switch result {
                    case .success(let forecast):
                        DispatchQueue.main.async {
                            self.forecasts = forecast.daily.map { ForecastViewModel(forecast: $0)}
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }

    }
}