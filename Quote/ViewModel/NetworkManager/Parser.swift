//
//  Parser.swift
//

import Foundation

class Parser {
    
    func parseJSON<T:Decodable>(with data: Data) -> T? {
        let decoder = newJSONDecoder()
        do {
             print(String(data: data, encoding: .utf8) ?? "")
             let obj = try decoder.decode(T.self, from: data)
                return obj
             } catch let error as NSError {
                 print(error.localizedDescription)
                 print(String(data: data, encoding: .utf8) ?? "")
         }
         return nil
    }
    
   private func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
            
        }
        return decoder
    }

    private func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
}
