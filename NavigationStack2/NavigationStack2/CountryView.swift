import SwiftUI

struct CountryView: View {
    var country: Country
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(country.flag)
                Text(country.name)
            }
            .font(.largeTitle)
            Text("Population: \(country.population)")
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            List(country.cities) { city in
                NavigationLink(value: city) {
                    Text(city.name)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationTitle("Country")
        .navigationDestination(for: City.self) { city in
            CityView(city: city)
        }
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CountryView(country: Country.sample[2])
        }
            
    }
}
