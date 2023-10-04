//
//  FeedView.swift
//  Quote
//
//  Created by Дарья Петренко on 29.04.2023.
//

import SwiftUI

struct FeedView: View {
    
    var array = (0...6).map { _ in UUID() }
    @State private var showSheet = false
    @State private var showFavoriteSheet = false
    @StateObject var quoteObject = QuoteViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Quote")
                    .font(.system(.largeTitle, design: .rounded, weight: .black))
                    .padding()
                
                Spacer()
                
                Button {
                    showFavoriteSheet = true
                } label: {
                    Image(systemName: "heart.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                }
                .padding()
                .sheet(isPresented: $showFavoriteSheet) {
                    FavoriteView()
                }
                
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .padding(.trailing)
                }
                .sheet(isPresented: $showSheet) {
                    ImageSelectionView()
                }
            }
            
            ScrollView(showsIndicators: false){
                LazyVStack{
                    ForEach(quoteObject.items){ quote in
                        CardView(quote: quote)
                            .onAppear {
                                quoteObject.loadMoreContentIfNeeded(item: quote)
                            }
                    }
                }
            }
        }
    }
    }
    
    struct FeedView_Previews: PreviewProvider {
        static var previews: some View {
            FeedView()
        }
    }

