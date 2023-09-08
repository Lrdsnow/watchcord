import Foundation

public class extendGuild {
//    @Published var guilds: [Guild] = []
    @Published var fetchError: Bool = false
    
    static func extendGuild(guild: Guild, completion: @escaping (ExtGuild) -> Void) {
        let url = URL(string: "https://discord.com/api/v9/guilds/\(guild.id)?with_counts=true")
        var extguild: ExtGuild = ExtGuild(id: "0", name: "none", ownerid: "", memberCount: 0, onlineCount: 0)
        var ratelimit = false
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)

        request.httpMethod = "GET"
        request.setValue(String(decoding: kread(service: "watchcord", account: "token")!, as: UTF8.self), forHTTPHeaderField: "authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
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

                } else {
                    print("Running Guild ID \(guild.id)")
                    guard let guild = json as? [String: Any] else { return }
                    extguild = ExtGuild(
                        id: guild["id"] as! String,
                        name: guild["name"] as! String,
                        ownerid: guild["owner_id"] as! String,
                        memberCount: guild["approximate_member_count"] as! Int,
                        onlineCount: guild["approximate_presence_count"] as! Int
                    )
                    completion(extguild)
                }
            }
            completion(extguild)
        }
        task.resume()
    }
}
