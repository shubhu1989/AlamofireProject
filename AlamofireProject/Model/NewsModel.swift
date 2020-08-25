//
//  NewsModel.swift
//  AlamofireProject
//
//  Created by CitySpidey on 8/24/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import Foundation

struct UserDetail: Codable {
    let status: String?
    let source: String?
    let sortBy: String?
    let articles: [LiveNewsModel]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case source
        case sortBy
        case articles
    }
}

struct LiveNewsModel: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
    }
    
}

