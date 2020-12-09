//
//  DNSLogger.swift
//  DNSProxy
//
//  Created by Venkat on 09/12/2020.
//

import Foundation
import os

class DNSLogger {

    // MARK: Shared Instance

    static let shared = DNSLogger()
    private let logger: Logger

    // MARK: Init

    private init() {
        let identifier = Bundle.main.bundleIdentifier ?? "DNSProxySystem"

        logger = Logger(subsystem: identifier, category: "DNSLogging")
    }

    // MARK: Functions

    func log(message value: String) {
        logger.log("messsge: \(value)")
    }

    func log(error value: String) {
        logger.error("error: \(value)")
    }
}
