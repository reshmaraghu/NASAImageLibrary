//
//  ImageModelBuilder.swift
//  NASAImageLibrary
//
//  Created by Raghu, Reshma L on 26/02/21.
//

internal struct ImageModelBuilder {
    static func buildImageModels(data: Data) -> [ImageModel] {
        do {
            if let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let collection = responseDict["collection"] as? [String: Any] {
                    if let items = collection["items"] as? [[String: Any]] {
                        return getModels(items: items)
                    }
                }
            }
        } catch {
            print("‼️‼️‼️‼️‼️ " + error.localizedDescription)
        }
        return [ImageModel]()
    }
    
    private static func getModels(items: [[String: Any]]) -> [ImageModel] {
        var imageModels = [ImageModel]()
        for item in items {
            guard let href = item["href"] as? String,
                  let data = (item["data"] as? [[String: Any]])?[0],
                  let description = data["description"] as? String,
                  let nasa_id = data["nasa_id"] as? String,
                  let keywords = data["keywords"] as? [String],
                  let title = data["title"] as? String,
                  let date_created = data["date_created"] as? String else {
                continue
            }
            let imageModel = ImageModel(href: href, description: description, nasa_id: nasa_id, keywords: keywords, title: title, date_created: date_created)
            imageModels.append(imageModel)
        }
        return imageModels
    }
}
