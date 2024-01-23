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
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}


struct SwiftUIExample: View {
    
    @GET(request: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/6")!)) var todo: DataState<Todo>
    
    var body: some View {
        Text(getTodo())
    }
    
    func getTodo() -> String {
        guard let title = (todo.get { $0.title }) else { return "" }
        return title
    }
}

struct SwiftUIExample_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIExample()
            .environment(\.urlSession, URLSession.shared)
    }
}
