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
                    guard let _pLeft = p.left else {
                        let newNode = Node<T>(value: key)
                        newNode.parent = p
                        p.left = newNode
                        splay(target: newNode)
                        return
                    }
                    p = _pLeft
                }
                else {
                    guard let _pRight = p.right else {
                        let newNode = Node<T>(value: key)
                        newNode.parent = p
                        p.right = newNode
                        splay(target: newNode)
                        return
                    }
                    p = _pRight
                }
            }
        }
        else { tree = Node<T>(value: key) }
    }
    
    func find(value key: T) -> Bool {
        guard var p = tree else { return false }
        findNode : while true {
            if key == p.key { break }
            if key < p.key {
                guard let pLeft = p.left else { break }
                p = pLeft
            }
            else {
                guard let pRight = p.right else { break }
                p = pRight
            }
        }
        splay(target: p)
        return key == p.key
    }
    
    
}

let a = SplayTree<Int>()
a.insert(value: 50)
a.insert(value: 30)

a.insert(value: 20)
a.insert(value: 40)
a.insert(value: 25)
a.insert(value: 35)
a.insert(value: 100)
a.insert(value: 0)


a.find(value: 44)
//a.find(value: 25)

dump(a)






