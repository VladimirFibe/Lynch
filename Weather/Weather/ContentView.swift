import SwiftUI
import CoreLocation
struct ContentView: View {
    @State private var location = ""
    @State var forecast: Forecast? = nil
    var dateFormatter = DateFormatter()
    init() {
        dateFormatter.dateFormat = "E, MMM, d"
    }
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
                if let forecast = forecast {
                    List(forecast.daily, id: \.dt) { day in
                        VStack(alignment: .leading) {
                            Text(dateFormatter.string(from: day.dt))
                                .fontWeight(.bold)
                            HStack(alignment: .top) {
                                Image(systemName: "hourglass")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                                VStack(alignment: .leading) {
                                    Text(day.weather[0].description.capitalized)
                                    HStack {
                                        Text("High: \(day.temp.max, specifier: "%0.f")")
                                        Text("Low: \(day.temp.min, specifier: "%0.f")")
                                    }
                                    HStack {
                                        Text("Clouds: \(day.clouds)")
                                        Text("POP: \(day.pop, specifier: "%0.2f")")
                                    }
                                    Text("Humidity: \(day.humidity)")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Mobile Weather")
        }
    }
    
    func getWeatherForecast(for location: String) {
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
                        self.forecast = forecast
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
