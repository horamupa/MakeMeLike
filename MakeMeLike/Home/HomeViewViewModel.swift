//
//  HomeViewViewModel.swift
//  MakeMeLike
//
//  Created by MM on 17.11.2022.
//

import SwiftUI

class HomeViewViewModel: ObservableObject {
    @Published var requestFieldText: String = ""
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    init() {
        
    }
    
    func generateImage() {
        //        guard requestFieldText != ""
        Task {
            do {
               let response = try await DalliEImageGenerator.shared.generateImage(wishText: requestFieldText, key: KeyChain.shared.apiKey)
                print("response image - ok")
                if let url = response.data.map(\.url).first {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    image = UIImage(data: data)
//                    #warning("connect loading state to UI")
                    isLoading.toggle()
                } else { print("Can't get an image")}
            } catch let error {
                
                print(error.localizedDescription)
                
            }
            
            //        else { return }
        }
    }
}
