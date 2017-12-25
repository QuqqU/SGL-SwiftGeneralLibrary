//: Playground - noun: a place where people can play

import Swift

protocol SplayTreeProtocol: class {
    associatedtype T where T: Comparable
    
    func splay(targe me: Node<T>)
    
}



class Node<T: Comparable> {
    init(value: T) {
        key = value
    }
    var key: T
    var parent: Node?
    var left: Node?
    var right: Node?
}
extension Node: Equatable {
    static func ==(lhs: Node, rhs: Node) -> Bool {
        if lhs.key == rhs.key { return true }
        else { return false }
    }
}

class SplayTree<T: Comparable>{
    var tree: Node<T>?
    
    func rotate(target me: Node<T>) {
        guard let parent = me.parent else { return }
        
        let buffer: Node<T>?
        if parent.left == me {
            parent.left = me.right
            buffer = me.right
            me.right = parent
        }
        else {
            parent.right = me.left
            buffer = me.left
            me.left = parent
        }
        
        if let _buffer = buffer { _buffer.parent = parent }
        me.parent = parent.parent
        parent.parent = me
        
        if me.parent == nil { tree = me }
        else if parent == me.parent?.left { me.parent?.left = me }
        else { me.parent?.right = me }
    }
    
    func splay(target me: Node<T>) {
        while let parent = me.parent {
            let grandParent = parent.parent
            if let _grandParent = grandParent {
                if (me == parent.left) == (parent == _grandParent.left) { rotate(target: parent) }
                else { rotate(target: me) }
            }
            rotate(target: me)
        }
    }
    
    func insert(value key: T) {
        if var p = tree {
            findKeyPlace : while true {
                if key == p.key { return }
                if key < p.key {
                    if let _pLeft = p.left {
                        p = _pLeft
                    }
                    else {
                        let newNode = Node<T>(value: key)
                        newNode.parent = p
                        p.left = newNode
                        splay(target: newNode)
                        return
                    }
                }
                else {
                    if let _pRight = p.right {
                        p = _pRight
                    }
                    else {
                        let newNode = Node<T>(value: key)
                        newNode.parent = p
                        p.right = newNode
                        splay(target: newNode)
                        return
                    }
                }
            }
        }
        else { tree = Node<T>(value: key) }
    }
}







