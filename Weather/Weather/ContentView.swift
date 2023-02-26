import SwiftUI
import CoreLocation
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject var viewModel = ForecastListViewModel()
    var body: some View {
        ZStack {
            content
            if viewModel.isLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                    .ignoresSafeArea()
                    ProgressView("Fetching Weather")
                        .padding(50)
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemBackground))
                        )
                        .shadow(radius: 10)
                }
                
            }
        }
    }
    var content: some View {
        NavigationStack {
            VStack {
                Picker(selection: $viewModel.system) {
                    Text("°C").tag(0)
                    Text("°F").tag(1)
                } label: {
                    Text("System")
                }
                .pickerStyle(.segmented)
                .frame(width: 100)
                .padding(.vertical)
                HStack {
                    TextField("Enter Location", text: $viewModel.location,
                    onCommit: {
                        viewModel.getWeatherForecast()
                    })
                        .textFieldStyle(.roundedBorder)
                        .overlay(
                            Button(action: {
                                viewModel.location = ""
                                viewModel.getWeatherForecast()
                            }, label: {
                                Image(systemName: "xmark.circle")
                            })
                            .foregroundColor(.gray)
                            .padding(.trailing)
                            , alignment: .trailing)
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
                            WebImage(url: day.weatherIconURL)
                                .resizable()
                                .placeholder {
                                    Image(systemName: "hourglass")
                                }
                                .scaledToFit()
                                .frame(width: 75, height: 75)
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
            .alert(item: $viewModel.appError) { appAlert in
                Alert(title: Text("Error!!!"),
                message: Text("""
                             \(appAlert.error)
                             Please try again leter
                             """))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
