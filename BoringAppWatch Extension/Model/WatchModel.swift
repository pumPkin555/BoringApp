//
//  WatchModel.swift
//  BoringAppWatch Extension
//
//  Created by Ivanov Viktor on 14.10.2021.
//

import Foundation
import WatchConnectivity


class WatchModel: NSObject, ObservableObject, WCSessionDelegate {
    
    var session: WCSession
    @Published var model: [String]?
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func sendToiPhone() {
        self.session.sendMessage(["Watch" : "text" as Any], replyHandler: nil) { (error) in
            print("Oops, I've got an error: \(error)")
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.model = message["iPhone"] as? [String]
        }
    }
}
