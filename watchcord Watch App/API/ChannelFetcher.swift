import Foundation

public class channelFetcher {
//    @Published var guilds: [Guild] = []
    @Published var fetchError: Bool = false
    
    static func getChannels(guild: Guild, completion: @escaping ([Channel]) -> Void) {
        let url = URL(string: "https://discord.com/api/v9/guilds/\(guild.id)/channels")
        //let url = URL(string: "http://localhost:3000")
        var channels: [Channel] = []
        var ratelimit = false
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)

        request.httpMethod = "GET"
        request.setValue(String(decoding: kread(service: "watchcord", account: "token")!, as: UTF8.self), forHTTPHeaderField: "authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                channels.append(Channel(id: "0", type: 0, name: "Error", parent: ""))
                completion(channels)
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
                    channels.append(Channel(id: "0", type: 0, name: "Error", parent: ""))
                } else {
                    for channel in json as! [Any] {
                        guard let channel = channel as? [String: Any] else { continue }
                        //print("conv to guild.. \(guild["name"] as! String)")
                        let nchannel = Channel(
                            id: channel["id"] as! String,
                            type: channel["type"] as! Int,
                            name: channel["name"] as! String,
                            parent: channel["parent_id"] as? String ?? ""
                        )
                        channels.append(nchannel)
                    
                    }
                }
            }
            completion(channels)
        }
        task.resume()
    }
}
