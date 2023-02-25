import SwiftUI
import CoreLocation
struct ContentView: View {
    @StateObject var viewModel = ForecastListViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter Location", text: $viewModel.location)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        viewModel.getWeatherForecast()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                    }

                }
                List(viewModel.forecasts, id: \.day) { day in
                    VStack(alignment: .leading) {
                        Text(day.day)
                            .fontWeight(.bold)
                        HStack(alignment: .center) {
                            Image(systemName: "hourglass")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                            VStack(alignment: .leading) {
                                Text(day.overview)
                                HStack {
                                    Text(day.high)
                                    Text(day.low)
                                }
                                HStack {
                                    Text(day.clouds)
                                    Text(day.pop)
                                }
                                Text(day.humidity)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .padding()
            .navigationTitle("Mobile Weather")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
