//
//  User.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation
import CoreLocation

/* Example User in JSON:
 {
     "id": 1,
     "name": "Leanne Graham",
     "username": "Bret",
     "email": "Sincere@april.biz",
     "address": {
         "street": "Kulas Light",
         "suite": "Apt. 556",
         "city": "Gwenborough",
         "zipcode": "92998-3874",
         "geo": {
             "lat": "-37.3159",
             "lng": "81.1496"
         }
     },
     "phone": "1-770-736-8031 x56442",
     "website": "hildegard.org",
     "company": {
         "name": "Romaguera-Crona",
         "catchPhrase": "Multi-layered client-server neural-net",
         "bs": "harness real-time e-markets"
     }
  }
 */

struct User: Decodable {
    
    struct Address: Decodable {
        
        private enum CodingKeys: String, CodingKey {
            case street
            case suite
            case city
            case zipcode
            case coordinate = "geo"
        }
        
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let coordinate: CLLocationCoordinate2D
    }
    
    struct Company: Decodable {
        
        let name: String
        let catchPhrase: String
        let bs: String
    }

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    let identifier: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: URL
    let company: Company
}
