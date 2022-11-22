//
//  DalliEImageGenerator.swift
//  MakeMeLike
//
//  Created by MM on 17.11.2022.
//

import Foundation

class DalliEImageGenerator {
//    @Published var returnedImageURL: [ImageResponse] = []
//    @Published var returnedData: [ImageGenerationResponseModel] = []
    
    static let shared = DalliEImageGenerator()
    let moderationURL: String = "https://api.openai.com/v1/moderations"
    let getImageUrl: String = "https://api.openai.com/v1/images/generations"
    let sessionID = UUID().uuidString
    
    func moderationTextCheck(wishText: String, key: String) async throws -> Bool {
        guard
            let url = URL(string: moderationURL)
        else {
            print(dali.badURL)
            return false
        }
        
        let parameters: [String: Any] = [
            "input": wishText
        ]
        
        let data = try JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = data
        
        
        let (response, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(ModerationPassModel.self, from: response)
        print("\(String(decoding: response, as: UTF8.self))")
        return result.hasIssues == false
        
    }
    
    func generateImage(wishText: String, key: String) async throws -> ImageGenerationResponseModel {
        guard
            try await moderationTextCheck(wishText: wishText, key: key)
        else {
            print("moderation false")
            throw dali.falseModeration
        }
        guard
            let url = URL(string: getImageUrl)
        else {
            print("url fail")
            throw dali.badURL
        }
        
        let parametersImage: [String: Any] = [
            "prompt": wishText,
            "n": 1,
            "size": "1024x1024"
        ]
        
        let dataJSON: Data = try JSONSerialization.data(withJSONObject: parametersImage)
        print("\(String(decoding: dataJSON, as: UTF8.self)) mk1")
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = dataJSON
        

        let (response, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(ImageGenerationResponseModel.self, from: response)

    }
    
}

enum dali: Error {
    case badURL
    case falseModeration
    case imageGenerationIssues
}
