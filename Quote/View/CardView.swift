//
//  CardView.swift
//  Quote
//
//  Created by Дарья Петренко on 29.04.2023.
//

import SwiftUI
import CoreData

struct CardView: View {
    
    @State var quote: QuoteModel
    @AppStorage("selectedImage") var selectedImage: String = "1"
    @Environment(\.managedObjectContext) private var viewContext
    var cardWidth = UIScreen.main.bounds.width - 40
    
    var body: some View {
        ZStack{
                RoundedRectangle(cornerRadius: 50)
                    .shadow(radius: 3)
                    .opacity(0.7)
                 
                Image(selectedImage)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                  
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(.ultraThinMaterial)
            
                VStack{
                    Spacer()
                    
                    Text(quote.content)
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(30)
                        .minimumScaleFactor(0.3)
                    
                    Spacer()
                    
                    HStack{
                       Text(quote.author)
                                .font(.system(.title2, design: .rounded, weight: .regular))
                                .italic()
                                .padding()
                        
                        Spacer()
                        
                        Button {
                            if !quote.isFavorite {
                                let newQuote = FavoriteQuote(context: viewContext)
                                newQuote.id = quote.id
                                newQuote.author = quote.author
                                newQuote.content = quote.content
                                
                                do {
                                    try viewContext.save()
                                    quote.isFavorite = true
                                } catch {
                                    print(error)
                                }
                            } else{
                                let request = FavoriteQuote.fetchRequest()
                                request.predicate = NSPredicate(format: "id == %@", "\(quote.id)")
                                do{
                                    let results = try viewContext.fetch(request)
                                    for result in results{
                                        viewContext.delete(result)
                                        quote.isFavorite = false
                                    }
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                            
                        } label: {
                            Image(systemName: quote.isFavorite ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                     }.padding(50)
                }
            }
        .frame(width: cardWidth, height: cardWidth*1.5)
        .padding(.bottom, 20)
    }
}

struct CardView_Previews: PreviewProvider {
    @State static var selectedImage: String = "1"
    static var previews: some View {
        CardView(quote: QuoteModel(author: "", content: "", tags: []))
    }
}




