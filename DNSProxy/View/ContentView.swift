//
//  ContentView.swift
//  DNSProxy
//
//  Created by Venkat on 07/12/2020.
//

import SwiftUI

struct ContentView: View {

    // MARK: Properties

    @State private var isLoggingEnabled: Bool = false
    @State private var shouldApplyDoH: Bool = false

    @StateObject private var viewModel: NetworkLogViewModel = NetworkLogViewModel()

    // MARK: Body

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Enable Logging")
                    Toggle("", isOn: $isLoggingEnabled)
                        .onChange(of: isLoggingEnabled) { value in
                            toggleLogging()
                        }
                }
                HStack {
                    Text("Enable DoH")
                    Toggle("", isOn: $shouldApplyDoH)
                        .onChange(of: shouldApplyDoH) { value in
                            toggleDoH()
                        }
                }
            }
            .navigationBarTitle(Text("Custom DNS"))
        }
    }

    // MARK: Functions

    func toggleLogging() {
        isLoggingEnabled ? viewModel.enableLogging() : viewModel.disableLogging()
    }

    func toggleDoH() {
        isLoggingEnabled ? viewModel.applyDNSSettings() : viewModel.removeDNSSettings()
    }
}
