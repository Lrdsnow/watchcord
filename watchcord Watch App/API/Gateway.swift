////
// watchcord Watch App
// Created by circular with <3 on 27/7/2023
// please excuse my spaghetti code
//

import Foundation
import Combine

public class Gateway: ObservableObject {
    static var webSocketTask: URLSessionWebSocketTask?
    static var heartbeatTimer: Timer?
    static let messageCreateSubject = PassthroughSubject<[String: Any], Never>()

    static func establishConnection() {
        // wss://gateway.discord.gg/?v=10&encoding=json
        guard let url = URL(string: "wss://gateway.discord.gg/?v=10&encoding=json") else { return }
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        config.allowsCellularAccess = true
        config.allowsExpensiveNetworkAccess = true
        //webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask = URLSession(configuration: config).webSocketTask(with: request)
        webSocketTask?.resume()
        webSocketTask?.maximumMessageSize = 20000000
        receiveMessage()
    }
    
    static func closeConnection() {
        if (webSocketTask?.state == .running) {
            webSocketTask?.cancel(with: .goingAway, reason: nil)
        }
    }
    
    static func checkConnection() {
        if (webSocketTask?.state != .running) {
            establishConnection()
        }
    }

    static func receiveMessage() {
        // parse data as json
        print("Received Message")
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                switch message {
                case .string(let text):
                    if (text.lengthOfBytes(using: .utf8) > 1000) {
                        print("Received long string. not printing.")
                    } else {
                        print("Received String: \(text)")
                    }
                    if let json = try? JSONSerialization.jsonObject(with: text.data(using: .utf8) ?? Data(), options: []) as? [String: Any] {
                        parseMessage(message: json)
                    }
                case .data(let data):
                    //print("Received Data: \(data)")
                    print("data")
                @unknown default:
                    fatalError()
                }

                self.receiveMessage()
            }
        }
    }

    static func sendMessage(message: String) {
        guard let data = message.data(using: .utf8) else { return }
        print("Sending \(message)")
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print("ERROR IN SENDING: \(error.localizedDescription)")
            }
        }
    }

    static func parseMessage(message: [String : Any]) {
        if let op = message["op"] as? Int {
            switch op {
            case 10:
                // hello
                if let data = message["d"] as? [String : Any] {
                    if let heartbeatInterval = data["heartbeat_interval"] as? Int {
                        print("Heartbeat interval: \(heartbeatInterval)")
                        DispatchQueue.global(qos: .background).async {
                            var rheartbeatTimer = Timer.scheduledTimer(timeInterval: TimeInterval(heartbeatInterval) / 2000, target: self, selector: #selector(sendHeartbeat), userInfo: nil, repeats: true)
                            rheartbeatTimer.fire()
                            RunLoop.current.run()
                        }
                        sendMessage(message: "{\"op\": 2, \"d\": {\"token\": \"\(String(decoding: kread(service: "watchcord", account: "token")!, as: UTF8.self))\",\"properties\": {\"os\": \"watchOS\",\"browser\": \"watchcord\",\"device\": \"watchcord\"}}}")
                    }
                }
            case 11:
                // heartbeat ack
                print("🟣 Heartbeat ACKed :)")
            case 0:
                // dispatch
                print("An event was dispatched.")
                if let t = message["t"] as? String {
                    print("Event type: \(t)")
                    if (t == "MESSAGE_CREATE") {
                        messageCreateSubject.send(message)
                    }
                }
                if (message.description.lengthOfBytes(using: .utf8) > 1000) {
                    print("Received long string. not printing.")
                } else {
                    print("Received String: \(message)")
                }
            default:
                print("⚠️ Unhandled op code: \(op)")
            }
        }
    }

    @objc static func sendHeartbeat() {
        print("🟢 Sending heartbeat")
        sendMessage(message: "{\"op\":1,\"d\":null}")
    }

}
