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

extension DataState {
    func get<S>(
        _ onSuccess: (T) -> S,
        onIdle: (() -> S)? = nil,
        onLoading: (() -> S)? = nil,
        onError: ((Error) -> S)? = nil
    ) -> S? {
        switch self {
        case .idle:
            guard let onIdle = onIdle else { return nil }
            return onIdle()
        case .loading:
            guard let onLoading = onLoading else { return nil }
            return onLoading()
        case .finished(let result):
            switch result {
            case .success(let s):
                return onSuccess(s)
            case .failure(let err):
                guard let onError = onError else { return nil }
                return onError(err)
            }
        }
    }
}
