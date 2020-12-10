//
//  NetworkLogViewModel.swift
//  DNSProxy
//
//  Created by Venkat on 07/12/2020.
//

import Combine
import NetworkExtension

class NetworkLogViewModel: ObservableObject {

    // MARK: Properties

    let proxyManager = DNSProxyManager()
    let dnsSettingsManager = DNSSettingsManager()

    // MARK: Functions

    func enableLogging() {
        proxyManager.enable()
    }

    func disableLogging() {
        proxyManager.disable()
    }

    func applyDNSSettings() {
        proxyManager.enable()
    }

    func removeDNSSettings() {
        dnsSettingsManager.removeSettings()
    }
}
