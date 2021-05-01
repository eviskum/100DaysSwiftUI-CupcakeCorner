//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Esben Viskum on 30/04/2021.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderClass
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.order.name)
                TextField("Street address", text: $order.order.streetAddress)
                TextField("City", text: $order.order.city)
                TextField("Zip", text: $order.order.zip)
            }
            
            Section {
                NavigationLink(
                    destination: CheckoutView(order: order),
                    label: {
                        Text("Check out")
                    })
            }
            .disabled(!order.order.hasValidAddress)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderClass())
    }
}
