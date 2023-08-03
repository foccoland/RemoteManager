//
//  GET.swift
//  RemoteManager
//
//  Created by Fabio Giannelli on 02/08/23.
//

import SwiftUI

@propertyWrapper
public struct GET<Res>: DynamicProperty where Res : Decodable {
    
    @State public var wrappedValue: DataState<Res> = .idle
    @Environment(\.urlSession) private var urlSession
    public var request: URLRequest
    
    public func update() {
        RemoteManager.shared.execute(
            request,
            withSession: urlSession
        ) { res in
            wrappedValue = res
        }
    }
}
