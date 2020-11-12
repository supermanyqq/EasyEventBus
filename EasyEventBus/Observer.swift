//
//  Observer.swift
//  TestNotification
//
//  Created by kmqq on 2020/11/12.
//

import Foundation

public typealias EventHandler = (EasyEvent) -> Void

public class Observer {
    public var targetId: UInt
    public var handler: EventHandler
    
    init(targetId: UInt, _ handler: @escaping EventHandler) {
        self.targetId = targetId
        self.handler = handler
    }
}
