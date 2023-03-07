import SwiftUI

struct ContentView: View {
    var body: some View {
        Button {
            
        } label: {
            Text("7")
                    .font(.largeTitle)
                    .bold()
                    .frame(width: 80, height: 80)
                    .background(.purple)
                    .foregroundColor(.white)
                    .clipShape(Circle())
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
