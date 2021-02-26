//
//  NASAImageLibraryClient.swift
//  NASAImageLibrary
//
//  Created by Raghu, Reshma L on 26/02/21.
//

public struct NASAImageLibraryClient {

    public static func fetchImageCollection(keyword: String, page: Int, completionHandler: @escaping([ImageModel]?, Error?) -> Void) {
        print("========= Requesting for \(keyword) page: \(page) =========")
        // Call the NASA API here
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        let queryItems = [URLQueryItem(name: "q", value: keyword),
                          URLQueryItem(name: "media_type", value: "image"),
                          URLQueryItem(name: "page", value: "\(page)")]
        var urlComponents = URLComponents(string: "https://images-api.nasa.gov/search")
        urlComponents?.queryItems = queryItems
        if let url = urlComponents?.url {
            let request = URLRequest(url: url)
            dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    print("‼️‼️‼️‼️‼️ " + error.localizedDescription)
                    completionHandler(nil, error)
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    let imageCollection = ImageModelBuilder.buildImageModels(data: data)
                    completionHandler(imageCollection, nil)
                }
            })
        }
        dataTask?.resume()
    }
    
    /*func fetchImageCollection(urlString: String, completionHandler: @escaping(CompletionHandler)) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let defaultSession = URLSession(configuration: .default)
            var dataTask: URLSessionDataTask?
            dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    print("‼️‼️‼️‼️‼️ " + error.localizedDescription)
                    completionHandler(nil, error)
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    completionHandler(data, nil)
                }
            })
            dataTask?.resume()
        }
    }
    
    public func fetchImage(urlString: String, completionHandler: @escaping(CompletionHandler)) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let defaultSession = URLSession(configuration: .default)
            var dataTask: URLSessionDataTask?
            dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    print("‼️‼️‼️‼️‼️ " + error.localizedDescription)
                    completionHandler(nil, error)
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    completionHandler(data, nil)
                }
            })
            dataTask?.resume()
        }
    }*/
}
