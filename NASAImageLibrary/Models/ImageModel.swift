//
//  ImageModel.swift
//  NASAImageLibrary
//
//  Created by Raghu, Reshma L on 26/02/21.
//

public struct ImageModel {

    var href: String
    public var description: String
    var nasa_id: String
    var keywords: [String]
    public var title: String
    public var date_created: String

    init(href: String, description: String, nasa_id: String, keywords: [String], title: String, date_created: String) {
        self.href = href
        self.description = description
        self.nasa_id = nasa_id
        self.keywords = keywords
        self.title = title
        self.date_created = date_created
    }

}
