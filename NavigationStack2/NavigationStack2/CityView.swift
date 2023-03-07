import SwiftUI
import Charts

struct CityView: View {
    @EnvironmentObject var router: Router
    let city: City
    var body: some View {
        VStack {
            ZStack {
                if city.isCapital {
                    Text("🌟").font(.system(size: 200))
                }
                Text("\(city.name) (\(city.country))")
                    .font(.title2)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 220)
            Chart(city.fellowCities) { city in
                BarMark(x: .value("City", city.name),
                        y: .value("Pululation", city.population))
                .foregroundStyle(by: .value("City", city.name))
            }
            .chartLegend(.hidden)
            .padding()
            Button("Back to Countries List") {
                router.reset()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("City")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CityView(city: Country.sample[2].cities[0])
        }
        .environmentObject(Router())
    }
}
