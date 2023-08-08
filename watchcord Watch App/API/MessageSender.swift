////
// watchcord Watch App
// Created by circular with <3 on 4/8/2023
// please excuse my spaghetti code
//

import Foundation

public class messageSender {
    static func sendMessage(message: String, channel: Channel) -> Message {
        let url = URL(string: "https://discord.com/api/v9/channels/\(channel.id)/messages")
        guard let requestUrl = url else { fatalError() }
        var rdata = DefaultMessage.Error
        
        var request = URLRequest(url: requestUrl)

        request.httpMethod = "POST"
        request.setValue(String(decoding: kread(service: "watchcord", account: "token")!, as: UTF8.self), forHTTPHeaderField: "authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "content": message
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let response = response as? HTTPURLResponse,
                error == nil
            else {
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                rdata = MessageConverter.toMessage(message: json as! [String : Any])!
            }
        }
        task.resume()
        return rdata
    }
}
