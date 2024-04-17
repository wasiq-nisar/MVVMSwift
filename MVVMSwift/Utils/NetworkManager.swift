//
//  NetworkManager.swift
//  MVVMSwift
//
//  Created by Muhammad Wasiq  on 15/04/2024.
//

import Foundation
import Network

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    var isConnected = false
    let monitor = NWPathMonitor()
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We are Connected!")
                self.isConnected = true
            } else {
                print("No Connection!")
                self.isConnected = false
            }
        }
        
        let queue = DispatchQueue(label: "NetworkManager")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
