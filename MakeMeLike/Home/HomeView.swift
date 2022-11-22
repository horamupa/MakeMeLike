//
//  ContentView.swift
//  MakeMeLike
//
//  Created by MM on 17.11.2022.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm = HomeViewViewModel()
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading) {
                Text("Dear Fairy Godmother,")
                    .font(.title3)
                TextField("please make me like...", text: $vm.requestFieldText, axis: .vertical)
                    .frame(height: 55)
                    .textFieldStyle(.roundedBorder)
                    
                Button {
                    vm.generateImage()
                } label: {
                    let gradient = Gradient(colors: [.red, .yellow])

                    Text("Add some magic")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(RadialGradient(gradient: Gradient(colors: [Color(uiColor: #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)),Color(uiColor: #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1))]), center: .center, startRadius: 20, endRadius: 340))
                        .cornerRadius(10)
                }
                
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 256, height: 256)
                        .padding(.top, 15)
                } else {
                    Rectangle()
                        .frame(width: 256, height: 256)
                        .cornerRadius(10)
                        .foregroundStyle(RadialGradient(gradient: Gradient(colors: [Color(uiColor: #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)),Color(uiColor: #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1))]), center: .center, startRadius: 20, endRadius: 340))
                        .padding(.top, 10)
                        .overlay {
                            if vm.isLoading {
                                Text("Loading...")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
