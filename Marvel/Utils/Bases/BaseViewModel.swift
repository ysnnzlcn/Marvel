//
//  BaseViewModel.swift
//  Marvel
//
//  Created by Yasin Nazlican on 31.08.2021.
//

import Foundation

/// Base view model protocol
public protocol ViewModel { }

/// State change protocol
public protocol StateChange { }

/// Base view model class that conforms view model
open class BaseViewModel: NSObject, ViewModel {

    public override init() {}
}

/// Stateful view model class that hold state change handlers and emits state changes
open class StatefulViewModel<SC: StateChange>: BaseViewModel {

    public typealias StateChangeHandler = ((SC) -> Void)

    private var stateChangeHandlers: [String: StateChangeHandler] = [:]

    public var stateChangeHandlersCount: Int {
        stateChangeHandlers.count
    }

    public final func addChangeHandler(identifier: String? = nil, handler: @escaping StateChangeHandler) {
        stateChangeHandlers[identifier ?? ""] = handler
    }

    public final func removeChangeHandler(for identifier: String? = nil) {
        stateChangeHandlers.removeValue(forKey: identifier ?? "")
    }

    public final func emit(change: SC) {
        stateChangeHandlers.values.forEach { (handler: StateChangeHandler) in
            handler(change)
        }
    }
}
