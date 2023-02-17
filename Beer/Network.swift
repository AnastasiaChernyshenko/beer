//
//  Network.swift
//  Beer
//
//  Created by mac on 23.11.2022.
//

import Foundation
import Combine

final class Network: ObservableObject {
    
    static let shared = Network()
    
    private let baseUrl = "https://randomuser.me/api/"
    private let numberOfPeople = 10
    
    func getUsers() -> AnyPublisher<Array<UserInfo>, Error> {
        guard let url = URL(string: "\(baseUrl)?results=\(numberOfPeople)") else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher()}
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
