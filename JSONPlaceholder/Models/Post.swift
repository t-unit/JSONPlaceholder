//
//  Post.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

/* Example Post in JSON:
 {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
 }
 */

struct Post: Codable {

    private enum CodingKeys: String, CodingKey {
        case userIdentifier = "userId"
        case identifier = "id"
        case title
        case body
    }

    let userIdentifier: Int
    let identifier: Int
    let title: String
    let body: String
}
