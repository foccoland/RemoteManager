//
//  URLSessionEnvironment.swift
//  RemoteManager
//
//  Created by Fabio Giannelli on 02/08/23.
//

import SwiftUI

private struct URLSessionKey: EnvironmentKey {
    static let defaultValue: URLSession = {
//        fatalError("URLSession has not been injected. Invoke .environment(KeyPath<URLSession>:value) from your main ContentView.")
        return URLSession.shared
    }()
}

extension EnvironmentValues {
    var urlSession: URLSession {
        get { self[URLSessionKey.self] }
        set { self[URLSessionKey.self] = newValue }
    }
}
