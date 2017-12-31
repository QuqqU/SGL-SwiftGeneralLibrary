//: Playground - noun: a place where people can play

import Swift

protocol SplayTreeProtocol: class {
    associatedtype T where T: Comparable
   
    func insert(value key: T)
    func find(value key: T) -> Bool
    func delete(value key: T)
    //k-0based
    func findKthNumber(Kth k:Int) -> Int?
}



class Node<T: Comparable> {
    init(value: T) {
        key = value
    }
    var key: T
    var parent: Node?
    var left: Node?
    var right: Node?
    
    var subtreeSize = 1
}
extension Node: Equatable {
    static func ==(lhs: Node, rhs: Node) -> Bool {
        if lhs.key == rhs.key { return true }
        else { return false }
    }
}

class SplayTree<T: Comparable> : SplayTreeProtocol{
    var tree: Node<T>?
    var size: Int = 0
    
    func updateSubtreeSize(node:Node<T>) {
        node.subtreeSize = 1
        if let _nodeLeft = node.left { node.subtreeSize += _nodeLeft.subtreeSize }
        if let _nodeRight = node.right { node.subtreeSize += _nodeRight.subtreeSize }
    }
    
    func rotate(target me: Node<T>) {
        guard let _myParent = me.parent else { return }
        
        let buffer: Node<T>?
        if _myParent.left == me {
            _myParent.left = me.right
            buffer = me.right
            me.right = _myParent
        }
        else {
            _myParent.right = me.left
            buffer = me.left
            me.left = _myParent
        }
        
        if let _buffer = buffer { _buffer.parent = _myParent }
        me.parent = _myParent.parent
        _myParent.parent = me
        
        if me.parent == nil { tree = me }
        else if _myParent == me.parent?.left { me.parent?.left = me }
        else { me.parent?.right = me }
        
        updateSubtreeSize(node: _myParent)
        updateSubtreeSize(node: me)
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
                        self.size += 1
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
                        self.size += 1
                        return
                    }
                    p = _pRight
                }
            }
        }
        else {
            tree = Node<T>(value: key)
            self.size += 1
        }
    }
    
    func find(value key: T) -> Bool {
        guard var p = tree else { return false }
        findNode : while true {
            if key == p.key { break }
            if key < p.key {
                guard let _pLeft = p.left else { break }
                p = _pLeft
            }
            else {
                guard let _pRight = p.right else { break }
                p = _pRight
            }
        }
        splay(target: p)
        return p.key == key
    }
    
    func delete(value key: T) {
        if !find(value: key) { return }
        
        self.size -= 1
        if self.size == 0 {
            tree = nil
            return
        }

        if tree?.left == nil {
            tree = tree?.right
            tree?.parent = nil
        }
        else if tree?.right == nil {
            tree = tree?.left
            tree?.parent = nil
        }
        else {
            var rightMost = tree?.left
            while rightMost?.right != nil { rightMost = rightMost?.right }
            rightMost?.right = tree?.right
            tree?.right?.parent = rightMost
            
            tree = tree?.left
            tree?.parent = nil
            
            splay(target: rightMost!)
        }
    }
    
    //k-0based
    func findKthNumber(Kth k:Int) -> Int? {
        if k < 0 || self.size < k { return nil }
        
        var a = tree
        while true {
            
        }
        
    }

    
    
    
}



/*
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
a.find(value: 25)

a.delete(value: 5)
a.delete(value: 35)
a.find(value: 20)


a.insert(value: 55)
a.delete(value: 50)

a.insert(value: 1)
a.insert(value: 11)
 a.insert(value: 21)
 a.insert(value: 31)
 a.insert(value: 41)
 a.insert(value: 51)
 a.insert(value: 61)

a.delete(value: 21)
dump(a)
*/




