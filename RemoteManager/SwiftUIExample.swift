//
//  SwiftUIExample.swift
//  RemoteManager
//
//  Created by Fabio Giannelli on 02/08/23.
//

import SwiftUI

struct Person: Encodable {
    let name: String
    let age: Int
}

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}


struct SwiftUIExample: View {
    
    @GET(request: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/3")!)) var todo: DataState<Todo>
    
    var body: some View {
        Text(getTodo())
    }
    
    func getTodo() -> String {
        switch todo {
        case .idle:
            return "Idle"
        case .loading:
            return "Loading"
        case .finished(let result):
            switch result {
            case .success(let s):
                return s.title
            case .failure(let err):
                return "Error: \(err.localizedDescription)"
            }
        }
    }
}

struct SwiftUIExample_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIExample()
            .environment(\.urlSession, URLSession.shared)
    }
}
