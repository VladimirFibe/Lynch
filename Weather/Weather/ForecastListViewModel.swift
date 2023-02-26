import CoreLocation
import SwiftUI

class ForecastListViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let error: String
    }
    @Published var appError: AppError? = nil
    @Published var forecasts: [ForecastViewModel] = []
    @Published var isLoading = false
    @AppStorage("location") var location = ""
    @AppStorage("system") var system = 0 {
        didSet {
            for i in 0..<forecasts.count {
                forecasts[i].system = system
            }
        }
    }
    
    init() {
        getWeatherForecast()
    }
    func getWeatherForecast() {
        UIApplication.shared.endEditing()
        guard !location.isEmpty else {
            forecasts = []
            return
        }
        isLoading = true
        let apiService = APIService.shared

        CLGeocoder().geocodeAddressString(location) { placemarks, error in
            if let error = error {
                self.isLoading = false
                self.appError = AppError(error: error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                apiService.getJSON(from: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=6fa522e5b709fdd1749b9d9459f7e897", dateDecodingStrategy: .secondsSince1970, keyDecodingStrategy: .useDefaultKeys) { (result: Result<Forecast, APIService.APIError>) in
                    DispatchQueue.main.async {
                        self.isLoading = false
                        switch result {
                        case .success(let forecast):
                            self.forecasts = forecast.daily.map { ForecastViewModel(forecast: $0, system: self.system)}
                        case .failure(let failure):
                            self.appError = AppError(error: failure.localizedDescription)
                        }
                    }
                }
            }
        }

    }
}
