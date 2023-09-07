import Foundation

public class guildFetcher {
//    @Published var guilds: [Guild] = []
    @Published var fetchError: Bool = false
    
    static func getGuilds(completion: @escaping ([Guild]) -> Void) {
        let url = URL(string: "https://discord.com/api/v9/users/@me/guilds")
        //let url = URL(string: "http://localhost:3000")
        var guilds: [Guild] = []
        var ratelimit = false
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)

        request.httpMethod = "GET"
        request.setValue(String(decoding: kread(service: "watchcord", account: "token")!, as: UTF8.self), forHTTPHeaderField: "authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                guilds.append(Guild(id: "0", name: "Error", icon: "", owner: false, permissions: "0", features: []))
                completion(guilds)
                return
            }
            
            var statusCode: Int = 0
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
                statusCode = response.statusCode
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
                    guilds.append(Guild(id: "0", name: "Ratelimited", icon: "", owner: false, permissions: "0", features: []))
                } else {
                    guard let json = json as? [Any] else {
                        guilds.append(Guild(id: "0", name: "Error code: \(statusCode)", icon: "", owner: false, permissions: "0", features: []))
                        completion(guilds)
                        return
                    }
                    for guild in json as [Any] {
                        guard let guild = guild as? [String: Any] else { continue }
                        //print("conv to guild.. \(guild["name"] as! String)")
                        guard let _ = guild["id"] as? String else { continue }
                        guard let _ = guild["name"] as? String else { continue }
                        guard let _ = guild["owner"] as? Bool else { continue }
                        guard let _ = guild["permissions"] as? String else { continue }
                        guard let _ = guild["features"] as? [String] else { continue }
                        var nguild = Guild(
                            id: guild["id"] as! String,
                            name: guild["name"] as! String,
                            icon: guild["icon"] as? String ?? "",
                            owner: guild["owner"] as! Bool,
                            permissions: guild["permissions"] as! String,
                            features: guild["features"] as! [String]
                        )
                        if (nguild.icon == "") {
                            nguild.icon = "https://cdn.discordapp.com/icons/1088206123972186143/a_709bd6cb0a63e1290fc7127ed648e627.png"
                        } else {
                            nguild.icon = "https://cdn.discordapp.com/icons/\(nguild.id)/\(nguild.icon).png"
                        }
                        guilds.append(nguild)
                    }
                }
            }
            completion(guilds)
        }
        task.resume()
    }
}
