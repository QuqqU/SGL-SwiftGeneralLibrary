import Foundation

protocol PriorityQueueProtocol: class {
    associatedtype T
    
    func push(value: T)
    func pop() -> T?
    func top() -> T?
    func clear()
    
    var heap:[T] { get }
    var count:Int { get }
    var isEmpty:Bool { get }
}


class PriorityQueue<T: Comparable>: PriorityQueueProtocol {
    private var _heap = [T]()
    private let order: (T, T) -> Bool
    
    
    init(array: [T], ascending: Bool) {
        order = ascending ? { $0 > $1 } : { $0 < $1 }
        
        for i in 0..<array.count {
            self.push(value: array[i])
        }
    }
    
    public func push(value: T) {
        self._heap.append(value)
        var idx = self._heap.count - 1
        while idx > 0 {
            if order(_heap[idx], _heap[(idx-1)/2]) {
                _heap.swapAt(idx, (idx-1)/2)
            }
            idx = (idx-1)/2
        }
    }
    
    public func pop() -> T? {
        if self.isEmpty {
            return nil
        }
        self._heap.swapAt(0, self.count-1)
        
        var curr = 0
        reviseHeap : while true {
            let left = (curr+1)*2 - 1;
            let right = (curr+1)*2;
            var c = curr;
            
            if left < self.count - 1 && order(self._heap[left], self._heap[c]) { c = left }
            if right < self.count - 1 && order(self._heap[right], self._heap[c]) { c = right }
            if c == curr { break reviseHeap }
            
            _heap.swapAt(curr, c)
            curr = c
        }
        
        return self._heap.removeLast()
    }
    
    public func top() -> T? {
        if self.isEmpty {
            return nil
        }
        return self._heap.first
    }
    
    public func clear() {
        self._heap.removeAll(keepingCapacity: false)
    }
    public var heap: [T] {
        return self._heap
    }
    public var count: Int {
        return self._heap.count
    }
    public var isEmpty: Bool {
        return self._heap.isEmpty
    }
    
}


extension PriorityQueue {
    convenience init() {
        self.init(array: [], ascending: false)
    }
    convenience init(array: [T]) {
        self.init(array: array, ascending: false)
    }
    convenience init(ascending: Bool) {
        self.init(array: [], ascending: ascending)
    }
}


