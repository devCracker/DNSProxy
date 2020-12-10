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
        manager.removeFromPreferences { error in
            debugPrint("DNSProxySample \(String(describing: error))")
        }
    }

    // MARK: Private Functions

    private func loadAndUpdatePreferences(_ completion: @escaping () -> Void) {
        manager.loadFromPreferences { [weak self] error in
            guard error == nil else {
                debugPrint("DNSProxySample: load error")
                return
            }

            let dohSettings = NEDNSOverHTTPSSettings(servers: ["8.8.4.4"])
            dohSettings.serverURL = URL(string: Constants.dohUrl + "dns-query")
            self?.manager.dnsSettings = dohSettings

            completion()

            self?.manager.saveToPreferences { (error) in
                guard error == nil else {
                    debugPrint("DNSProxySample: save error")
                    return
                }

                debugPrint("DNSProxySample: saved")
            }
        }
    }

}
