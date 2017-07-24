//
//  CLLocationCoordinate2D+Coding.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Codable {
    
    private enum CodingError: Error {
        case invalidDoubleString
    }
    
    private enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let latString = try container.decode(String.self, forKey: .lat)
        let lngString = try container.decode(String.self, forKey: .lng)
        
        if let lat = Double(latString), let lng = Double(lngString) {
            latitude = lat
            longitude = lng
        } else {
            throw CodingError.invalidDoubleString
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .lat)
        try container.encode(longitude, forKey: .lng)
    }
}
