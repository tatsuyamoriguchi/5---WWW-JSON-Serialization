import UIKit


// access the NASA APOD API
var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
urlComponents.queryItems = [
    "api_key": "DEMO_KEY",
    "date": "2013-07-16"
].map { URLQueryItem(name: $0.key, value: $0.value) }
Task {
    // check for a response
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
   // convert the response body to a string, and print
    let jsonDecoder = JSONDecoder()
    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
//       let photoDictionary = try? jsonDecoder.decode([String: String].self, from: data)  {
       let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
        print(photoInfo)
    }
}

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
}


