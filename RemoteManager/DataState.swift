//
//  DataState.swift
//  RemoteManager
//
//  Created by Fabio Giannelli on 03/08/23.
//

import Foundation

public enum DataState<T> {
    case idle
    case loading
    case finished(Result<T, Error>)
}
