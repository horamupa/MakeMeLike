//
//  ModerationPassModel.swift
//  MakeMeLike
//
//  Created by MM on 17.11.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dalliE = try? newJSONDecoder().decode(DalliE.self, from: jsonData)

import Foundation

// MARK: - DalliE
struct ModerationPassModel: Codable {
    let id, model: String
    let results: [Result]
    
    var hasIssues: Bool {
        return results.map(\.flagged).contains(true)
    }
    
    // MARK: - Result
    struct Result: Codable {
        let categories: Categories
        let categoryScores: CategoryScores
        let flagged: Bool
        
        enum CodingKeys: String, CodingKey {
            case categories
            case categoryScores = "category_scores"
            case flagged
        }
    }
    
    // MARK: - Categories
    struct Categories: Codable {
        let hate, hateThreatening, selfHarm, sexual: Bool
        let sexualMinors, violence, violenceGraphic: Bool
        
        enum CodingKeys: String, CodingKey {
            case hate
            case hateThreatening = "hate/threatening"
            case selfHarm = "self-harm"
            case sexual
            case sexualMinors = "sexual/minors"
            case violence
            case violenceGraphic = "violence/graphic"
        }
    }
    
    // MARK: - CategoryScores
    struct CategoryScores: Codable {
        let hate, hateThreatening, selfHarm, sexual: Double
        let sexualMinors, violence, violenceGraphic: Double
        
        enum CodingKeys: String, CodingKey {
            case hate
            case hateThreatening = "hate/threatening"
            case selfHarm = "self-harm"
            case sexual
            case sexualMinors = "sexual/minors"
            case violence
            case violenceGraphic = "violence/graphic"
        }
        
    }
}
