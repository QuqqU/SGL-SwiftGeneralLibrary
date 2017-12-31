//
//  main.swift
//  AVLTree
//
//  Created by 성시철 on 2017. 12. 31..
//

import Foundation

protocol AVLTreeProtocol: class {
    associatedtype T
    
    func insert(value key: T)
    func delete(value key: T)
    func search(value key: T) -> Node<T>
}

class Node<T> {
    init(value: T) {
        key = value
    }
    var key: T
    
    var parent: Node?
    var left: Node?
    var right: Node?
    
    var bal: Int = 0
}
