//
//  ImageGenerationResponseModel.swift
//  MakeMeLike
//
//  Created by MM on 18.11.2022.
//

import SwiftUI

struct ImageGenerationResponseModel: Codable {
    
    let created: Int
    let data: [ImageResponse]
}

struct ImageResponse: Codable {
    let url: URL
}
