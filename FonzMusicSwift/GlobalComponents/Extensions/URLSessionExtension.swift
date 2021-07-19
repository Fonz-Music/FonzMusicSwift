//
//  URLSessionExtension.swift
//  FonzMusicSwift
//
//  Created by didi on 7/19/21.
//

import Foundation
import SwiftUI
//
//extension URLSession {
//    func request(url: URL) -> Future<Data> {
//        // We'll start by constructing a Promise, that will later be
//        // returned as a Future:
//        let promise = Promise<Data>()
//
//        // Perform a data task, just like we normally would:
//        let task = dataTask(with: url) { data, _, error in
//            // Reject or resolve the promise, depending on the result:
//            if let error = error {
//                promise.reject(with: error)
//            } else {
//                promise.resolve(with: data ?? Data())
//            }
//        }
//
//        task.resume()
//
//        return promise
//    }
//}
//
//class Future<Value> {
//    typealias Result = Swift.Result<Value, Error>
//
//    fileprivate var result: Result? {
//        // Observe whenever a result is assigned, and report it:
//        didSet { result.map(report) }
//    }
//    private var callbacks = [(Result) -> Void]()
//
//    func observe(using callback: @escaping (Result) -> Void) {
//        // If a result has already been set, call the callback directly:
//        if let result = result {
//            return callback(result)
//        }
//
//        callbacks.append(callback)
//    }
//
//    private func report(result: Result) {
//        callbacks.forEach { $0(result) }
//        callbacks = []
//    }
//}
//
//class Promise<Value>: Future<Value> {
//    init(value: Value? = nil) {
//        super.init()
//
//        // If the value was already known at the time the promise
//        // was constructed, we can report it directly:
//        result = value.map(Result.success)
//    }
//
//    func resolve(with value: Value) {
//        result = .success(value)
//    }
//
//    func reject(with error: Error) {
//        result = .failure(error)
//    }
//}
