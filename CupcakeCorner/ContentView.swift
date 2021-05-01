//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Esben Viskum on 30/04/2021.
//

import SwiftUI

class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Esben Viskum"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

/* struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
}

extension ContentView {
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&song") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
} */

/* struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
} */

struct ContentView: View {
    @ObservedObject var order = OrderClass()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.order.specialRequestEnabled.animation(), label: {
                        Text("Any special requests")
                    })
                    
                    if order.order.specialRequestEnabled {
                        Toggle(isOn: $order.order.extraFrosting, label: {
                            Text("Add extra frosting")
                        })
                        
                        Toggle(isOn: $order.order.addSprinkles, label: {
                            Text("Add extra sprinkles")
                        })
                    }
                }
                
                Section {
                    NavigationLink(
                        destination: AddressView(order: order),
                        label: {
                            Text("Delivery details")
                        })
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
