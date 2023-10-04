//
//  QuoteViewModel.swift
//  Quote
//
//  Created by Артем Дорожкин on 12.05.2023.
//

import Foundation

class QuoteViewModel: ObservableObject {
    
    @Published var items = [QuoteModel]()
    @Published var isLoadingPage = false
    private var canLoadMorePages = true
 
    init() {
        Task{
            await loadMoreContent()
        }
    }

    func loadMoreContentIfNeeded(item: QuoteModel?) {
        guard let item = item else {
            Task{
                await loadMoreContent()
            }
          return
        }

            let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
            if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
                Task{
                    await loadMoreContent()
                }
            }
    }
    
    func loadMoreContent() async {
        guard !isLoadingPage && canLoadMorePages else {return}
        await MainActor.run(body: {
            isLoadingPage = true
        })

        let quote = await NetworkManager.shared.getRandomQuote() ?? []

        await MainActor.run{
              self.items += quote
              self.isLoadingPage = false
          }
          
        
   }
}
