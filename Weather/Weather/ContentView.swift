import SwiftUI
import CoreLocation
struct ContentView: View {
    @State private var location = ""
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(location)
                HStack {
                    TextField("Enter Location", text: $location)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        getWeatherForecast(for: location)
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                    }

                }
                Spacer()
            }
            .padding()
            .navigationTitle("Mobile Weather")
        }
    }
    
    func getWeatherForecast(for location: String) {
        let apiService = APIService.shared
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"

        CLGeocoder().geocodeAddressString(location) { placemarks, error in
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

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
