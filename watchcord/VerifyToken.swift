import Foundation

public class verifyToken {
    @Published var fetchError: Bool = false
    
    static func verify(completion: @escaping (String) -> Void) {
        let url = URL(string: "https://discord.com/api/v9/users/@me")
        var result: String = ""
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)

        request.httpMethod = "GET"
        request.setValue(String(decoding: kread(service: "watchcord", account: "token")!, as: UTF8.self), forHTTPHeaderField: "authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            var statusCode: Int = 0
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
                statusCode = response.statusCode
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                if (statusCode == 401) {
                    result = "Failed to verify, unauthorized."
                } else {
                    guard let json = json as? [String: Any] else {
                        result = "Failed to verify, error code: \(statusCode)"
                        return
                    }
                    result = "Logged in as \(json["username"] as! String)#\(json["discriminator"] as! String)"
                }
            }
            completion(result)
        }
        task.resume()
    }
}
