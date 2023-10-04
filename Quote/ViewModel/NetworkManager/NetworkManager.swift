//
//  NetworkManager.swift
//  Quote
//
//  Created by Дарья Петренко on 29.04.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    static var shared = NetworkManager()
    private var parser = Parser()
    
    func getRandomQuote() async -> ([QuoteModel]?){
//        print("🌍 getRandomQuote()")
        return await withCheckedContinuation({ continuation in
            AF.request("https://api.quotable.io/quotes/random?limit=30",method: .get)
                .response { response in
                    guard let data = response.data else { return continuation.resume(returning: nil)}
                    guard let quote: [QuoteModel]? = self.parser.parseJSON(with: data) else { return continuation.resume(returning: nil)}
                    continuation.resume(returning: quote)
                }
        })
    }
}
