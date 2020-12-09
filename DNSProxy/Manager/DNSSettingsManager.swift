//
//  DNSSettingsManager.swift
//  DNSProxy
//
//  Created by Venkat on 09/12/2020.
//

import Foundation
import NetworkExtension

class DNSSettingsManager {

    // MARK: Properties

    let manager = NEDNSSettingsManager.shared()

    // MARK: Functions

    func configure() {
        loadAndUpdatePreferences { [weak self] in
            self?.manager.localizedDescription = "DNSSettingsSample"
        }
    }

    func removeSettings() {
        manager.removeFromPreferences { _ in

        }
    }

    // MARK: Private Functions

    private func loadAndUpdatePreferences(_ completion: @escaping () -> Void) {
        manager.loadFromPreferences { [weak self] error in
            guard error == nil else {
                debugPrint("DNSProxySample.App: load error")
                return
            }

            let dohSettings = NEDNSOverHTTPSSettings(servers: ["https://dns.google/dns-query"])
            dohSettings.serverURL = URL(string: Constants.dohUrl)
            self?.manager.dnsSettings = dohSettings

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
