//
//  DataManager.swift
//  MakeMeLike
//
//  Created by MM on 22.11.2022.
//

import SwiftUI
import Combine

class DataManager: ObservableObject {
    
    static let shared = DataManager()
    
    private init() {
        
    }
    
    @Published var returnedImageURL: [ImageResponse] = []
    @Published var returnedData: [ImageGenerationResponseModel] = []
//    @Published var returnedJSON2: [ReturnedLaunchModel] = []
//
    var cansellables = Set<AnyCancellable>()
    
//    private var urlRocket = URL(string: "https://api.spacexdata.com/v4/rockets")!
//    private var urlLaunch = URL(string: "https://api.spacexdata.com/v4/launches")!
//    private var urlQuery = URL(string: "https://api.spacexdata.com/v4/launches/query")!
    
     func downloadLaunchPOST(request: URLRequest) {

        /*
        let parameters: [String: Any] = [
            "upcoming": false
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            // create post request
            var request = URLRequest(url: urlQuery)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        */
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(combineHandler)
            .decode(type: ImageGenerationResponseModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (compeletion) in
                print("Compeletion:\(compeletion)")
            } receiveValue: { [weak self] (returnData) in
                self?.returnedData.append(returnData)
                self?.returnedImageURL.append(contentsOf: returnData.data)
            }
            .store(in: &cansellables)
            
//        } catch {
//            let error = error
//            print(error.localizedDescription)
//        }
    }
    
    private func combineHandler(compeletion: URLSession.DataTaskPublisher.Output ) throws -> Data {
        guard
            let responce = compeletion.response as? HTTPURLResponse,
            responce.statusCode >= 200 && responce.statusCode <= 300 else {
            print("Bad Response")
            throw URLError(.badServerResponse)
        }
        return compeletion.data
    }
    
}
