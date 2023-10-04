//
//  FavoriteView.swift
//  Quote
//
//  Created by Дарья Петренко on 29.04.2023.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: FavoriteQuote.entity(), sortDescriptors: [])
    private var favoriteQuotes: FetchedResults<FavoriteQuote>
    
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
            NavigationView {
                VStack(spacing: 0) {
                        HStack {
                            Text("Favorites")
                                .font(.system(.largeTitle, design: .rounded, weight: .heavy))
                                    .padding(.top, 30)
                                    .padding(.leading, 20)
                                    
                            Spacer()
                        }.background(Color(uiColor: .tertiarySystemGroupedBackground))
                    
                    List{
                        ForEach(favoriteQuotes) { quote in
                                VStack(alignment: .leading) {
                                    Text(quote.content ?? "It is the time you have wasted for your rose that makes your rose so important.")
                                        .font(.system(.body, design: .rounded, weight: .bold))
                                        .padding(2)
                                    
                                    Text(quote.author ?? "Antoine de Saint-Exupéry")
                                        .font(.system(.subheadline, design: .rounded, weight: .regular))
                                        .italic()
                                        .padding(2)
                                }
                        }.onDelete(perform: deleteQuote(at:))
                    }
                }
            }
        }
    
    func deleteQuote(at offsets: IndexSet) {
        for index in offsets {
            let quote = favoriteQuotes[index]
            viewContext.delete(quote)
        }
        try? viewContext.save()
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
