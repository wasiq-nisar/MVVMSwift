//
//  CardService.swift
//  MVVMSwift
//
//  Created by Muhammad Wasiq  on 15/04/2024.
//

import Foundation

class CardService {
    static let baseURL = "https://db.ygoprodeck.com/api/v7"
    
    private enum Endpoint {
        case cardList
        
        var path: String {
            switch self {
            case .cardList:
                return "/cardinfo.php?archetype=Blue-Eyes"
            }
        }
        
        var url: String {
            switch self {
            case .cardList:
                return "\(baseURL)\(path)"
            }
        }
    }
    
    static func getAllCards(completion: @escaping (Result<[Card], Error>) -> Void) {
        guard let url = URL(string: Endpoint.cardList.url) else {
            completion(.failure("Can Not Convert URL" as! Error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(#function, "🧨 Request: \(request)\nError: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure("Well, weird things happen" as! Error))
                return
            }
            
            do {
                let cards = try JSONDecoder().decode(CardResponse.self, from: data)
                print("Cards Data: ", cards.data.count)
                completion(.success(cards.data))
            } catch let error {
                print(#function, "🧨 Request: \(request)\nError: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
