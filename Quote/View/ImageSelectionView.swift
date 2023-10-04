//
//  ImageSelectionView.swift
//  Quote
//
//  Created by Дарья Петренко on 29.04.2023.
//

import SwiftUI

struct ImageSelectionView: View {
    let images = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    @AppStorage("selectedImage") var selectedImage: String = "1"

    init(){
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.largeTitleTextAttributes = [
                .font : UIFont.systemFont(ofSize: 30, weight: .bold),
                NSAttributedString.Key.foregroundColor : UIColor(.primary)
            ]
            appearance.titleTextAttributes = [
                .font : UIFont.systemFont(ofSize: 20, weight: .bold),
                NSAttributedString.Key.foregroundColor : UIColor(.primary)
            ]
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
            }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Choose an image")
                    .font(.system(.largeTitle, design: .rounded, weight: .heavy))
                        .padding(.top, 30)
                        .padding(.leading, 20)
                Spacer()
            }

            
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 1) {
                        ForEach(images, id: \.self) { imageName in
                            
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .scaledToFill()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(selectedImage == imageName ? Color.primary : Color.clear, lineWidth: 5)
                                )
                                .frame(width: 100)
                                .padding()
                                .onTapGesture {
                                    selectedImage = imageName
                                }
                         }
                    }.padding()
                }
            }
        }
    }
}



struct ImageDetailView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarTitle(Text(imageName), displayMode: .inline)
    }
}


struct ImageSelectionView_Previews: PreviewProvider {
    @State static var selectedImage = "1"
    static var previews: some View {
        ImageSelectionView()
    }
}

