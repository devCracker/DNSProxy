//
//  DNSProxyManager.swift
//  DNSProxy
//
//  Created by Venkat on 08/12/2020.
//

import Foundation
import NetworkExtension

class DNSProxyManager {

    // MARK: Properties

    let manager = NEDNSProxyManager.shared()

    // MARK: Functions

    func enable() {
        loadAndUpdatePreferences { [weak self] in
            self?.manager.localizedDescription = "DNSProxySample"

            let dnsProtocol = NEDNSProxyProviderProtocol()
            dnsProtocol.username = ""
            dnsProtocol.providerConfiguration = ["clientId": Constants.dohUrl]
            dnsProtocol.providerBundleIdentifier = Constants.protocolIdentifier

            self?.manager.providerProtocol = dnsProtocol
            self?.manager.isEnabled = true
        }
    }

    func disable() {
        loadAndUpdatePreferences { [weak self] in
            self?.manager.isEnabled = false
        }
    }
    
    // MARK: Private Functions

    private func loadAndUpdatePreferences(_ completion: @escaping () -> Void) {
        manager.loadFromPreferences { [weak self] error in
            guard error == nil else {
                debugPrint("DNSProxySample.App: load error")
                return
            }

            completion()

            self?.manager.saveToPreferences { (error) in
                guard error == nil else {
                    debugPrint("DNSProxySample.App: save error")
                    return
                }

                debugPrint("DNSProxySample.App: saved")
            }
        }
    }
}
