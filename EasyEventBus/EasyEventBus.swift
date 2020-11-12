//
//  EnventBust.swift
//  TestNotification
//
//  Created by kmqq on 2020/11/11.
//

import Foundation

public final class EasyEventBus {
    public static let shared = EasyEventBus()
    
    private var observerMap: [String: [Observer]] = [:]
    
    // MARK: - Publish
    
    /// Post a given event
    /// - Parameter event: The event to post
    public func post<T: EasyEvent>(event: T) {
        guard let observers = observerMap[T.key], observers.count > 0 else {
            print("There is no observer match `\(T.self)` event")
            return
        }
        observers.forEach { (observer) in
            observer.handler(event)
        }
    }
    
    /// Post a given event to a certain object
    /// - Parameters:
    ///   - event: The event to post
    ///   - target: The object that subscribe event
    public func post<T: EasyEvent>(event: T, to target: AnyObject.Type) {
        guard let observers = observerMap[T.key], observers.count > 0 else {
            print("There is no observer match `\(T.self)` event")
            return
        }
        let targetId = UInt(bitPattern: ObjectIdentifier(target))
        observers.forEach { (observer) in
            if observer.targetId == targetId {
                observer.handler(event)
            }
        }
    }
    
    // MARK: - Subscribe
    
    /// Subscribe event notification
    /// - Parameters:
    ///   - event: The event to subscribe
    ///   - target: The object type that subscribe event
    ///   - queue: The `block` execute queue
    ///   - block: The `block` response to event
    public func subscribe<T: EasyEvent>(event: T.Type, target: AnyObject.Type, queue: DispatchQueue = .main, using block: @escaping (T) -> Void) {
        let targetId = UInt(bitPattern: ObjectIdentifier(target))
        let observer = Observer(targetId: targetId) { (event) in
            queue.async {
                if let event = event as? T {
                    block(event)
                } else {
                    fatalError("`\(type(of: event.self))` not match to `\(T.self)`, please check is have same EasyEvent.key.")
                }
            }
        }
        if var observers = observerMap[event.key] {
            observers.append(observer)
            observerMap[event.key] = observers
        } else {
            observerMap[event.key] = [observer]
        }
    }
    
    // MARK: - Remove observer
    
    /// Remove all observer associated with target
    /// - Parameter target: The event observer
    public func remove(target: AnyObject.Type) {
        let targetId = UInt(bitPattern: ObjectIdentifier(target))
        observerMap.forEach { (key, value) in
            var value = value
            value.removeAll { $0.targetId == targetId }
            observerMap[key] = value
        }
    }
    
    /// Remove all observer associated with event
    /// - Parameter event: The event to remove observer
    public func remove<T: EasyEvent>(event: T.Type) {
        observerMap[event.key] = nil
    }
    
    /// Remove all observer associate with target
    /// - Parameters:
    ///   - event: The event to remove observer
    ///   - target: The event observer
    public func remove<T: EasyEvent>(event: T.Type, for target: AnyObject.Type) {
        let targetId = UInt(bitPattern: ObjectIdentifier(target))
        if var observers = observerMap[event.key] {
            observers.removeAll { $0.targetId == targetId }
            observerMap[event.key] = observers
        }
    }
    
    /// Remove all observers
    public func removeAllObservers() {
        observerMap = [:]
    }
}
