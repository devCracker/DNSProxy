//
//  DNSProxyProvider.swift
//  DNSProxy-Extension
//
//  Created by Venkat on 07/12/2020.
//

import NetworkExtension
import os

class DNSProxyProvider: NEDNSProxyProvider {

    override func startProxy(options:[String: Any]? = nil, completionHandler: @escaping (Error?) -> Void) {
        completionHandler(nil)
    }

    override func stopProxy(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    override func sleep(completionHandler: @escaping () -> Void) {
        // Add code here to get ready to sleep.
        completionHandler()
    }

    override func wake() {
        // Add code here to wake up.
    }

    override func handleNewFlow(_ flow: NEAppProxyFlow) -> Bool {
        if let tcpFlow = flow as? NEAppProxyTCPFlow {
            logTCPRequest(with: tcpFlow)
        } else if let udpFlow = flow as? NEAppProxyUDPFlow {
            logUDPRequest(with: udpFlow)
        }

        return true
    }

}

// MARK: Logging

private extension DNSProxyProvider {

    func logTCPRequest(with flowRequest: NEAppProxyTCPFlow) {
        if let remoteHost = (flowRequest.remoteEndpoint as? NWHostEndpoint)?.hostname {
            DNSLogger.shared.log(message: "DNSProxyProvider TCP HOST : \(remoteHost)")
        }
        if let remotePort = (flowRequest.remoteEndpoint as? NWHostEndpoint)?.port {
            DNSLogger.shared.log(message: "DNSProxyProvider TCP PORT : \(remotePort)")
        }
    }

    func logUDPRequest(with flowRequest: NEAppProxyUDPFlow) {
        if let localHost = (flowRequest.localEndpoint as? NWHostEndpoint)?.hostname {
            DNSLogger.shared.log(message: "DNSProxyProvider UDP HOST : \(localHost)")
        }
        if let localPort = (flowRequest.localEndpoint as? NWHostEndpoint)?.port {
            DNSLogger.shared.log(message: "DNSProxyProvider UDP PORT : \(localPort)")
        }
    }
}
