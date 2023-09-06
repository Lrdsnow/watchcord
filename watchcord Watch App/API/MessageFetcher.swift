////
// watchcord Watch App
// Created by circular with <3 on 2/8/2023
// please excuse my spaghetti code
//

import Foundation

public class messageFetcher {
    static func getMessages(channel: Channel, completion: @escaping ([Message]) -> Void) {
        let url = URL(string: "https://discord.com/api/v9/channels/\(channel.id)/messages")
        //let url = URL(string: "http://localhost:3000")
        var messages: [Message] = []
        var ratelimit = false
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)

        request.httpMethod = "GET"
        request.setValue(String(decoding: kread(service: "watchcord", account: "token")!, as: UTF8.self), forHTTPHeaderField: "authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                messages.append(DefaultMessage.Error)
                completion(messages)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
                if (response.statusCode == 429) {
                    ratelimit = true
                    //print(response.allHeaderFields)
                }
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                //print("Response data string:\n \(dataString)")
                //returnVal = json
                //print(json)
                if (ratelimit == true) {
                    messages.append(DefaultMessage.RateLimitError)
                } else {
                    // check if the json is a dictionary, then we will see if its an error
                    if let json = json as? Dictionary<String, Any> {
                        if let code = json["code"] as? Int {
                            if (code == 50001) {
                                messages.append(DefaultMessage.AccessError)
                                completion(messages)
                                return
                            }
                        }
                    }
                    for message in json as! [Any] {
                        guard let message = message as? [String: Any] else { continue }
                        guard let author = message["author"] as? [String: Any] else { continue }
                        //print("conv to guild.. \(guild["name"] as! String)")
                        let nmessage = Message(
                            id: message["id"] as! String,
                            type: message["type"] as! Int,
                            content: message["content"] as! String,
                            channel_id: message["channel_id"] as! String,
                            timestamp: DefaultMessage.dateFormatter.date(from: message["timestamp"] as! String) ?? Date(),
                            author: User(
                                id: author["id"] as! String,
                                username: author["username"] as! String,
                                global_name: author["username"] as! String,
                                avatar: author["avatar"] as? String ?? "",
                                discriminator: author["discriminator"] as! String
                            )
                        )
                        messages.append(nmessage)
                    }
                }
            }
            completion(messages)
        }
        task.resume()
    }
}
