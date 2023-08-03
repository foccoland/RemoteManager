//
//  DataError.swift
//  RemoteManager
//
//  Created by Fabio Giannelli on 03/08/23.
//

import Foundation

enum DataError: Error {
    case badUrlError
    case serializationError
    case networkError(code: Int)
}
