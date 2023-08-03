//
//  RemoteManager.swift
//  RemoteManager
//
//  Created by Fabio Giannelli on 02/08/23.
//

import Combine

class RemoteManager {
    
    internal static let shared = RemoteManager()
    
    private var cancellables = Set<AnyCancellable>()
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func execute<Res>(
        _ request: URLRequest,
        withSession session: URLSession,
        block: @escaping (DataState<Res>) -> ()
    ) where Res : Decodable {
        httpCall(request: request, withSession: session, block: block)
    }
    
    func httpCall<Res>(
        request: URLRequest,
        withSession session: URLSession,
        block: @escaping (DataState<Res>) -> ()
    ) where Res : Decodable {
        guard let _ = request.url else {
            block(.finished(.failure(DataError.badUrlError)))
            return
        }
        session.dataTaskPublisher(for: request)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Network error - \(err.errorCode) - \(err.localizedDescription)")
                    block(.finished(.failure(DataError.networkError(code: err.errorCode))))
                    break
                case .finished:
                    print("Finished")
                    break
                }
            } receiveValue: { [weak self] output in
                guard let self = self else { return }
                if let response = try? self.decoder.decode(Res.self, from: output.data) {
                    block(.finished(.success(response)))
                }
            }
            .store(in: &cancellables)
    }
}
